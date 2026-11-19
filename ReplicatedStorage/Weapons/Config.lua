-- ReplicatedStorage.Weapons.Config
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table2 = {
    RollTimeScale = 1.7,
    RollEnd = 1.3,
    RollBackStart = 1.2,
    RollCooldown = 0.5,
    RollDistance = 1.2,
    JumpCooldown = 1,
    JumpGravity = 125,
    BloomScale = 0.8,
    MaxHealth = 100,
    InfiniteAmmo = true,
    VehicleReloadMul = 2,
    FarDamageScale = 0.9,
    MoveSpeedMul = 0.95,
    WalkSpeed = 18,
    AimSprintMultiplier = 1.35,
    SprintSpeed = 26,
    CrouchSpeed = 8,
    HipFOV = 70,
    SprintFOVAdd = 6,
    Camera = {
        Distance = 8,
        Side = 1.6,
        Height = 1.7,
        SprintDistance = 8.8,
        AimDistance = 4.3,
        AimSide = 1.6,
        AimHeight = 1.7,
        AimSensitivity = 0.7,
        MinPitch = -75,
        MaxPitch = 70
    },
    TurnSpeed = 14,
    SprintTurnSpeed = 9,
    CombatTurnSpeed = 28,
    CombatLinger = 1.2,
    HitSound = "rbxassetid://138148057831879",
    KillReward = 100
}

local function R( Argument1, Argument2, Argument3 )
    return CFrame.fromOrientation( math.rad( Argument1 ), math.rad( Argument2 ), ( math.rad( Argument3 ) ) )
end

local function P( Argument1, Argument2, Argument3, Argument4, Argument5, Argument6 )
    return CFrame.new( Argument1, Argument2, Argument3 ) * CFrame.fromOrientation( math.rad( Argument4 ), math.rad( Argument5 ), ( math.rad( Argument6 ) ) )
end

