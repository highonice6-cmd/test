-- ReplicatedStorage.VehicleSystem.Config
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Default = {
        EnterDistance = 6,
        EnterHold = 0.5,
        EjectSpeed = 15,
        EjectCarry = 0,
        EjectSide = 16,
        EjectUp = 0,
        EjectUpReverse = 0,
        EjectSlide = 0.6,
        EjectControlAfter = 0.1,
        EjectHold = 1,
        CoastTime = 5,
        MaxSeats = 4,
        TirePart = "Wheel",
        SpinParts = { Wheel = true, Jente = true },
        TopSpeed = 140,
        ReverseSpeed = 55,
        Acceleration = 44,
        ReverseAcceleration = 30,
        SlopeNeutral = true,
        LaunchBoost = 1,
        LaunchBoostSpeed = 31,
        ReverseBoost = 1,
        ReverseBoostSpeed = 20,
        BrakeDecel = 62,
        ReverseStopDecel = 110,
        DriveFront = 0.4,
        RollingResistance = 0.1,
        Drag = 0.0004,
        Downforce = 0.001,
        AirGravity = 57,
        AirPitchFollow = 0.12,
        AirPitchResponse = 3,
        AirPitchMaxRate = 1.5,
        AirControlAccel = 16,
        AirRollRate = 1.6,
        LandingSpeed = 10,
        LandingTime = 0.4,
        LandingSpringCap = 3,
        LandingDamping = 1.8,
        LandingPitchDamp = 8,
        LandingPitchFree = 1.5,
        MaxSteer = 32,
        MinSteer = 8,
        SteerCurve = 1,
        SteerSpeed = 4,
        SteerReturnSpeed = 6,
        TravelUp = 0.45,
        TravelDown = 0.5,
        StaticCompression = 0.3,
        Damping = 0.55,
        AntiRoll = 0.5,
        RollStability = 0.25,
        AngularDamping = 10,
        AirAngularDamping = 1,
        FlipRollSpeed = 2.5,
        FlipResponse = 20,
        FlipMaxSpeed = 8,
        SpringTiltFrom = 0.8,
        SpringTiltTo = 0.5,
        StepHeight = 1.4,
        GripAccel = 58,
        HandbrakeGrip = 0.65,
        HandbrakeDecel = 7,
        SlipSmokeAngle0 = 24,
        SlipSmokeAngle1 = 42,
        SlipSmokeSpeed0 = 3,
        SlipSmokeSpeed1 = 12,
        SlipSmokeRate = 60,
        SlipSmokeAttack = 8,
        SlipSmokeRelease = 5,
        SlipSmokeOpacity = 0.35,
        ParkedBrake = 60,
        PushTime = 6,
        PushedBrake = 13,
        PushedBrakePerSpeed = 2.4,
        ImpactSlowdown = 0.55,
        ImpactMinSpeed = 4,
        CarRestitution = 0.15,
        PushedSideGrip = 0.35,
        PushSlowSpeed = 6,
        PushLockTime = 1.5,
        BurnEntrySpeed = 1,
        BurnHoldSpeed = 3,
        BurnChargeTime = 0.45,
        BurnHoldResponse = 90,
        BurnYawHoldResponse = 70,
        BurnDonutYaw = 1.25,
        BurnYawResponse = 6,
        BurnPivotResponse = 10,
        BurnLaunchHold = 0.8,
        BurnSlipTime = 2.2,
        BurnSlipEndSpeed = 39,
        BurnSlipDrive = 0.55,
        BurnSlipRearGrip = 0.94,
        BurnSlipTorque = 0.7,
        BurnWheelSpin = 70,
        BurnWheelMaxStep = 0.25,
        BurnSmokeRate = 80,
        BurnSmokeAttack = 1.65,
        BurnSmokeRelease = 6.2,
        BurnSmokeHeldExp = 0.9,
        BurnSmokeSlipExp = 1.25,
        BurnSmokeRateExp = 1.05,
        BurnTireVolume = 0.6,
        SkidMarkLife = 10,
        StabilityAssist = 4,
        HandbrakeAssist = 0.3,
        LateralResponse = 0.07,
        ArcadeTraction = 1.5,
        ArcadeTractionMax = 15,
        ArcadeHandbrake = 0.3,
        ArcadeSpeedKeep = 0.8,
        CornerSpeedKeep = 1,
        CornerCoastKeep = 0.8,
        CornerHandbrakeKeep = 0.6,
        CornerDriveKeep = 1,
        BodyRoll = 0.065,
        BodyPitch = 0.06,
        MaxBodyRoll = 4.5,
        MaxBodyPitch = 3,
        BodySpring = 9,
        BodyDamping = 0.45,
        EngineReverb = { Others = { Decay = 1.8, Wet = -9 }, Own = { Decay = 1.2, Wet = -24 } },
        StartRev = {
            Delay = 0.05,
            Peak = 0.95,
            Rise = 0.4,
            Fall = 2.8,
            FallLoad = 0.85,
            Boost = 0.7
        },
        TireSkid = {
            Sounds = { 116964722110481, 123503841885656 },
            Volume = 0.4,
            Rise = 2.5,
            Fall = 1.5,
            BrakeStart = 45,
            RollMin = 10,
            RollMax = 160
        },
        EngineSound = "rbxassetid://80317022777602",
        EngineVolume = 0.8,
        EnginePitchIdle = 0.75,
        EnginePitchMax = 1.6,
        GearFractions = { 0.2, 0.39, 0.585, 0.77, 1 },
        TireHits = 1,
        RimPart = "Jente",
        FlatGrip = 0.4,
        FlatDrag = 0.3,
        FlatPull = 0.5,
        RimSparkSpeed = 4,
        RimScrapeSound = "rbxassetid://110875494296599",
        RimScrape = {
            Volume = 1.4,
            SlowLevel = 0.35,
            FullSpeed = 70,
            PitchSlow = 0.82,
            PitchFast = 1.22,
            Rise = 12,
            Fall = 6,
            Shared = 0.4,
            RollMin = 12,
            RollMax = 170
        },
        AllFlatGripFront = 0.3,
        AllFlatGripRear = 0.2,
        AllFlatTraction = 0.6,
        AllFlatAssist = 0.15,
        AllFlatWobble = 5,
        GlassBreakSound = "rbxassetid://108753671021202",
        TireBurstSound = "rbxassetid://124717533461940",
        TireBurstStart = 0.09,
        TireBurstVolume = 2,
        CrashSounds = {
            Light = 96389689574686,
            Medium = 80646828733892,
            Strong = 77495261532933
        },
        CrashVolume = 1,
        ImpactPitch = 1.2,
        ImpactThin = 0.5,
        MaxHealth = 1000,
        BatHitPitch = 1.07,
        BulletProof = false,
        SmokeWhite = 0.5,
        SmokeBlack = 0.2,
        SmokeRatePerSpeed = 0.75,
        SmokeMaxRate = 80,
        EngineAtRear = false,
        ExplosionRadius = 20,
        ExplosionDamage = 250,
        ExplosionJump = 36,
        ExplosionPitch = 1.6,
        ExplosionRoll = 0.6,
        ExplosionPush = 4,
        WreckTime = 30,
        RocketHits = 1,
        ExplosionSound = "rbxassetid://137000765623636",
        ExplosionFX = "Explosions.RPG_Explosion",
        FireSound = "rbxassetid://9112780193",
        FireDamage = 15,
        FireMargin = 1,
        CameraDistance = 17,
        CameraHeight = 4.5,
        Density = 0.7
    },
    Models = {
        Cayen = {
            Hitbox = {
                Size = Vector3.new( 7.400000095367432, 5.300000190734863, 18.799999237060547 ),
                Offset = Vector3.new( 0, 2.049999952316284, 0.05000000074505806 )
            },
            TopSpeed = 135,
            Acceleration = 39,
            ImpactPitch = 1.12,
            ImpactThin = 0.35,
            GripAccel = 84,
            ArcadeTractionMax = 22,
            ArcadeTraction = 2.2,
            MaxSteer = 34,
            MinSteer = 11,
            SteerSpeed = 5.5,
            SteerReturnSpeed = 6,
            StabilityAssist = 5,
            LateralResponse = 0.07,
            HandbrakeGrip = 0.65,
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.4199999570846558, 0.699999988079071, -0.25 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.4199999570846558, 0.699999988079071, -0.25 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( -1.4199999570846558, 0.75, -4 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.4199999570846558, 0.75, -4 )
                }
            },
            Engine = {
                IdleRPM = 900,
                RedlineRPM = 7000,
                LimiterRPM = 6500,
                Volume = 0.55,
                Gearbox = {
                    DrivePhysics = false,
                    GearTopSpeed = 124,
                    GearSpread = { 0.2286, 0.3714, 0.5333, 0.7143, 0.8571, 1 },
                    TopGearRPM = 4133,
                    ReverseSpread = 0.3,
                    SpeedScale = 2.1,
                    GearAccelExp = 0.6,
                    TorqueLow = 0.8,
                    UpshiftHigh = 6245,
                    UpshiftLow = 6785,
                    ShiftHold = 0.15,
                    LimiterPush = 0.25,
                    DownshiftHigh = 3445,
                    CoastDownAt = 5250,
                    CoastLandRPM = 6460,
                    BrakeDownAt = 1830,
                    BrakeDownshiftTime = 0.25,
                    DownshiftTime = 0.22,
                    BlipTime = 0.18,
                    BlipLoad = 0.85,
                    BlipOvershoot = 375,
                    KickdownRPM = 5170,
                    BrakeLandRPM = 3445,
                    BrakeDecel = 30,
                    BrakeShiftGap = 0.2,
                    HandbrakeShiftGap = 0.15,
                    RevRise = 19385,
                    RevFall = 6460,
                    ShiftRevRate = 48460,
                    LaunchRPM = 2585,
                    ShiftTime = 0.25,
                    ShiftGap = 0.5,
                    ShiftTorque = 0.45,
                    ShiftJitter = 0.25,
                    ShiftRpmJitter = 110,
                    ShiftDip = 0.75,
                    LoadRise = 7,
                    LoadFall = 4
                },
                RollMin = 12,
                RollMax = 200,
                StartDelay = 0.45,
                StartFade = 0.35,
                Curves = {
                    MaxRPM = 7000,
                    idleVol = {
                        { 0, 0, -0.06962, -0.06962 },
                        { 0.01456, 0.65069, -0.07838, -0.07838 },
                        { 0.09945, 0.62389, -0.77397, -0.77397 },
                        { 0.3, 0, -4.52937, -4.52937 }
                    },
                    idlePitch = { { 0, 0.5, 3.5, 3.5 }, { 1, 4, 3.5, 3.5 } },
                    lowVol = {
                        { 0.03001, -0.00581, 7.1801, 7.1801 },
                        { 0.2065, 0.64283, -0.12602, -0.12602 },
                        { 0.4, 0, -2.74702, -2.74702 }
                    },
                    lowPitch = { { 0, 0, 4, 4 }, { 1, 4, 4, 4 } },
                    medVol = {
                        { 0.25, 0, 11.33201, 11.33201 },
                        { 0.38755, 0.66563, -0.32944, -0.32944 },
                        { 0.6, 0, -2.49331, -2.49331 }
                    },
                    medPitch = { { 0, 0, 2, 2 }, { 1, 2, 2, 2 } },
                    highVol = {
                        { 0.3, 0, 3.06721, 3.06721 },
                        { 0.7003, 0.99169, 0.211, 0.211 },
                        { 0.98935, 0.99459, 0, 0 }
                    },
                    highPitch = { { 0, 0, 1, 1 }, { 1, 1, 1, 1 } },
                    maxRPMVol = {
                        { 0.98845, 0, math.huge, math.huge },
                        { 0.98935, 1, 2.29127, 2.29127 },
                        { 1, 1, 0, 0 }
                    }
                },
                Startup = { Id = 138773817750748, Gain = 1 },
                Idle = { Id = 107695424114657, Gain = 1 },
                Layers = {
                    {
                        Name = "low",
                        Rpm = 1750,
                        On = { Id = 130491076927937, Gain = 1 },
                        Off = { Id = 136220956704615, Gain = 1 }
                    },
                    {
                        Name = "med",
                        Rpm = 3500,
                        On = { Id = 76895696465511, Gain = 1 },
                        Off = { Id = 97127808642449, Gain = 1 }
                    },
                    {
                        Name = "high",
                        Rpm = 7000,
                        On = { Id = 109229640416787, Gain = 1 },
                        Off = { Id = 88006084780199, Gain = 1 }
                    }
                },
                Limiter = { Id = 127019376887513, Gain = 1, Rpm = 7000 },
                Interior = {
                    Level = 1,
                    OthersLevel = 0,
                    Startup = { Id = 105073848372021, Gain = 1 },
                    Idle = { Id = 119602791643490, Gain = 1 },
                    Layers = {
                        {
                            Name = "low",
                            Rpm = 1750,
                            On = { Id = 101594499211257, Gain = 1 },
                            Off = { Id = 74561348314516, Gain = 1 }
                        },
                        {
                            Name = "med",
                            Rpm = 3500,
                            On = { Id = 98143131628301, Gain = 1 },
                            Off = { Id = 75116332628086, Gain = 1 }
                        },
                        {
                            Name = "high",
                            Rpm = 7000,
                            On = { Id = 103465312064524, Gain = 1 },
                            Off = { Id = 87989635312367, Gain = 1 }
                        }
                    },
                    Limiter = { Id = 118931941882817, Gain = 1, Rpm = 7000 }
                }
            }
        },
        Challenger = {
            MaxHealth = 1500,
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.3899999856948853, 0.05000000074505806, -0.20000000298023224 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.3899999856948853, 0.05000000074505806, -0.20000000298023224 )
                }
            },
            ImpactPitch = 1.25,
            ImpactThin = 0.55,
            TopSpeed = 155,
            BrakeDecel = 48,
            Acceleration = 45,
            DriveFront = 0.3,
            GripAccel = 84,
            ArcadeTractionMax = 22,
            ArcadeTraction = 2.2,
            MaxSteer = 34,
            MinSteer = 11,
            SteerSpeed = 5.5,
            SteerReturnSpeed = 6,
            StabilityAssist = 5,
            LateralResponse = 0.07,
            HandbrakeGrip = 0.65,
            BodyRoll = 0.025,
            MaxBodyRoll = 1.8,
            BodyPitch = 0.03,
            MaxBodyPitch = 1.5,
            EnginePitchIdle = 0.65,
            EnginePitchMax = 1.45,
            CameraDistance = 16,
            CameraHeight = 4,
            Engine = {
                IdleRPM = 890,
                RedlineRPM = 6500,
                LimiterRPM = 6000,
                Crossfade = 0.7,
                IdleFadeCenter = 0.28,
                Volume = 0.55,
                RpmVolume = 0.45,
                Gearbox = {
                    DrivePhysics = false,
                    GearTopSpeed = 139,
                    GearSpread = { 0.38, 0.6, 0.76, 0.845, 0.9, 1 },
                    TopGearRPM = 5600,
                    ReverseSpread = 0.3,
                    SpeedScale = 2.1,
                    GearAccelExp = 0.6,
                    TorqueLow = 0.8,
                    Ratios = { 4.71, 3.14, 2.1, 1.67, 1.29, 1, 0.84, 0.67 },
                    Reverse = 3.3,
                    FinalDrive = 3.6,
                    TireRadius = 0.36,
                    StudsPerMeter = 3.9,
                    UpshiftHigh = 5800,
                    UpshiftLow = 6300,
                    ShiftHold = 0.15,
                    LimiterPush = 0.25,
                    DownshiftHigh = 3200,
                    CoastDownAt = 4875,
                    CoastLandRPM = 6000,
                    BrakeDownAt = 1700,
                    BrakeDownshiftTime = 0.25,
                    DownshiftTime = 0.22,
                    BlipTime = 0.18,
                    BlipLoad = 0.85,
                    BlipOvershoot = 350,
                    KickdownRPM = 4800,
                    BrakeLandRPM = 3200,
                    BrakeDecel = 30,
                    BrakeShiftGap = 0.2,
                    HandbrakeShiftGap = 0.15,
                    RevRise = 18000,
                    RevFall = 6000,
                    ShiftRevRate = 45000,
                    LaunchRPM = 2400,
                    ShiftTime = 0.25,
                    ShiftGap = 0.5,
                    ShiftTorque = 0.45,
                    ShiftJitter = 0.25,
                    ShiftRpmJitter = 100,
                    ShiftDip = 0.75,
                    LoadRise = 7,
                    LoadFall = 4
                },
                OffLevel = 0.6,
                RollMin = 12,
                RollMax = 200,
                StartDelay = 0.45,
                StartFade = 0.35,
                Startup = { Id = 139878498945755, Gain = 1.6 },
                Curves = {
                    MaxRPM = 6500,
                    idleVol = {
                        { 0, 0, -0.06962, -0.06962 },
                        { 0.00455, 0.88917, -0.07838, -0.07838 },
                        { 0.14286, 0.8557, -0.46244, -0.46244 },
                        { 0.35, 0, -4.21721, -4.21721 }
                    },
                    idlePitch = { { 0, 0.5, 3.5, 3.5 }, { 1, 4, 3.5, 3.5 } },
                    lowVol = {
                        { 0.03001, -0.00581, 4.15775, 4.15775 },
                        { 0.20011, 0.49209, 0, 0 },
                        { 0.4, 0, -2.81903, -2.81903 }
                    },
                    lowPitch = { { 0, 0, 3, 3 }, { 1, 3, 3, 3 } },
                    medVol = {
                        { 0.35024, -0.0042, 2.78881, 2.78881 },
                        { 0.4857, 0.39724, 0.22217, 0.22217 },
                        { 0.65, 0, -2.07122, -2.07122 }
                    },
                    medPitch = { { 0.19797, 0.65572, 1.63829, 1.63829 }, { 1, 2, 1.49324, 1.49324 } },
                    highVol = {
                        { 0, 0.00125, 0, 0 },
                        { 0.43665, 0.8231, 1.03841, 1.03841 },
                        { 0.99187, 0.99398, 0, 0 }
                    },
                    highPitch = { { 0.20633, 0.2452, 1.02555, 1.02555 }, { 1, 1, 0.86759, 0.86759 } },
                    maxRPMVol = {
                        { 0.9916, 0, math.huge, math.huge },
                        { 0.99187, 1, 1.59329, 1.59329 },
                        { 1, 1, 0, 0 }
                    }
                },
                Idle = { Id = 85030532279110, Gain = 1 },
                Layers = {
                    {
                        Name = "low",
                        Rpm = 3010,
                        On = { Id = 93686124707212, Gain = 1 },
                        Off = { Id = 83956284515197, Gain = 1 }
                    },
                    {
                        Name = "med",
                        Rpm = 4510,
                        On = { Id = 126907182314259, Gain = 1 },
                        Off = { Id = 73693749459869, Gain = 1 }
                    },
                    {
                        Name = "high",
                        Rpm = 7310,
                        FadeCenter = 0.2,
                        On = { Id = 71822433771350, Gain = 1 },
                        Off = { Id = 71274130551861, Gain = 1 }
                    }
                },
                Limiter = { Id = 126057173436944, Gain = 1, Rpm = 7300 }
            }
        },
        Lambo = {
            StepAnywhere = true,
            Backfire = {
                Id = 112720519011313,
                Volume = 0.75,
                Pitch = { 1.02, 1.22 },
                Every = { 0.35, 0.9 },
                Burst = { 1, 3 },
                Gap = { 0.07, 0.15 },
                Lift = { 2, 4 },
                Pipes = {
                    Vector3.new( -1.2000000476837158, 0.8600000143051147, -2.9800000190734863 ),
                    Vector3.new( 1.2000000476837158, 0.8600000143051147, -2.9800000190734863 )
                }
            },
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.25, -0.699999988079071, 0.4000000059604645 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.25, -0.699999988079071, 0.4000000059604645 )
                }
            },
            SeatKnee = -10,
            ImpactPitch = 1.38,
            ImpactThin = 0.75,
            TopSpeed = 170,
            Acceleration = 54,
            DriveFront = 0.3,
            GripAccel = 84,
            ArcadeTractionMax = 22,
            ArcadeTraction = 2.2,
            MaxSteer = 34,
            MinSteer = 11,
            SteerSpeed = 5.5,
            StabilityAssist = 5,
            BrakeDecel = 70,
            BodyRoll = 0.007,
            MaxBodyRoll = 0.6,
            BodyPitch = 0.015,
            MaxBodyPitch = 0.8,
            EngineAtRear = true,
            EnginePitchIdle = 0.85,
            EnginePitchMax = 1.8,
            CameraDistance = 15,
            CameraHeight = 3.8,
            Engine = {
                IdleRPM = 960,
                RedlineRPM = 8500,
                LimiterRPM = 8000,
                Crossfade = 0.7,
                IdleFadeCenter = 0.28,
                Volume = 0.55,
                RpmVolume = 0.45,
                Gearbox = {
                    DrivePhysics = false,
                    GearSpread = { 0.4, 0.59, 0.73, 0.835, 0.92, 1 },
                    TopGearRPM = 7800,
                    GearTopSpeed = 156,
                    ReverseSpread = 0.3,
                    SpeedScale = 2.1,
                    TorqueLow = 0.8,
                    UpshiftHigh = 8000,
                    UpshiftLow = 8300,
                    ShiftHold = 0.15,
                    DownshiftHigh = 4200,
                    CoastDownAt = 6375,
                    CoastLandRPM = 7800,
                    BrakeDownAt = 2200,
                    BrakeDownshiftTime = 0.22,
                    BrakeLandRPM = 4200,
                    DownshiftTime = 0.18,
                    BlipTime = 0.15,
                    BlipLoad = 0.9,
                    BlipOvershoot = 450,
                    KickdownRPM = 6300,
                    BrakeDecel = 30,
                    BrakeShiftGap = 0.2,
                    HandbrakeShiftGap = 0.15,
                    RevRise = 24000,
                    RevFall = 7800,
                    ShiftRevRate = 90000,
                    LaunchRPM = 3000,
                    ShiftTime = 0.1,
                    ShiftGap = 0.4,
                    ShiftTorque = 0.45,
                    ShiftJitter = 0.2,
                    ShiftRpmJitter = 130,
                    ShiftDip = 0.7,
                    LoadRise = 7,
                    LoadFall = 4,
                    UpshiftCrackle = { Delay = 0.09, Time = 0.36, Hz = 7, Rpm = 700, Load = 0.6 }
                },
                OffLevel = 0.6,
                RollMin = 12,
                RollMax = 200,
                StartDelay = 0.45,
                StartFade = 0.35,
                Curves = {
                    MaxRPM = 8500,
                    idleVol = {
                        { 0, 0, -0.06962, -0.06962 },
                        { 0.0081, 0.80375, -0.07838, -0.07838 },
                        { 0.23168, 0.76762, -0.46244, -0.46244 },
                        { 0.45073, -0.0077, 0, 0 }
                    },
                    idlePitch = { { 0, 0.5, 3.5, 3.5 }, { 1, 4, 3.5, 3.5 } },
                    lowVol = {
                        { 0.16407, -0.00299, 0.30332, 0.30332 },
                        { 0.27981, 0.64231, 1.57717, 1.57717 },
                        { 0.32095, 0.65193, -0.04868, -0.04868 },
                        { 0.46944, 0.00093, -0.08209, -0.08209 }
                    },
                    lowPitch = { { 0, 0, 3, 3 }, { 1, 3, 3, 3 } },
                    medVol = {
                        { 0.31534, -0.00117, 2.45646, 2.45646 },
                        { 0.42465, 0.47768, 0.42932, 0.42932 },
                        { 0.54767, 0.44388, -1.48586, -1.48586 },
                        { 0.67794, 0, -1.71095, -1.71095 }
                    },
                    medPitch = { { 0, 0, 2, 2 }, { 1, 2, 2, 2 } },
                    highVol = {
                        { 0, 0.00125, 0, 0 },
                        { 0.39162, 0.76667, 2.86624, 2.86624 },
                        { 0.64821, 1, 0.05362, 0.05362 },
                        { 0.99, 1, 0, 0 }
                    },
                    highPitch = { { 0, 0, 1.2, 1.2 }, { 1, 1.2, 1.2, 1.2 } },
                    maxRPMVol = {
                        { 0.97495, 0, math.huge, math.huge },
                        { 0.99, 1, 0, 0 },
                        { 1, 1, 0, 0 }
                    }
                },
                Startup = { Id = 138182017483328, Gain = 1.6 },
                Idle = { Id = 110572649436823, Gain = 1 },
                Layers = {
                    {
                        Name = "low",
                        Rpm = 1500,
                        On = { Id = 93158116343271, Gain = 1 },
                        Off = { Id = 101589371822286, Gain = 1 }
                    },
                    {
                        Name = "med",
                        Rpm = 3000,
                        On = { Id = 113583956969150, Gain = 1 },
                        Off = { Id = 84114009342740, Gain = 1 }
                    },
                    {
                        Name = "high",
                        Rpm = 8000,
                        FadeCenter = 0.25,
                        On = { Id = 120354979691300, Gain = 1 },
                        Off = { Id = 71860465838039, Gain = 1 }
                    }
                },
                Limiter = { Id = 84653184449658, Gain = 1, Rpm = 8000 }
            }
        },
        ClassicCar = {
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.2999999523162842, 1.25, -0.699999988079071 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.2999999523162842, 1.25, -0.699999988079071 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( -1.2999999523162842, 1.4500000476837158, -4.199999809265137 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.2999999523162842, 1.4500000476837158, -4.199999809265137 )
                }
            },
            ImpactPitch = 1.2,
            ImpactThin = 0.45,
            TopSpeed = 120,
            Acceleration = 34,
            GripAccel = 52,
            BrakeDecel = 56,
            BodyRoll = 0.085,
            MaxBodyRoll = 5.5,
            BodySpring = 7,
            BodyDamping = 0.35,
            EnginePitchIdle = 0.6,
            EnginePitchMax = 1.35,
            CameraDistance = 16,
            CameraHeight = 4.8
        },
        ArmoredVehicle = {
            RocketHits = 2,
            Backfire = {
                Id = 112720519011313,
                Volume = 0.95,
                Pitch = { 0.7, 0.82 },
                Every = { 0.6, 1.4 },
                Burst = { 1, 2 },
                Gap = { 0.12, 0.22 },
                Lift = { 1, 3 },
                RollMax = 300,
                Pipes = {
                    Vector3.new( -2.5999999046325684, -0.7400000095367432, -4.329999923706055 ),
                    Vector3.new( 2.5999999046325684, -0.7400000095367432, -4.329999923706055 )
                },
                FlameScale = 1.3
            },
            Headlights = "Emissive",
            ImpactPitch = 1,
            ImpactThin = 0,
            Shell = true,
            MaxFireAngle = 140,
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.399999976158142, 1.649999976158142, 1.100000023841858 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.399999976158142, 1.649999976158142, 1.100000023841858 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( -1.399999976158142, 2.109999895095825, -6.900000095367432 ),
                    NoWeapons = true
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.399999976158142, 2.109999895095825, -6.900000095367432 ),
                    NoWeapons = true
                }
            },
            TopSpeed = 110,
            ReverseSpeed = 45,
            Acceleration = 30,
            ReverseAcceleration = 24,
            BrakeDecel = 50,
            DriveFront = 0.5,
            GripAccel = 84,
            ArcadeTractionMax = 22,
            ArcadeTraction = 2.2,
            MaxSteer = 34,
            MinSteer = 11,
            SteerSpeed = 5.5,
            SteerReturnSpeed = 6,
            StabilityAssist = 5,
            LateralResponse = 0.07,
            HandbrakeGrip = 0.65,
            StepHeight = 1.5,
            BodyRoll = 0.07,
            MaxBodyRoll = 4,
            BodyPitch = 0.06,
            MaxBodyPitch = 2.5,
            BodySpring = 7,
            BodyDamping = 0.4,
            MaxHealth = 4000,
            BatHitPitch = 1,
            BulletProof = true,
            EnginePitchIdle = 0.5,
            EnginePitchMax = 1.2,
            CameraDistance = 21,
            CameraHeight = 6.5,
            Engine = {
                IdleRPM = 900,
                RedlineRPM = 7000,
                LimiterRPM = 6500,
                Volume = 0.55,
                Gearbox = {
                    DrivePhysics = false,
                    GearTopSpeed = 101.6,
                    GearSpread = { 0.2267, 0.3721, 0.5349, 0.7151, 0.8547, 1 },
                    TopGearRPM = 4134,
                    ReverseSpread = 0.3,
                    SpeedScale = 1.5,
                    GearAccelExp = 0.6,
                    TorqueLow = 0.8,
                    UpshiftHigh = 6245,
                    UpshiftLow = 6785,
                    ShiftHold = 0.15,
                    LimiterPush = 0.25,
                    DownshiftHigh = 3445,
                    CoastDownAt = 5250,
                    CoastLandRPM = 6460,
                    BrakeDownAt = 1830,
                    BrakeDownshiftTime = 0.25,
                    DownshiftTime = 0.22,
                    BlipTime = 0.18,
                    BlipLoad = 0.85,
                    BlipOvershoot = 375,
                    KickdownRPM = 5170,
                    BrakeLandRPM = 3445,
                    BrakeDecel = 30,
                    BrakeShiftGap = 0.2,
                    HandbrakeShiftGap = 0.15,
                    RevRise = 19385,
                    RevFall = 6460,
                    ShiftRevRate = 48460,
                    LaunchRPM = 2585,
                    ShiftTime = 0.25,
                    ShiftGap = 0.5,
                    ShiftTorque = 0.45,
                    ShiftJitter = 0.25,
                    ShiftRpmJitter = 110,
                    ShiftDip = 0.75,
                    LoadRise = 7,
                    LoadFall = 4
                },
                RollMin = 12,
                RollMax = 200,
                StartDelay = 0.45,
                StartFade = 0.35,
                Curves = {
                    MaxRPM = 7000,
                    idleVol = {
                        { 0, 0, -0.06962, -0.06962 },
                        { 0.01105, 0.37072, -0.07838, -0.07838 },
                        { 0.15292, 0.35108, -0.46244, -0.46244 },
                        { 0.26321, 0.07163, -0.37387, -0.37387 },
                        { 0.82754, 0.02415, -0.00742, -0.00742 },
                        { 1, 0, -0.31886, -0.31886 }
                    },
                    idlePitch = { { 0, 0.3, 4, 4 }, { 1, 4.3, 4, 4 } },
                    lowVol = {
                        { 0.09992, -0.00048, 11.99666, 11.99666 },
                        { 0.21227, 0.70575, 1e-05, 1e-05 },
                        { 0.4, 0, -10.20995, -10.20995 }
                    },
                    lowPitch = { { 0, 0.4, 2.99559, 2.99559 }, { 1.00147, 3.4, 2.99559, 2.99559 } },
                    medVol = {
                        { 0.25, 0, 6.29644, 6.29644 },
                        { 0.50053, 0.89905, -0.09842, -0.09842 },
                        { 0.89944, -0.00175, -1.36494, -1.36494 }
                    },
                    medPitch = { { 0, 0.3, 2, 2 }, { 1, 2.3, 2, 2 } },
                    highVol = {
                        { 0.50058, 0.0037, 5.00423, 5.00423 },
                        { 0.77803, 1.00199, 0.04453, 0.04453 },
                        { 0.98935, 0.99459, 0, 0 }
                    },
                    highPitch = { { 0, 0, 1.2, 1.2 }, { 1, 1.2, 1.2, 1.2 } },
                    maxRPMVol = {
                        { 0.98845, 0, math.huge, math.huge },
                        { 0.98935, 1, 2.29127, 2.29127 },
                        { 1, 1, 0, 0 }
                    }
                },
                Startup = { Id = 116820933399943, Gain = 1 },
                Idle = { Id = 130286388329776, Gain = 1 },
                Layers = {
                    {
                        Name = "low",
                        Rpm = 2050,
                        On = { Id = 75961659069390, Gain = 1 },
                        Off = { Id = 99806285380105, Gain = 1 }
                    },
                    {
                        Name = "med",
                        Rpm = 3500,
                        On = { Id = 130757335378413, Gain = 1 },
                        Off = { Id = 123465840889227, Gain = 1 }
                    },
                    {
                        Name = "high",
                        Rpm = 5830,
                        On = { Id = 86340297267097, Gain = 1 },
                        Off = { Id = 115299236157190, Gain = 1 }
                    }
                },
                Limiter = { Id = 91135555563529, Gain = 1, Rpm = 5830 },
                Interior = {
                    Level = 1,
                    OthersLevel = 0,
                    Startup = { Id = 131823552086858, Gain = 1 },
                    Idle = { Id = 88753239826768, Gain = 1 },
                    Layers = {
                        {
                            Name = "low",
                            Rpm = 2050,
                            On = { Id = 101774908151128, Gain = 1 },
                            Off = { Id = 119056856416589, Gain = 1 }
                        },
                        {
                            Name = "med",
                            Rpm = 3500,
                            On = { Id = 136791357242812, Gain = 1 },
                            Off = { Id = 90316961317899, Gain = 1 }
                        },
                        {
                            Name = "high",
                            Rpm = 5830,
                            On = { Id = 104625112718633, Gain = 1 },
                            Off = { Id = 123922100073042, Gain = 1 }
                        }
                    },
                    Limiter = { Id = 119397279450244, Gain = 1, Rpm = 5830 }
                }
            }
        },
        CheapCar = {
            Seats = {
                {
                    Role = "Driver",
                    Offset = Vector3.new( -1.3200000524520874, 0.30000001192092896, -0.20000000298023224 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.3200000524520874, 0.30000001192092896, -0.20000000298023224 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( -1.25, 0.3499999940395355, -2.9000000953674316 )
                },
                {
                    Role = "Passenger",
                    Offset = Vector3.new( 1.25, 0.3499999940395355, -2.9000000953674316 )
                }
            },
            ImpactPitch = 1.3,
            ImpactThin = 0.7,
            TopSpeed = 110,
            ReverseSpeed = 40,
            Acceleration = 30,
            ReverseAcceleration = 22,
            BrakeDecel = 48,
            DriveFront = 0.9,
            GripAccel = 50,
            BodyRoll = 0.085,
            MaxBodyRoll = 5,
            BodyPitch = 0.07,
            MaxBodyPitch = 3,
            BodySpring = 7.5,
            BodyDamping = 0.4,
            MaxHealth = 800,
            BatHitPitch = 1.18,
            EnginePitchIdle = 0.9,
            EnginePitchMax = 1.75,
            CameraDistance = 15,
            CameraHeight = 4.2,
            Engine = {
                IdleRPM = 900,
                RedlineRPM = 7000,
                LimiterRPM = 6500,
                Volume = 0.55,
                Gearbox = {
                    DrivePhysics = false,
                    GearTopSpeed = 101.6,
                    GearSpread = { 0.2267, 0.3721, 0.5349, 0.7151, 0.8547, 1 },
                    TopGearRPM = 4134,
                    ReverseSpread = 0.3,
                    SpeedScale = 1.5,
                    GearAccelExp = 0.6,
                    TorqueLow = 0.8,
                    UpshiftHigh = 6245,
                    UpshiftLow = 6785,
                    ShiftHold = 0.15,
                    LimiterPush = 0.25,
                    DownshiftHigh = 3445,
                    CoastDownAt = 5250,
                    CoastLandRPM = 6460,
                    BrakeDownAt = 1830,
                    BrakeDownshiftTime = 0.25,
                    DownshiftTime = 0.22,
                    BlipTime = 0.18,
                    BlipLoad = 0.85,
                    BlipOvershoot = 375,
                    KickdownRPM = 5170,
                    BrakeLandRPM = 3445,
                    BrakeDecel = 30,
                    BrakeShiftGap = 0.2,
                    HandbrakeShiftGap = 0.15,
                    RevRise = 19385,
                    RevFall = 6460,
                    ShiftRevRate = 48460,
                    LaunchRPM = 2585,
                    ShiftTime = 0.25,
                    ShiftGap = 0.5,
                    ShiftTorque = 0.45,
                    ShiftJitter = 0.25,
                    ShiftRpmJitter = 110,
                    ShiftDip = 0.75,
                    LoadRise = 7,
                    LoadFall = 4
                },
                RollMin = 12,
                RollMax = 200,
                StartDelay = 0.45,
                StartFade = 0.35,
                Curves = {
                    MaxRPM = 7000,
                    idleVol = {
                        { 0, 0, -0.06962, -0.06962 },
                        { 0.00482, 0.60403, -0.07838, -0.07838 },
                        { 0.2284, 0.5679, -0.46244, -0.46244 },
                        { 0.45073, -0.0077, 0, 0 }
                    },
                    idlePitch = { { 0, 0.58504, 3.41496, 3.41496 }, { 1, 4, 3.41496, 3.41496 } },
                    lowVol = {
                        { 0.03001, -0.00581, 0.30332, 0.30332 },
                        { 0.13632, 0.17229, 4.25134, 4.25134 },
                        { 0.20473, 0.34464, 1.57717, 1.57717 },
                        { 0.34913, 0.39606, -0.04868, -0.04868 },
                        { 0.47796, -0.00576, -0.08209, -0.08209 }
                    },
                    lowPitch = { { 0, 0, 2.2, 2.2 }, { 1, 2.2, 2.2, 2.2 } },
                    medVol = {
                        { 0.21188, 0, 2.45646, 2.45646 },
                        { 0.33503, 0.25834, 1.70162, 1.70162 },
                        { 0.49352, 0.55875, 0.65338, 0.65338 },
                        { 0.68541, 0.58209, -0.29586, -0.29586 },
                        { 0.86594, 0.13767, -1.71095, -1.71095 },
                        { 1.0019, 0.00124, 0.07352, 0.07352 }
                    },
                    medPitch = { { 0, 0, 2, 2 }, { 1, 2, 2, 2 } },
                    highVol = {
                        { 0, 0.00125, 0, 0 },
                        { 0.56132, 0.76805, 2.86624, 2.86624 },
                        { 0.81791, 0.99532, 0.05362, 0.05362 },
                        { 0.98586, 0.99399, 0, 0 }
                    },
                    highPitch = { { 0, 0, 1, 1 }, { 1, 1, 1, 1 } },
                    maxRPMVol = {
                        { 0.98528, 0, math.huge, math.huge },
                        { 0.98586, 1, 2e-05, 2e-05 },
                        { 1, 1, 0, 0 }
                    }
                },
                Startup = { Id = 101915306946818, Gain = 1 },
                Idle = { Id = 84306745751798, Gain = 1 },
                Layers = {
                    {
                        Name = "low",
                        Rpm = 3180,
                        On = { Id = 108584218422726, Gain = 1 },
                        Off = { Id = 125314729622684, Gain = 1 }
                    },
                    {
                        Name = "med",
                        Rpm = 3500,
                        On = { Id = 74621553585493, Gain = 1 },
                        Off = { Id = 76415304310188, Gain = 1 }
                    },
                    {
                        Name = "high",
                        Rpm = 7000,
                        On = { Id = 133134118654669, Gain = 1 },
                        Off = { Id = 127666903875960, Gain = 1 }
                    }
                },
                Limiter = { Id = 90467459829141, Gain = 1, Rpm = 7000 },
                InteriorDesactive = {
                    Level = 1,
                    OthersLevel = 0,
                    Curves = {
                        MaxRPM = 7000,
                        idleVol = {
                            { 0, 0, -0.06962, -0.06962 },
                            { 0.00482, 0.60403, -0.07838, -0.07838 },
                            { 0.2284, 0.5679, -0.46244, -0.46244 },
                            { 0.45073, -0.0077, 0, 0 }
                        },
                        idlePitch = { { 0, 0.58504, 3.41496, 3.41496 }, { 1, 4, 3.41496, 3.41496 } },
                        lowVol = {
                            { 0.03001, -0.00581, 0.30332, 0.30332 },
                            { 0.135, 0.53291, 4.25134, 4.25134 },
                            { 0.20341, 0.70526, 1.57717, 1.57717 },
                            { 0.34781, 0.75668, -0.04868, -0.04868 },
                            { 0.3796, 0.19323, -4.59379, -4.59379 },
                            { 0.47796, -0.00576, -0.08209, -0.08209 }
                        },
                        lowPitch = { { 0, 0, 2.2, 2.2 }, { 1, 2.2, 2.2, 2.2 } },
                        medVol = {
                            { 0.21188, 0, 2.45646, 2.45646 },
                            { 0.33503, 0.25834, 1.70162, 1.70162 },
                            { 0.48423, 0.88973, 0.65338, 0.65338 },
                            { 0.67611, 0.91308, -0.29586, -0.29586 },
                            { 0.86594, 0.13767, -1.71095, -1.71095 },
                            { 1.0019, 0.00124, 0.07352, 0.07352 }
                        },
                        medPitch = { { 0, 0, 2, 2 }, { 1, 2, 2, 2 } },
                        highVol = {
                            { 0, 0.00125, 0, 0 },
                            { 0.56132, 0.76805, 2.86624, 2.86624 },
                            { 0.81791, 0.99532, 0.05362, 0.05362 },
                            { 0.98586, 0.99399, 0, 0 }
                        },
                        highPitch = { { 0, 0, 1, 1 }, { 1, 1, 1, 1 } },
                        maxRPMVol = {
                            { 0.98528, 0, math.huge, math.huge },
                            { 0.98586, 1, -0.68645, -0.68645 },
                            { 1, 1, 0, 0 }
                        }
                    },
                    Startup = { Id = 108846157066215, Gain = 1 },
                    Idle = { Id = 121164451294282, Gain = 1 },
                    Layers = {
                        {
                            Name = "low",
                            Rpm = 3180,
                            On = { Id = 125461367275209, Gain = 1 },
                            Off = { Id = 103059374101120, Gain = 1 }
                        },
                        {
                            Name = "med",
                            Rpm = 3500,
                            On = { Id = 121682542081705, Gain = 1 },
                            Off = { Id = 123383259050100, Gain = 1 }
                        },
                        {
                            Name = "high",
                            Rpm = 7000,
                            On = { Id = 111594741485133, Gain = 1 },
                            Off = { Id = 109277774811427, Gain = 1 }
                        }
                    },
                    Limiter = { Id = 113980641342092, Gain = 1, Rpm = 7000 }
                }
            }
        }
    }
}
local Models = Table.Models
Models.Lambo_ToitJaune = Table.Models.Lambo
local Models2 = Table.Models
Models2.RubyLambo = Table.Models.Lambo
Table.Models.Lambo.BatHitPitch = 1.12
local Models3 = Table.Models
Models3.ChallengerBlack = Table.Models.Challenger
Table.Models.BM = {
    Backfire = {
        Id = 112720519011313,
        Volume = 0.8,
        Pitch = { 0.92, 1.08 },
        Every = { 0.45, 1.1 },
        Burst = { 1, 2 },
        Gap = { 0.08, 0.17 },
        Lift = { 2, 3 },
        Pipes = {
            Vector3.new( -1.399999976158142, -0.14000000059604645, -4.349999904632568 ),
            Vector3.new( 1.399999976158142, -0.14000000059604645, -4.349999904632568 )
        }
    },
    Seats = {
        {
            Role = "Driver",
            Offset = Vector3.new( -1.5, 0.20000000298023224, -1.25 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( 1.5, 0.20000000298023224, -1.25 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( -1.399999976158142, 0.10000000149011612, -4.199999809265137 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( 1.399999976158142, 0.10000000149011612, -4.199999809265137 )
        }
    },
    MaxHealth = 1000,
    ImpactPitch = 1.22,
    ImpactThin = 0.5,
    TopSpeed = 163,
    Acceleration = 49,
    BrakeDecel = 56,
    DriveFront = 0.3,
    GripAccel = 84,
    ArcadeTractionMax = 22,
    ArcadeTraction = 2.2,
    MaxSteer = 34,
    MinSteer = 11,
    SteerSpeed = 5.5,
    SteerReturnSpeed = 6,
    StabilityAssist = 5,
    LateralResponse = 0.07,
    HandbrakeGrip = 0.65,
    BodyRoll = 0.035,
    MaxBodyRoll = 2.2,
    BodyPitch = 0.035,
    MaxBodyPitch = 1.8,
    CameraDistance = 16.5,
    CameraHeight = 4.2
}
Table.Models[ "208" ] = {
    Seats = {
        {
            Role = "Driver",
            Offset = Vector3.new( -1.350000023841858, 0.5, -0.25 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( 1.350000023841858, 0.5, -0.25 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( -1.2999999523162842, 0.4000000059604645, -3.299999952316284 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( 1.2999999523162842, 0.4000000059604645, -3.299999952316284 )
        }
    },
    MaxHealth = 800,
    ImpactPitch = 1.28,
    ImpactThin = 0.65,
    BatHitPitch = 1.15,
    TopSpeed = 122,
    ReverseSpeed = 45,
    Acceleration = 35,
    ReverseAcceleration = 25,
    BrakeDecel = 54,
    DriveFront = 0.9,
    GripAccel = 64,
    ArcadeTractionMax = 18,
    ArcadeTraction = 1.8,
    MaxSteer = 34,
    MinSteer = 10,
    SteerSpeed = 5,
    StabilityAssist = 4.5,
    BodyRoll = 0.07,
    MaxBodyRoll = 4,
    BodyPitch = 0.06,
    MaxBodyPitch = 2.5,
    BodySpring = 8,
    BodyDamping = 0.42,
    CameraDistance = 15,
    CameraHeight = 4.2
}

local function EngineFrom( Argument1, GearTopSpeed )
    local Clone = table.clone( Argument1 )
    Clone.Gearbox = table.clone( Argument1.Gearbox )
    Clone.Gearbox.GearTopSpeed = GearTopSpeed
    return Clone
end

local Engine = Table.Models.Cayen.Engine
local Engine2 = table.clone( Engine )
Engine2.Gearbox = table.clone( Engine.Gearbox )
Engine2.Gearbox.GearTopSpeed = 148
Engine2.Curves = nil
Engine2.Interior = nil
Engine2.IdleRPM = 1500
Engine2.Crossfade = 0.7
Engine2.IdleFadeCenter = 0.3
Engine2.RpmVolume = 0.45
Engine2.OffLevel = 0.6
Engine2.Idle = { Id = 101836808221783, Gain = 1.46 }
Engine2.Layers = {
    {
        Name = "l1",
        Rpm = 2590,
        On = { Id = 73097021735251, Gain = 1.31 },
        Off = { Id = 111139678349523, Gain = 2.7, Rpm = 2710 }
    },
    {
        Name = "l2",
        Rpm = 3810,
        On = { Id = 84741318325933, Gain = 1.68 },
        Off = { Id = 73836440098323, Gain = 1.61, Rpm = 3780 }
    },
    {
        Name = "l3",
        Rpm = 4510,
        On = { Id = 91061359842449, Gain = 1.51 },
        Off = { Id = 72466143067552, Gain = 1.92, Rpm = 4790 }
    },
    {
        Name = "l4",
        Rpm = 5670,
        On = { Id = 97067751393926, Gain = 1.39 },
        Off = { Id = 138198770516861, Gain = 1.54, Rpm = 5750 }
    },
    {
        Name = "l5",
        Rpm = 6660,
        On = { Id = 111339242994813, Gain = 1.43 },
        Off = { Id = 138198770516861, Gain = 1.54, Rpm = 5750 }
    }
}
Engine2.Limiter = { Id = 121764034925695, Gain = 3, Rpm = 7000 }
Table.Models.BM.Engine = Engine2
local Value1 = Table.Models[ "208" ]
local Engine3 = Table.Models.CheapCar.Engine
local Engine4 = table.clone( Engine3 )
Engine4.Gearbox = table.clone( Engine3.Gearbox )
Engine4.Gearbox.GearTopSpeed = 113
Value1.Engine = Engine4
Table.Models.Vette = {
    StepAnywhere = true,
    Backfire = {
        Id = 112720519011313,
        Volume = 0.8,
        Pitch = { 0.9, 1.06 },
        Every = { 0.4, 1 },
        Burst = { 1, 3 },
        Gap = { 0.07, 0.15 },
        Lift = { 2, 4 },
        Pipes = {
            Vector3.new( -0.550000011920929, -0.15000000596046448, -3.200000047683716 ),
            Vector3.new( 0.550000011920929, -0.15000000596046448, -3.200000047683716 )
        }
    },
    Seats = {
        {
            Role = "Driver",
            Offset = Vector3.new( -1.4500000476837158, -0.25, -0.550000011920929 )
        },
        {
            Role = "Passenger",
            Offset = Vector3.new( 1.4500000476837158, -0.25, -0.550000011920929 )
        }
    },
    SeatKnee = -10,
    ImpactPitch = 1.35,
    ImpactThin = 0.75,
    TopSpeed = 175,
    Acceleration = 56,
    DriveFront = 0.3,
    GripAccel = 86,
    ArcadeTractionMax = 22,
    ArcadeTraction = 2.2,
    MaxSteer = 34,
    MinSteer = 11,
    SteerSpeed = 5.5,
    StabilityAssist = 5,
    BrakeDecel = 72,
    BodyRoll = 0.007,
    MaxBodyRoll = 0.6,
    BodyPitch = 0.015,
    MaxBodyPitch = 0.8,
    EngineAtRear = true,
    EnginePitchIdle = 0.85,
    EnginePitchMax = 1.8,
    CameraDistance = 15,
    CameraHeight = 3.8
}
local Engine5 = Table.Models.Challenger.Engine
local Engine6 = table.clone( Engine5 )
Engine6.Gearbox = table.clone( Engine5.Gearbox )
Engine6.Gearbox.GearTopSpeed = 160
Engine6.Curves = nil
Engine6.Interior = nil
Engine6.IdleRPM = 2290
Engine6.Gearbox.LaunchRPM = 3400
Engine6.Crossfade = 0.7
Engine6.IdleFadeCenter = 0.3
Engine6.RpmVolume = 0.45
Engine6.OffLevel = 0.6
Engine6.Idle = { Id = 127653496510900, Gain = 1.71 }
Engine6.Layers = {
    {
        Name = "l1",
        Rpm = 2720,
        On = { Id = 139027973921138, Gain = 4.97 },
        Off = { Id = 82088920677377, Gain = 5.17 }
    },
    {
        Name = "l2",
        Rpm = 3290,
        On = { Id = 133678978732584, Gain = 2.05 },
        Off = { Id = 134130589236387, Gain = 2.06, Rpm = 3500 }
    },
    {
        Name = "l3",
        Rpm = 4350,
        On = { Id = 104253876062321, Gain = 2.22 },
        Off = { Id = 108182196525825, Gain = 2.03, Rpm = 4090 }
    },
    {
        Name = "l4",
        Rpm = 5150,
        On = { Id = 133301036416822, Gain = 1.5 },
        Off = { Id = 104724387812912, Gain = 1.45, Rpm = 5160 }
    },
    {
        Name = "l5",
        Rpm = 6490,
        On = { Id = 96429292203946, Gain = 1.3 },
        Off = { Id = 84242295418946, Gain = 2.96, Rpm = 7500 }
    }
}
Engine6.Limiter = { Id = 121764034925695, Gain = 3, Rpm = 7000 }
Table.Models.Vette.Engine = Engine6
local Engine7 = {
    IdleRPM = 1000,
    RedlineRPM = 10000,
    Volume = 0.4,
    RpmVolume = 0.5,
    OffLevel = 0.6,
    Crossfade = 0.9,
    IdleFadeCenter = 0.35,
    VolumeSmoothing = 8,
    RollMin = 10,
    RollMax = 160,
    StartDelay = 0.3,
    StartFade = 0.6,
    Gearbox = {
        Electric = true,
        DrivePhysics = false,
        GearTopSpeed = 113,
        GearSpread = { 1 },
        TopGearRPM = 9000,
        ReverseSpread = 1,
        SpeedScale = 1.5,
        LaunchRPM = 1000,
        RevRise = 40000,
        RevFall = 30000,
        LoadRise = 6,
        LoadFall = 3,
        ShiftDip = 1
    },
    Startup = { Id = 118312538969678, Gain = 0.7 },
    Idle = { Id = 95921529845150, Gain = 0 },
    Layers = {
        {
            Name = "drive",
            On = { Id = 95921529845150, Gain = 3 },
            Off = { Id = 95921529845150, Gain = 2.2 }
        }
    },
    Curves = {
        MaxRPM = 10000,
        idleVol = { { 0, 0, 0, 0 }, { 1, 0, 0, 0 } },
        idlePitch = { { 0, 1, 0, 0 }, { 1, 1, 0, 0 } },
        driveVol = { { 0.1, 0.35, 0, 0 }, { 0.3, 1, 0, 0 }, { 1, 1, 0, 0 } },
        drivePitch = {
            { 0.1, 0.85, 0.5, 0.5 },
            { 0.9, 1.25, 0.5, 0.5 },
            { 1, 1.28, 0.3, 0.3 }
        }
    }
}

if Engine7.Idle.Id ~= 0 and Engine7.Layers[ 1 ].On.Id ~= 0 then
    Table.Models[ "208" ].Engine = Engine7
end

Table.Models.Scooter = {
    Wheels = {
        { Name = "Scooter_Wheel_AV", Front = true },
        { Name = "Scooter_Wheel_AR", Front = false }
    },
    TwoWheels = true,
    FrontRake = 27,
    Armor = false,
    MaxSeats = 2,
    Seats = {
        { Role = "Driver", Offset = Vector3.new( 0, 2.049999952316284, -1 ) },
        {
            Role = "Passenger",
            Offset = Vector3.new( 0, 2.4000000953674316, -2.799999952316284 )
        }
    },
    SeatKnee = -80,
    BrakeLights = "RearLights",
    MaxHealth = 500,
    ImpactPitch = 1.45,
    ImpactThin = 0.85,
    BatHitPitch = 1.25,
    TopSpeed = 102,
    ReverseSpeed = 18,
    Acceleration = 40,
    ReverseAcceleration = 14,
    BrakeDecel = 52,
    DriveFront = 0,
    GripAccel = 60,
    ArcadeTractionMax = 18,
    ArcadeTraction = 2,
    MaxSteer = 18,
    MinSteer = 7,
    SteerSpeed = 3,
    SteerReturnSpeed = 4.5,
    StabilityAssist = 3.2,
    AirRollRate = 0,
    FlatPull = 0,
    BodyRoll = 0,
    MaxBodyRoll = 0,
    BodyPitch = 0,
    MaxBodyPitch = 0,
    RollStability = 1,
    UprightFreq = 9,
    UprightMaxAccel = 80,
    LeanG = 110,
    LeanMax = 32,
    LeanSpring = 5,
    LeanDamping = 0.9,
    WheelieAngle = 32,
    WheelieRise = 20,
    WheelieRiseAtTop = 0.5,
    WheelieFallAccel = 220,
    WheelieFallMax = 140,
    WheelieBrakeFall = 2,
    WheelieResponse = 8,
    WheelieSteer = 0.5,
    EngineAtRear = true,
    CameraDistance = 12,
    CameraHeight = 4
}

local function ScooterEngine( Argument1, GearTopSpeed, Argument3 )
    local Value1
    local Clone = table.clone( Argument1 )
    Clone.Gearbox = table.clone( Argument1.Gearbox )
    Clone.Gearbox.GearTopSpeed = GearTopSpeed
    Clone.Gearbox.GearSpread = { 1 }
    Clone.Gearbox.TopGearRPM = 6300
    Clone.Gearbox.LaunchRPM = 4700
    Clone.Gearbox.SpeedScale = 1.15
    Clone.Curves = table.clone( Argument1.Curves )
    local Curves = Argument1.Curves
    Value1 = nil

    for Key, Value in Curves, nil, nil do
        if type( Value ) == "table" and Key:sub( -5 ) == "Pitch" then
            local Value2
            local Table = { }
            Value2 = nil

            for Key2, Value3 in Value, nil, nil do
                Table[ Key2 ] = {
                    Value3[ 1 ],
                    Value3[ 2 ] * Argument3,
                    Value3[ 3 ] * Argument3,
                    Value3[ 4 ] * Argument3
                }
            end

            Clone.Curves[ Key ] = Table
        end
    end

    return Clone
end

local Scooter = Table.Models.Scooter
Scooter.Engine = ScooterEngine( Table.Models.CheapCar.Engine, 97, 1.3 )
function Table.Get( List )
    if not ( List and Table.Models[ List ] ) then
        return nil
    end

    local Clone = table.clone( Table.Default )

    for Key, Value in pairs( List and Table.Models[ List ] ) do
        Clone[ Key ] = Value
    end

    return Clone
end
return Table