local Table3 = {
    Gun = CFrame.new( 0.5343, -0.1874, -0.6829 ) * CFrame.fromOrientation( -0.45029145635603307, 1.1647611842816838, 0.08578816872327728 ),
    Waist = CFrame.fromOrientation( -0, 0, 0 ),
    Neck = CFrame.fromOrientation( -0, 0, 0 ),
    RightShoulder = CFrame.fromOrientation( -0, 0, 0.447223167531027 ),
    RightElbow = CFrame.fromOrientation( 1.1587921582398633, -0.8417496089565892, -1.7999475856062401 ),
    RightWrist = CFrame.fromOrientation( -0.18791785523297747, 0.017357299411083608, -0.10908831423740158 ),
    LeftShoulder = CFrame.fromOrientation( 0.08770279491271507, 0.005363396791378575, 0.15102508550432134 ),
    LeftElbow = CFrame.fromOrientation( -0.41033737911937884, 1.0833171400666204, 1.4503755897242958 ),
    LeftWrist = CFrame.fromOrientation( 0.07275579519863562, -0.17523978354649064, 0.3786928144514697 ),
    RightHand = CFrame.new( -0.0364, -0.0783, 0.0153 ) * CFrame.fromOrientation( 1.261989986251784, -1.6697128621516752, -1.5739065035219506 ),
    LeftHand = CFrame.new( -0.1265, 0.1072, -1.0154 ) * CFrame.fromOrientation( 0.11876791026896213, -0.07860090286356462, 1.8524104375919377 )
}
local Table4 = {
    Aim = {
        Twist = -35,
        Gun = CFrame.new( -0.1475, 0.7357, -1.0709 ) * CFrame.fromOrientation( 0.24026377015879138, 0.6317271587471036, 0.1724001328534959 ),
        Waist = CFrame.fromOrientation( -0.2947424774305424, 0, -0 ),
        Neck = CFrame.fromOrientation( -0.038849283820141786, 0.4176398367097231, -0.24209112988562945 ),
        RightShoulder = CFrame.fromOrientation( 0.4335624754756674, 1.1072438587822107, 0.7792580950889323 ),
        RightElbow = CFrame.fromOrientation( 1.3550474513096173, 0.37797199347039595, 0.08312828694323793 ),
        RightWrist = CFrame.fromOrientation( 4.8869219055841225e-05, -0.4679140458134198, 0.2780030245746648 ),
        LeftShoulder = CFrame.fromOrientation( 0.7613876688777623, -0.7966258664755279, -0.8399397025222711 ),
        LeftElbow = CFrame.fromOrientation( 0.15633612241814007, 1.4242759360899726, 1.3485757704432226 ),
        LeftWrist = CFrame.fromOrientation( -0, 0.7853999087267004, 0 ),
        RightHand = CFrame.new( 0.0409, -0.0974, -0.0804 ) * CFrame.fromOrientation( 1.4571736471608139, 1.7173865306699003, 1.4500317598616528 ),
        LeftHand = CFrame.new( -0.1468, 0.0942, -0.8751 ) * CFrame.fromOrientation( -0.029832912904339075, 0.3373669084227479, 1.8660379683915094 )
    },
    Low = Table3,
    Sprint = Table3,
    Reload = {
        GripStart = CFrame.new( -0.02878, -0.02836, -0.07783, 0.91558, -0.39798, 0.05776, -0.0044, 0.1337, 0.99101, -0.40213, -0.9076, 0.12066 ),
        GripMid = CFrame.new( -0.02878, -0.02835, -0.07784, 0.90552, -0.39798, 0.14713, -0.10141, 0.1337, 0.98582, -0.41201, -0.9076, 0.08071 ),
        GripMidT = 0.4,
        Gun = CFrame.new( -0.176, -0.1238, -1.088 ) * CFrame.fromOrientation( -0.13962634015954636, 0.6108652381980153, 0.6108652381980153 ),
        Waist = CFrame.fromOrientation( -0, 0, 0 ),
        Neck = CFrame.fromOrientation( -0, 0, 0 ),
        RightShoulder = CFrame.fromOrientation( 0.20088565157529534, 0.72887393024236, -0.07557799259911045 ),
        RightElbow = CFrame.fromOrientation( 1.1219185871329789, 0.9754540469641189, 0.7482819915245368 ),
        RightWrist = CFrame.fromOrientation( -0, 0, 0 ),
        LeftShoulder = CFrame.fromOrientation( 0.5266635737648009, -0.43434438298056083, -0.26514343864597056 ),
        LeftElbow = CFrame.fromOrientation( 0.6789435510013061, -0.356113489918419, -0.20226795234287484 ),
        LeftWrist = CFrame.fromOrientation( -0, 0, 0 ),
        RightHand = CFrame.new( -0.1521, 0.0032, 0.1253 ) * CFrame.fromOrientation( 1.2412240588115553, -1.93046679772888, -2.1990310817087595 ),
        LeftHand = CFrame.new( -0.0781, 0.1161, -0.7269 ) * CFrame.fromOrientation( 0.3565131703171257, -1.8977261662907186, -0.877497442695937 )
    }
}
local Table5 = {
    CycleLength = 12,
    UseFastRun = true,
    Bob = 0.06,
    TorsoTwist = 5,
    TorsoRoll = 1.5,
    HipLean = 14,
    PelvisYaw = 7,
    PelvisRoll = 4,
    LegSpread = -1.5,
    Bounce = 0.18,
    BasePhaseOffset = 0,
    FlightStart = 0.6,
    ArmSwing = 0.35,
    CadenceBase = 1,
    CadencePerSpeed = 0.03,
    MinIntensity = 0.6,
    Springs = {
        Legs = { 9, 0.9 },
        Root = { 6, 0.75 },
        Waist = { 4, 0.45 },
        Neck = { 3.5, 0.55 },
        Arms = { 5, 0.5 },
        Gun = { 4.5, 0.45 }
    },
    SwingKnee = 45,
    MinSpeed = 1.5,
    Poses = {
        {
            Root = CFrame.new( -0, -0.35, 0 ) * CFrame.fromOrientation( -0.24434609527920614, -0, -0 ),
            Waist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.37070793312359557, 0, -0 ),
            Neck = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, -0, -0 ),
            RightShoulder = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.1276708347833852, 0.06161012259539983, 0.4511676116405342 ),
            RightElbow = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 1.1587939035691153, -0.8417548449443452, -1.4805802577593097 ),
            RightWrist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.18791960056222945, 0.017366026057343577, -0.1090830782496456 ),
            LeftShoulder = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 1.018504338293811, 0.027977627909469102, 0.19514526366548599 ),
            LeftElbow = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 0.034400439556808236, -0.2609441764656722, 0.5899911003441632 ),
            LeftWrist = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( -0.01699950691442477, 1.07114346853396, 0.36271432514946156 ),
            RightHip = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 1.1924787581326057, 0.09834930334988047, 0.13168509206297216 ),
            RightKnee = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( -1.2279787551181705, -0, -0 ),
            RightAnkle = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.26281167876530614, 0.08922123136195013, -0.0009773843811168245 ),
            LeftHip = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.33923964671013784, -0.010192722831646885, -0.04808382089244378 ),
            LeftKnee = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( -0.6801024496246304, -0.26933921016776496, 0.13149310584525278 ),
            LeftAnkle = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( -0.5235987755982988, -0, 0 ),
            Gun = CFrame.new( 0.7219, -0.124, -1.0242 ) * CFrame.fromOrientation( -0.17357299411083607, 0.6503271325856071, 0.22228513353399781 ),
            RightHand = CFrame.new( 0.0202, -0.0252, 0.0948 ) * CFrame.fromOrientation( 1.2971112467896657, -0.7041356334245923, -0.8095535202450498 ),
            LeftHand = CFrame.new( -0.2186, 0.2282, -0.934 ) * CFrame.fromOrientation( 0.3937462792499207, -0.22750366799746086, 1.157013667732081 )
        },
        {
            Root = CFrame.new( -0, -0.35, 0 ) * CFrame.fromOrientation( -0.24434609527920614, -0, -0 ),
            Waist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.37070793312359557, 0, -0 ),
            Neck = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.4363323129985824, -0, -0 ),
            RightShoulder = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 0.6551267880285916, 0.8747590210995579, 0.948918061016797 ),
            RightElbow = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.5939180911611505, -0.672824426643814, -1.6373457311734405 ),
            RightWrist = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( -0.014625859131712481, -0.18921114420870525, -0.10629055144645466 ),
            LeftShoulder = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 0.5480333851262195, 0.17376498032855545, -0.0879645943005142 ),
            LeftElbow = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.9474868910301617, 0.8573231818721346, 1.4940541995847059 ),
            LeftWrist = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( 0.1134813079646713, 1.296448021673908, 0.4476245932589857 ),
            RightHip = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( -0.2833891106463193, -0.038257617203715705, 0.05052728184523584 ),
            RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.6396806241484417, -0, -0 ),
            RightAnkle = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 0.26281167876530614, 0.08922123136195013, -0.0009773843811168245 ),
            LeftHip = CFrame.new( 0.015, 0.0535, -0.088 ) * CFrame.fromOrientation( 1.1303624900541276, -0.22076669708476274, -0.3214547416323156 ),
            LeftKnee = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.9699841850883686, -0.32377602953746804, 0.3929957876715632 ),
            LeftAnkle = CFrame.new( -0.0001, 0.0001, -0.0001 ) * CFrame.fromOrientation( 0.11636110123046195, 0.0555887366760194, 0.054628805587422516 ),
            Gun = CFrame.new( -0.0596, 0.5935, -0.9572 ) * CFrame.fromOrientation( -0.07572983624403397, 1.353712274431842, 0.00947713783832921 ),
            RightHand = CFrame.new( 0.0638, -0.0575, 0.0321 ) * CFrame.fromOrientation( 1.454627211782154, -0.8592255907568084, -1.0285225282002584 ),
            LeftHand = CFrame.new( 0.0228, -0.0094, -0.9478 ) * CFrame.fromOrientation( 0.09325294193405703, -0.17121679962064373, 2.3378859863389243 )
        }
    }
}
local Table6 = {
    {
        Root = CFrame.new( 0, -0.0121, 0 ) * CFrame.fromOrientation( -0.24249604627209215, 0.12587314565383104, -0.030368728984701335 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37070793312359557, -0.20943951023931956, 0 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 0.01635373509118687, 0.44511131913611385, 0.5971644035698599 ),
        RightElbow = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 1.192391491670006, 1.6038528628276694, 1.345980465845507 ),
        RightWrist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.1244419756671957, -0.876888322786991, -0.3932052271818025 ),
        LeftShoulder = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 0.3259053312249011, -0.7424281572133479, -0.4579045825532323 ),
        LeftElbow = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 0.862140290607639, -0.5022883054314481, -0.3200410249382002 ),
        LeftWrist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.21254619630786947, 2.068948201899118, 0.5146975964131277 ),
        RightHip = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 1.0380171193311074, 0.06843435997069766, 0.09815731713216108 ),
        RightKnee = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( -0.9463524270163653, -0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.03490658503988659, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.1279849940487442, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -1.3909750539619208, 0, 0 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.4245862471326606, 0, 0 ),
        Gun = CFrame.new( 0.4679, 0.1092, -1.0024 ) * CFrame.fromOrientation( -0.1585457092511649, 0.8820370440803743, 0.14580480571160628 ),
        RightHand = CFrame.new( 0.0344, -0.0357, 0.0744 ) * CFrame.fromOrientation( 1.348807899233738, -0.7254111970064032, -0.8517032216807129 ),
        LeftHand = CFrame.new( -0.1401, 0.151, -0.9385 ) * CFrame.fromOrientation( 0.30590385799704617, -0.16730726209617644, 1.5542506054859904 )
    },
    {
        Root = CFrame.new( 0, -0.2673, 0 ) * CFrame.fromOrientation( -0.24342107077564912, 0.0890117918517108, 0.027855454861829502 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37041122715075653, -0.1327497429066887, -0.04235914094590238 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.02790781473938933, 0.4831245902445504, 0.6228731034517364 ),
        RightElbow = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 1.1921296922822069, 1.6204160374290955, 1.3618106021610956 ),
        RightWrist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.12723450247038662, -0.9148666873103877, -0.3974114706791088 ),
        LeftShoulder = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 0.33536501577071043, -0.6747268355284879, -0.4233121567787047 ),
        LeftElbow = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 0.9073617715268121, -0.551244790949889, -0.3619289269860641 ),
        LeftWrist = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( -0.20612338466053032, 2.0682326169058007, 0.5097234080449439 ),
        RightHip = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 0.17564993592070932, -0, -0.006597344572538566 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.48010517063860014, 0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.29042278753185646, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.3649483465920143, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.9589711575082843, 3.141592653589793, 3.141592653589793 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.16627751783749975, 0, 0 ),
        Gun = CFrame.new( 0.4279, 0.146, -0.999 ) * CFrame.fromOrientation( -0.15460126514165773, 0.9183747991068962, 0.1341634596008041 ),
        RightHand = CFrame.new( 0.0366, -0.0373, 0.0712 ) * CFrame.fromOrientation( 1.3569934934255912, -0.7301933991568678, -0.8597142829473668 ),
        LeftHand = CFrame.new( -0.1278, 0.1388, -0.9392 ) * CFrame.fromOrientation( 0.29030061448421685, -0.1614604091019954, 1.6153022227207519 )
    },
    {
        Root = CFrame.new( 0, -0.4322, 0 ) * CFrame.fromOrientation( -0.24434609527920614, 0, 0.06981317007977318 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37009706788539753, 0.021694442602289518, -0.05991715322096533 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.05614724203665758, 0.5806535888459935, 0.6898239335582388 ),
        RightElbow = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 1.1919027994794476, 1.6311498123288606, 1.3720731381628224 ),
        RightWrist = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( -0.12534954687823274, -1.0090621070405217, -0.4097334951981888 ),
        LeftShoulder = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.3525041490252947, -0.5264087556940098, -0.3510380724536195 ),
        LeftElbow = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.9970716950793206, -0.6753726073517258, -0.4715879638888678 ),
        LeftWrist = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.1943075056245287, 2.074184189655101, 0.5106135259634611 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.08018042583661951, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.2983640356284306, 0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.050335295627516465, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.8137597637423561, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -1.3929821826017144, 3.141592653589793, 3.141592653589793 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.03961897402027128, 0, 0 ),
        Gun = CFrame.new( 0.3311, 0.2348, -0.9907 ) * CFrame.fromOrientation( -0.14339625134385411, 1.005815794631812, 0.10676179034449314 ),
        RightHand = CFrame.new( 0.042, -0.0413, 0.0634 ) * CFrame.fromOrientation( 1.3765586343404477, -0.7438418739074633, -0.8813214590870567 ),
        LeftHand = CFrame.new( -0.0979, 0.1094, -0.9409 ) * CFrame.fromOrientation( 0.25148449191986294, -0.1516167521207474, 1.7611942948949582 )
    },
    {
        Root = CFrame.new( 0, -0.1348, 0 ) * CFrame.fromOrientation( -0.24342107077564912, -0.0890117918517108, 0.07087782092348972 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37041122715075653, 0.16343263115674903, -0.04235914094590238 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 0.08297295263981042, 0.685460610428253, 0.7633895615297998 ),
        RightElbow = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 1.192443851547566, 1.5992975534799638, 1.3416171427155212 ),
        RightWrist = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( -0.11168361883511715, -1.1050726691927297, -0.4283736116094882 ),
        LeftShoulder = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.3666064093814089, -0.3967831521483909, -0.2950130034646015 ),
        LeftElbow = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( 1.0630451408047064, -0.8047364115095454, -0.5894151416910051 ),
        LeftWrist = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.1855459527795172, 2.08994451280061, 0.5269323544696081 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.3940778918077997, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.2815739682242452, 0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.5530599333719631, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.7049559381730296, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.813777217034876, 0, 0 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.08096582400001695, 0, 0 ),
        Gun = CFrame.new( 0.2344, 0.3235, -0.9824 ) * CFrame.fromOrientation( -0.12985249634837812, 1.0927680979661696, 0.08049458510197847 ),
        RightHand = CFrame.new( 0.0474, -0.0453, 0.0557 ) * CFrame.fromOrientation( 1.3960714153777443, -0.761469699352606, -0.9068381727512137 ),
        LeftHand = CFrame.new( -0.068, 0.08, -0.9426 ) * CFrame.fromOrientation( 0.21169098497439223, -0.14774212118132, 1.9053584911096895 )
    },
    {
        Root = CFrame.new( 0, -0.0121, 0 ) * CFrame.fromOrientation( -0.24249604627209215, -0.12587314565383104, 0.030368728984701335 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37070793312359557, 0.20943951023931956, -0 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 0.09306095571633764, 0.7307693578100257, 0.7956781526916948 ),
        RightElbow = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 1.1926183844727651, 1.5732746943327285, 1.316728747582082 ),
        RightWrist = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.1028347995275059, -1.1449708958933202, -0.43886304041397417 ),
        LeftShoulder = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.37274996834842894, -0.34780921333743003, -0.2764252469308619 ),
        LeftElbow = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 1.0843556109715569, -0.8581609399130918, -0.6388079595224445 ),
        LeftWrist = CFrame.new( 0, -0, 0 ) * CFrame.fromOrientation( -0.18243926671096725, 2.0990027716184603, 0.5375439563217336 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.1279849940487442, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -1.3909750539619208, 0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.4245862471326606, 0, 0 ),
        LeftHip = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 0.9679072432784953, -0.19570376902612416, -0.22430971546631123 ),
        LeftKnee = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.8409519934884278, 0.06569419304506656, 0.0686088928958971 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.03490658503988659, 0, 0 ),
        Gun = CFrame.new( 0.1944, 0.3603, -0.979 ) * CFrame.fromOrientation( -0.12358676433371849, 1.128634614094653, 0.06998770300497262 ),
        RightHand = CFrame.new( 0.0496, -0.047, 0.0525 ) * CFrame.fromOrientation( 1.404134836521958, -0.7702312521976176, -0.9188809445899747 ),
        LeftHand = CFrame.new( -0.0556, 0.0678, -0.9433 ) * CFrame.fromOrientation( 0.1951103570804461, -0.14784684093643966, 1.9646822323849769 )
    },
    {
        Root = CFrame.new( 0, -0.2673, 0 ) * CFrame.fromOrientation( -0.24342107077564912, -0.0890117918517108, -0.027855454861829502 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37041122715075653, 0.1327497429066887, 0.04235914094590238 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 0.08299040593233037, 0.685460610428253, 0.7633895615297998 ),
        RightElbow = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 1.192443851547566, 1.5992975534799638, 1.3416171427155212 ),
        RightWrist = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( -0.11168361883511715, -1.1050726691927297, -0.42839106490200823 ),
        LeftShoulder = CFrame.new( 0, 0, -0 ) * CFrame.fromOrientation( 0.3666064093814089, -0.3967831521483909, -0.2950130034646015 ),
        LeftElbow = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( 1.0630451408047064, -0.8047189582170255, -0.5894151416910051 ),
        LeftWrist = CFrame.new( -0, -0, -0 ) * CFrame.fromOrientation( -0.1855459527795172, 2.08994451280061, 0.5269323544696081 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.3649483465920143, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.9589711575082843, 3.141592653589793, 3.141592653589793 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.16627751783749975, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.17564993592070932, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.48010517063860014, 0, 0 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.29042278753185646, 0, 0 ),
        Gun = CFrame.new( 0.2344, 0.3235, -0.9824 ) * CFrame.fromOrientation( -0.12985249634837812, 1.0927680979661696, 0.08049458510197847 ),
        RightHand = CFrame.new( 0.0474, -0.0453, 0.0557 ) * CFrame.fromOrientation( 1.3960714153777443, -0.761469699352606, -0.9068381727512137 ),
        LeftHand = CFrame.new( -0.068, 0.08, -0.9426 ) * CFrame.fromOrientation( 0.21169098497439223, -0.14774212118132, 1.9053584911096895 )
    },
    {
        Root = CFrame.new( 0, -0.4322, 0 ) * CFrame.fromOrientation( -0.24434609527920614, -0, -0.06981317007977318 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37009706788539753, -0.021694442602289518, 0.05991715322096533 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 0.05614724203665758, 0.5806535888459935, 0.6898239335582388 ),
        RightElbow = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 1.1919027994794476, 1.6311672656213805, 1.372090591455342 ),
        RightWrist = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( -0.12534954687823274, -1.0090621070405217, -0.4097334951981888 ),
        LeftShoulder = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 0.3525041490252947, -0.5264087556940098, -0.3510380724536195 ),
        LeftElbow = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 0.9970716950793206, -0.6753900606442458, -0.4715879638888678 ),
        LeftWrist = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.1943075056245287, 2.074184189655101, 0.510630979255981 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.8137597637423561, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -1.3929821826017144, 3.141592653589793, 3.141592653589793 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.03961897402027128, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.08018042583661951, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.2983640356284306, 0, 0 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.050335295627516465, 0, 0 ),
        Gun = CFrame.new( 0.3311, 0.2348, -0.9907 ) * CFrame.fromOrientation( -0.14339625134385411, 1.005815794631812, 0.10676179034449314 ),
        RightHand = CFrame.new( 0.042, -0.0413, 0.0635 ) * CFrame.fromOrientation( 1.3765586343404477, -0.7438418739074633, -0.8813214590870567 ),
        LeftHand = CFrame.new( -0.0979, 0.1094, -0.9409 ) * CFrame.fromOrientation( 0.25148449191986294, -0.1516167521207474, 1.7611942948949582 )
    },
    {
        Root = CFrame.new( 0, -0.1348, 0 ) * CFrame.fromOrientation( -0.24342107077564912, 0.0890117918517108, -0.07087782092348972 ),
        Waist = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.37041122715075653, -0.16343263115674903, 0.04235914094590238 ),
        Neck = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.4363323129985824, 0, 0 ),
        RightShoulder = CFrame.new( -0, 0, 0 ) * CFrame.fromOrientation( 0.027890361446869388, 0.4831245902445504, 0.6228731034517364 ),
        RightElbow = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( 1.1921296922822069, 1.6204334907216151, 1.3618280554536155 ),
        RightWrist = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( -0.12721704917786666, -0.9148841406029076, -0.3974114706791088 ),
        LeftShoulder = CFrame.new( -0, 0, -0 ) * CFrame.fromOrientation( 0.33536501577071043, -0.6747268355284879, -0.4233121567787047 ),
        LeftElbow = CFrame.new( 0, -0, -0 ) * CFrame.fromOrientation( 0.9073617715268121, -0.551244790949889, -0.3619289269860641 ),
        LeftWrist = CFrame.new( -0, -0, 0 ) * CFrame.fromOrientation( -0.20612338466053032, 2.0682326169058007, 0.5097234080449439 ),
        RightHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.7049559381730296, 0, 0.05235987755982989 ),
        RightKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.813777217034876, 0, 0 ),
        RightAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( 0.08096582400001695, 0, 0 ),
        LeftHip = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.3940778918077997, 0, -0.05235987755982989 ),
        LeftKnee = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.2815739682242452, 0, 0 ),
        LeftAnkle = CFrame.new( 0, 0, 0 ) * CFrame.fromOrientation( -0.5530599333719631, 0, 0 ),
        Gun = CFrame.new( 0.4279, 0.146, -0.999 ) * CFrame.fromOrientation( -0.15460126514165773, 0.9183747991068962, 0.1341634596008041 ),
        RightHand = CFrame.new( 0.0366, -0.0374, 0.0712 ) * CFrame.fromOrientation( 1.3569585868405514, -0.7301759458643476, -0.8597317362398867 ),
        LeftHand = CFrame.new( -0.1278, 0.1388, -0.9392 ) * CFrame.fromOrientation( 0.29030061448421685, -0.1614604091019954, 1.6153022227207519 )
    }
}
local Table7 = { Low = 0, Aim = 1, Sprint = 2, Reload = 3, ReloadAim = 4 }
local Table8 = { [ 0 ] = "Low" }
Table8[ 1 ] = "Aim"
Table8[ 2 ] = "Sprint"
Table8[ 3 ] = "Reload"
Table8[ 4 ] = "ReloadAim"
local Table = {
    Global = Table2,
    Poses = Table4,
    RunCycle = Table5,
    RunFrames = Table6,
    StanceIds = Table7,
    StanceNames = Table8
}
local Poses = Table.Poses
Poses.Draw = {
    {
        Gun = CFrame.new( 0.24572, 0.99624, 1.00494, 0.4651, -0.19958, 0.86247, 0.38032, -0.83472, -0.39825, 0.7994, 0.51324, -0.31232 ),
        Hand = CFrame.new( 0.03369, -0.00384, -0.0555, 0.99383, -0.08762, 0.06802, 0.04258, -0.26486, -0.96335, 0.10243, 0.9603, -0.2595 ),
        Pole = Vector3.new( 3.2438299655914307, 0.7829300165176392, 0.4808200001716614 )
    },
    {
        Gun = CFrame.new( 0.75015, 1.86722, 0.49608, 0.96095, 0.08092, 0.26464, 0.21992, -0.80375, -0.55282, 0.16797, 0.58943, -0.79016 ),
        Hand = CFrame.new( 0.04399, -0.06121, -0.00166, 0.99569, 0.07999, -0.04702, -0.04822, 0.0131, -0.99875, -0.07928, 0.99671, 0.0169 ),
        Pole = Vector3.new( 2.9187400341033936, 0.45715001225471497, -0.7856299877166748 )
    },
    {
        Gun = CFrame.new( 1.1266, 1.44709, -0.14698, 0.99408, 0.02714, 0.10523, 0.1033, 0.06457, -0.99255, -0.03373, 0.99754, 0.06138 ),
        Hand = CFrame.new( 0.01185, -0.02473, -0.0135, 0.99515, -0.04562, -0.08712, -0.08793, -0.01617, -0.996, 0.04403, 0.99883, -0.0201 ),
        Pole = Vector3.new( 2.8739099502563477, -0.9312899708747864, 0.39574000239372253 )
    },
    {
        Gun = CFrame.new( 1.31288, 0.74335, -0.63898, 0.99689, 0.01315, -0.07765, -0.0407, 0.93011, -0.36502, 0.06742, 0.36705, 0.92776 ),
        Hand = CFrame.new( 0.04173, -0.03736, 0.01316, 0.89506, -0.24562, -0.37221, -0.38329, 0.00289, -0.92362, 0.22794, 0.96936, -0.09156 ),
        Pole = Vector3.new( 2.195430040359497, -1.43503999710083, 1.347830057144165 )
    }
}
Table.Heal = {
    Infinite = false,
    Items = {
        Bandage = {
            DisplayName = "Bandage",
            Slot = 2,
            Time = 2.5,
            Amount = 20,
            Sound = 9113266090,
            SoundVolume = 0.35,
            Carry = CFrame.new( -0.12, -0.3, 0 ),
            Press = CFrame.new( -0.3, -0.12, 0 )
        },
        Kevlar = {
            DisplayName = "Kevlar",
            Time = 7,
            Armor = 50,
            Pose = "Medkit",
            Confirm = "Kevlar",
            Sound = 9113242343,
            SoundVolume = 0.28,
            SoundLayers = {
                { Id = 9113836715, Volume = 0.5, Delay = 3.1 },
                { Id = 9113836270, Volume = 0.35, Delay = 4.4 },
                { Id = 97324524028175, Volume = 0.15, Delay = 5.4 },
                { Id = 82479764694278, Volume = 0.45, Delay = 6.3 }
            },
            Carry = CFrame.new( 0, -0.95, 0 ) * CFrame.Angles( 0, -1.5707963267948966, 0 ),
            Press = CFrame.new( -0.45, -0.2, 0 ) * CFrame.Angles( -0.17453292519943295, 0, 0 ) * CFrame.Angles( 0, -1.5707963267948966, 0 )
        },
        Medkit = {
            DisplayName = "Medkit",
            Slot = 3,
            Time = 4,
            Amount = 100,
            Sound = 9113668401,
            SoundVolume = 0.4,
            SoundLayers = { { Id = 9113266090, Volume = 0.28, Delay = 0.6 } },
            Carry = CFrame.new( 0, -0.72, 0 ) * CFrame.Angles( 0, -1.5707963267948966, 0 ),
            Press = CFrame.new( -0.34, -0.08, 0 ) * CFrame.Angles( -0.24434609527920614, 0, 0 ) * CFrame.Angles( 0, -1.5707963267948966, 0 )
        }
    }
}
Table.ConfirmSound = 98797174600699
Table.ConfirmVolume = 0.4
Table.ConfirmFX = {
    Heal = "HealConfirmation",
    EDrink = "EnergyDrinkConfirmation",
    Kevlar = "KevlarConfirmation"
}
Table.ConfirmSpeed = {
    EDrink = { Sound = 1.4, Pitch = 1.25, FX = 1.6 },
    Kevlar = { Sound = 1.4, Pitch = 1.25, FX = 1.6 }
}
Table.Armor = { Max = 50 }
Table.ArmorBreakSounds = {
    { Id = 9113551901, Volume = 1.2, Delay = 0 },
    { Id = 118987440163311, Volume = 0.7, Delay = 0.03 }
}
Table.Drink = {
    Time = 2.5,
    Raise = 0.3,
    Lower = 0.3,
    Joints = {
        RightShoulder = CFrame.new( 2e-05, -0, -1e-05, 0.96576, -0.24428, 0.08747, 0.21453, 0.56213, -0.79875, 0.14596, 0.79015, 0.59528 ),
        RightElbow = CFrame.new( -2e-05, 0, -0, 0.76896, 0.63688, 0.05554, 0.17884, -0.13088, -0.97513, -0.61377, 0.75977, -0.21455 ),
        RightWrist = CFrame.identity
    },
    Rest = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.99824, -0.04191, -0.04199, 0.04553, 0.99496, 0.08937, 0.03804, -0.09112, 0.99511 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.99948, 0.00287, -0.03214, -0.01134, 0.96373, -0.26662, 0.03021, 0.26685, 0.96326 ),
        RightWrist = CFrame.identity
    },
    Edge = 0.08,
    Carry = CFrame.new( -0.15571, -0.12259, 0.20568, 0.99563, 0.09341, 2e-05, -0.02736, 0.29139, 0.95621, 0.08931, -0.95203, 0.29267 ),
    DrinkGrip = CFrame.new( -0.15571, -0.12259, 0.20568, 0.99563, 0.09341, 2e-05, -0.02736, 0.29139, 0.95621, 0.08931, -0.95203, 0.29267 )
}
local Poses2 = Table.Poses
Poses2.PistolGrip = CFrame.new( -0.00150299, -0.220191, -0.0465012, 0.993203, 0.00113285, -0.116386, 0.112129, 0.258819, 0.959396, 0.0312097, -0.965925, 0.256933 )
local Poses3 = Table.Poses
Poses3.PistolAim = {
    Twist = -50,
    Waist = CFrame.new( 0, 0, 0, 1, 0, 0, 0, 0.956116, 0.292989, 0, -0.292989, 0.956116 ),
    Neck = CFrame.new( 0, 0, 0, 0.89117, 0.203834, 0.4053, -0.239556, 0.970105, 0.0388459, -0.385265, -0.13171, 0.913358 ),
    RightShoulder = CFrame.new( 0.133759, 0.0594991, -0.0654985, 0.793095, 0.448993, 0.41159, 0.351198, 0.215015, -0.911278, -0.497655, 0.86728, 0.0128414 ),
    RightElbow = CFrame.new( 0, 0, 0, 0.814905, 0.317815, 0.484689, -0.160383, 0.927251, -0.338355, -0.556962, 0.197991, 0.806593 ),
    RightWrist = CFrame.new( 0, 0, 0, 0.816062, -0.032431, -0.577053, 0.0399386, 0.999202, 0.000324519, 0.576582, -0.0233115, 0.816706 ),
    LeftShoulder = CFrame.new( 0, 0, 0, 0.961725, 0.226939, -0.153572, -0.262929, 0.606438, -0.750401, -0.0771635, 0.762057, 0.642896 ),
    LeftElbow = CFrame.new( 0, 0, 0, 0.63158, -0.442831, 0.636402, 0.775164, 0.376643, -0.507209, -0.0150887, 0.813659, 0.581147 ),
    LeftWrist = CFrame.new( 0, 0, 0, 0.657637, -0.0588598, 0.751032, 0.170647, 0.982668, -0.0724124, -0.733753, 0.175782, 0.656283 ),
    Gun = CFrame.new( -0.733915, 0.866083, -1.73352, 0.658088, 0.00591969, 0.752918, 0.200772, 0.962385, -0.183051, -0.72568, 0.271629, 0.632145 ),
    RightHand = CFrame.new( 0.0156555, -0.00734806, 0.301416, 0.998185, 0.00916892, 0.0595302, 0.0539136, 0.304659, -0.950935, -0.0268558, 0.952418, 0.303611 ),
    LeftHand = CFrame.new( -0.119194, -0.277658, 0.180962, -0.133968, -0.943936, 0.301728, 0.946655, -0.211946, -0.242743, 0.293083, 0.253113, 0.921974 )
}
local Poses4 = Table.Poses
Poses4.RPGAim = {
    Twist = -43.3,
    Waist = CFrame.new( 0, 0, 0, 1, -9.36926e-09, 4.82072e-09, 7.45058e-09, 0.952273, 0.305247, -7.45058e-09, -0.305247, 0.952273 ),
    Neck = CFrame.new( 0, 0, 0, 0.908392, -0.102749, 0.405299, 0.0951824, 0.994702, 0.0388396, -0.407142, 0.00329575, 0.91336 ),
    RightShoulder = CFrame.new( 0.0596677, 0.0156431, -0.0949599, 0.790799, 0.266382, 0.55107, 0.498523, 0.242053, -0.832398, -0.355124, 0.93298, 0.0586174 ),
    RightElbow = CFrame.new( -7.18055e-07, -1.47054e-05, 1.15101e-05, 0.858815, 0.376833, 0.347037, -0.0399685, 0.72465, -0.687958, -0.510725, 0.576957, 0.637401 ),
    RightWrist = CFrame.new( 0, 0, 0, 0.828028, 0.0180868, -0.560395, -0.066059, 0.995665, -0.0654722, 0.556782, 0.0912319, 0.825634 ),
    LeftShoulder = CFrame.new( -6.71085e-06, -1.97233e-05, -1.41961e-05, 0.984944, -0.0289085, -0.170444, -0.0405548, 0.919772, -0.390353, 0.168054, 0.391387, 0.904751 ),
    LeftElbow = CFrame.new( 1.23714e-06, 2.74608e-05, -1.03506e-06, -0.0235979, -0.0334972, -0.999161, -0.929105, -0.368224, 0.0342882, -0.369063, 0.929134, -0.022433 ),
    LeftWrist = CFrame.new( 0, 0, -9.98378e-07, -0.57844, -0.302965, 0.757377, 0.304486, 0.781171, 0.545032, -0.756766, 0.545879, -0.359612 ),
    Gun = CFrame.new( -0.56741, 0.862587, -1.44696, 0.727637, 0.00892534, 0.685905, 0.212722, 0.947686, -0.237996, -0.652147, 0.319082, 0.687673 ),
    RightHand = CFrame.new( 0.0764999, 0.20424, 0.0592232, 0.951775, 0.262476, 0.15885, 0.157571, 0.0260538, -0.987165, -0.263247, 0.964588, -0.0165624 ),
    LeftHand = CFrame.new( -0.165504, 0.100711, 0.712978, 0.0131832, -0.996707, 0.0800363, 0.373607, -0.069336, -0.924994, 0.927495, 0.0420971, 0.371462 )
}
local Poses5 = Table.Poses
Poses5.RPGLow = {
    Waist = CFrame.new( 0, 0, 0, 1, -7.52208e-09, 7.37839e-09, 7.45058e-09, 0.999954, 0.00964302, -7.45058e-09, -0.00964302, 0.999954 ),
    Neck = CFrame.new( 0, 0, 0, 1, -2.04891e-08, 3.81639e-16, 2.04891e-08, 1, -1.86264e-08, 0, 1.86264e-08, 1 ),
    RightShoulder = CFrame.new( 0, 0, 0, 0.81934, -0.570816, 0.0533957, 0.465642, 0.71691, 0.518862, -0.334455, -0.400261, 0.853189 ),
    RightElbow = CFrame.new( 0, 0, 0, 0.898267, 0.315999, 0.305386, 0.356306, -0.116959, -0.92702, -0.25722, 0.941523, -0.217653 ),
    RightWrist = CFrame.new( -0.0863881, -0.215286, -0.0932158, 0.741875, 0.345553, -0.574643, -0.494011, 0.861143, -0.119944, 0.453403, 0.372863, 0.809567 ),
    LeftShoulder = CFrame.new( 2.65596e-05, 1.71046e-06, -1.3495e-05, 0.980828, -0.0356432, 0.191587, 0.0730069, 0.97874, -0.191673, -0.180683, 0.201985, 0.962578 ),
    LeftElbow = CFrame.new( 5.10021e-07, 2.60652e-06, -9.16202e-07, 0.866073, -0.458996, 0.198092, 0.462854, 0.586494, -0.664674, 0.188902, 0.667344, 0.720395 ),
    LeftWrist = CFrame.new( -8.57213e-06, -1.4893e-06, -3.40765e-06, 0.362252, -0.086531, 0.928055, 0.587558, 0.794139, -0.155299, -0.723567, 0.601544, 0.33852 ),
    Gun = CFrame.new( 0.340912, -0.582376, -0.705532, 0.406568, -0.38804, 0.827121, -0.0265092, 0.899931, 0.435229, -0.913236, -0.198876, 0.355596 ),
    RightHand = CFrame.new( 0.0440903, 0.196931, 0.106358, 0.976999, -0.0950625, -0.190888, -0.192864, -0.0119553, -0.981154, 0.0909894, 0.995401, -0.0300153 ),
    LeftHand = CFrame.new( -0.0227661, 0.424985, -1.03159, -0.230812, -0.93964, 0.252599, 0.902963, -0.303568, -0.304155, 0.362476, 0.157883, 0.918524 )
}
local Poses6 = Table.Poses
Poses6.RPGReload = {
    Clip = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.629175, -0.332145, 0.702722, 0.337515, 0.931161, 0.137928, -0.700159, 0.150398, 0.697967 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.778831, 0.166552, -0.604717, -0.422536, -0.573204, -0.702069, -0.463557, 0.802307, -0.376055 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.104795, 0.632057, -0.767804, -0.879083, 0.419872, 0.225656, 0.465007, 0.651316, 0.59963 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.458304, 0.587704, -0.666754, -0.493827, -0.455351, -0.740804, -0.738981, 0.668775, 0.081535 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.923126, -0.234415, -0.304775, -0.265437, 0.184941, -0.946224, 0.278174, 0.954383, 0.108501 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.442325, -0.525385, 0.726856, -0.823017, -0.559811, 0.0962016, 0.356359, -0.640767, -0.680019 )
    },
    Aller = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.629175, -0.332145, 0.702722, 0.337515, 0.931161, 0.137928, -0.700159, 0.150398, 0.697967 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.778831, 0.166552, -0.604717, -0.422536, -0.573204, -0.702069, -0.463557, 0.802307, -0.376055 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.104795, 0.632057, -0.767804, -0.879083, 0.419872, 0.225656, 0.465007, 0.651316, 0.59963 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.73772, 0.66331, 0.12564, -0.63622, 0.74534, -0.19925, -0.22581, 0.067052, 0.97187 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.63158, -0.44283, 0.6364, 0.77516, 0.37664, -0.50721, -0.015088, 0.81366, 0.58115 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.65764, -0.05886, 0.75103, 0.17065, 0.98267, -0.072412, -0.73375, 0.17578, 0.65628 )
    },
    Dos = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.629175, -0.332145, 0.702722, 0.337515, 0.931161, 0.137928, -0.700159, 0.150398, 0.697967 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.778831, 0.166552, -0.604717, -0.422536, -0.573204, -0.702069, -0.463557, 0.802307, -0.376055 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.104795, 0.632057, -0.767804, -0.879083, 0.419872, 0.225656, 0.465007, 0.651316, 0.59963 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.993663, -0.0626495, -0.0933213, 0.10912, 0.736792, 0.667256, 0.0269551, -0.673211, 0.738959 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.631582, -0.442828, 0.636402, 0.775162, 0.376642, -0.507212, -0.015088, 0.81366, 0.581144 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.65764, -0.0588634, 0.751029, 0.17065, 0.982667, -0.0724113, -0.73375, 0.175784, 0.656286 )
    },
    Chemin = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.629175, -0.332145, 0.702722, 0.337515, 0.931161, 0.137928, -0.700159, 0.150398, 0.697967 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.778831, 0.166552, -0.604717, -0.422536, -0.573204, -0.702069, -0.463557, 0.802307, -0.376055 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.104795, 0.632057, -0.767804, -0.879083, 0.419872, 0.225656, 0.465007, 0.651316, 0.59963 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.517112, 0.770007, -0.373744, -0.454382, -0.123082, -0.882263, -0.725349, 0.626051, 0.286231 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.671482, -0.43986, 0.596352, 0.647366, -0.0434109, -0.760942, 0.360596, 0.897017, 0.255601 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.36874, 0.116146, 0.922248, -0.262215, 0.964865, -0.0166724, -0.891782, -0.23568, 0.386239 )
    },
    Insertion = {
        RightShoulder = CFrame.new( 0, 0, 0, 0.629175, -0.332145, 0.702722, 0.337515, 0.931161, 0.137928, -0.700159, 0.150398, 0.697967 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.778831, 0.166552, -0.604717, -0.422536, -0.573204, -0.702069, -0.463557, 0.802307, -0.376055 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.104795, 0.632057, -0.767804, -0.879083, 0.419872, 0.225656, 0.465007, 0.651316, 0.59963 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.762534, 0.565895, -0.313534, -0.309179, -0.106949, -0.944971, -0.568287, 0.817511, 0.0934108 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.910196, -0.275875, -0.308928, -0.312799, 0.0310306, -0.949312, 0.271478, 0.960693, -0.0580498 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.12566, -0.50643, 0.853076, -0.891814, 0.319031, 0.320761, -0.434601, -0.801091, -0.411552 )
    },
    GunInHand = CFrame.new( -0.0894051, -0.0825272, 0.190445, 0.951774, 0.157571, -0.263247, 0.262477, 0.0260541, 0.964587, 0.158849, -0.987165, -0.0165611 ),
    RocketInHand = {
        Clip = CFrame.new( 0.280006, 7.62939e-06, 0.199997, 3.12924e-07, 0.985923, 0.167204, 7.45058e-08, -0.167204, 0.985923, 1, -5.66244e-07, -1.49012e-07 ),
        Aller = CFrame.new( 0.0931559, 0.14982, -0.325282, 3.35262e-07, 1, -3.0642e-07, -0.536389, 4.3844e-07, 0.843971, 0.843971, -1.18592e-07, 0.536389 ),
        Dos = CFrame.new( 0.0931559, 0.14982, -0.325282, 3.35262e-07, 1, -3.0642e-07, -0.536389, 4.3844e-07, 0.843971, 0.843971, -1.18592e-07, 0.536389 ),
        Chemin = CFrame.new( 0.279999, 0, 0.199997, -2.68221e-07, -0.278562, 0.960418, -2.23517e-08, -0.960419, -0.278563, 1, 4.47035e-08, -4.47035e-08 ),
        Insertion = CFrame.new( 0.280006, 7.62939e-06, 0.199997, 3.12924e-07, 0.985923, 0.167204, 7.45058e-08, -0.167204, 0.985923, 1, -5.66244e-07, -1.49012e-07 )
    }
}
local Poses7 = Table.Poses
Poses7.PistolReload = {
    Prise = {
        RightShoulder = CFrame.new( 0.13376, 0.059499, -0.065499, 0.79309, 0.44899, 0.41159, 0.3512, 0.21501, -0.91128, -0.49766, 0.86728, 0.012842 ),
        RightElbow = CFrame.new( 0, 0, 0, 0.81491, 0.31781, 0.48469, -0.16038, 0.92725, -0.33835, -0.55696, 0.19799, 0.80659 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.81606, -0.032431, -0.57705, 0.039939, 0.9992, 0.0003245, 0.57658, -0.023312, 0.81671 ),
        LeftShoulder = CFrame.new( 0, 0, 0, 0.96172, 0.22694, -0.15357, -0.26293, 0.60644, -0.7504, -0.077163, 0.76206, 0.6429 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.63158, -0.44283, 0.6364, 0.77516, 0.37664, -0.50721, -0.015088, 0.81366, 0.58115 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.65764, -0.05886, 0.75103, 0.17065, 0.98267, -0.072412, -0.73375, 0.17578, 0.65628 )
    },
    Chemin = {
        RightShoulder = CFrame.new( 0.13376, 0.059505, -0.065525, 0.89167, 0.25262, 0.37563, 0.23341, 0.45441, -0.85967, -0.38786, 0.85422, 0.34623 ),
        RightElbow = CFrame.new( 4.7359e-06, 5.461e-06, 5.3567e-06, 0.94622, 0.30225, 0.11541, -0.22498, 0.87103, -0.43667, -0.23251, 0.38722, 0.89219 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.81606, -0.032431, -0.57705, 0.039939, 0.9992, 0.0003245, 0.57658, -0.023312, 0.81671 ),
        LeftShoulder = CFrame.new( 1.2484e-05, 6.1278e-06, -1.36e-05, 0.73772, 0.66331, 0.12564, -0.63622, 0.74534, -0.19925, -0.22581, 0.067052, 0.97187 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.63158, -0.44283, 0.6364, 0.77516, 0.37664, -0.50721, -0.015088, 0.81366, 0.58115 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.65764, -0.05886, 0.75103, 0.17065, 0.98267, -0.072412, -0.73375, 0.17578, 0.65628 )
    },
    Rangement = {
        RightShoulder = CFrame.new( 0.13377, 0.059514, -0.065509, 0.78844, -0.10682, 0.60575, 0.57204, 0.48933, -0.65828, -0.2261, 0.86553, 0.44692 ),
        RightElbow = CFrame.new( 2.7044e-05, 2.6806e-05, 4.4527e-06, 0.94455, 0.30869, -0.11199, -0.32037, 0.79139, -0.52064, -0.072094, 0.52764, 0.8464 ),
        RightWrist = CFrame.new( 0, 0, 0, 0.81606, -0.032431, -0.57705, 0.039939, 0.9992, 0.0003245, 0.57658, -0.023312, 0.81671 ),
        LeftShoulder = CFrame.new( 5.9619e-06, 3.6131e-06, -1.2159e-05, 0.99366, -0.062655, -0.093321, 0.10912, 0.73679, 0.66725, 0.026955, -0.67321, 0.73896 ),
        LeftElbow = CFrame.new( 0, 0, 0, 0.63158, -0.44283, 0.6364, 0.77516, 0.37664, -0.50721, -0.015088, 0.81366, 0.58115 ),
        LeftWrist = CFrame.new( 0, 0, 0, 0.65764, -0.05886, 0.75103, 0.17065, 0.98267, -0.072412, -0.73375, 0.17578, 0.65628 )
    },
    GunInHand = CFrame.new( -0.007138, -0.28498, -0.099432, 0.99787, 0.051709, -0.039736, 0.01802, 0.36696, 0.93006, 0.062674, -0.9288, 0.36525 ),
    MagInHand = CFrame.new( 0.23047, -0.14896, 0.023045, 0.1315, 0.96043, -0.24552, 0.94145, -0.19856, -0.27248, -0.31045, -0.19532, -0.93031 )
}
return Table
