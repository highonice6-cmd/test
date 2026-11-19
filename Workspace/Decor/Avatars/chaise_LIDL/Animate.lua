-- Workspace.Decor.Avatars.chaise_LIDL.Animate
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Animator
local Parent = script.Parent
local Humanoid = Parent:WaitForChild( "Humanoid" )
local Text = "Standing"

local function GetRigScale()
    return Parent:GetScale( )
end

local ScaleDampeningPercent = script:FindFirstChild( "ScaleDampeningPercent" )
local Success, Result = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( "UserAnimateRemoveEmoteChatHook" )
end )
local Success2 = Success and Result
local Text2 = ""
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Number = 1
local Value4 = nil
local Value5 = nil
local Table = { }
local Table2 = { }
local Table3 = {
    idle = {
        { id = "http://www.roblox.com/asset/?id=507766666", weight = 1 },
        { id = "http://www.roblox.com/asset/?id=507766951", weight = 1 },
        { id = "http://www.roblox.com/asset/?id=507766388", weight = 9 }
    },
    walk = { { id = "http://www.roblox.com/asset/?id=507777826", weight = 10 } },
    run = { { id = "http://www.roblox.com/asset/?id=507767714", weight = 10 } },
    swim = { { id = "http://www.roblox.com/asset/?id=507784897", weight = 10 } },
    swimidle = { { id = "http://www.roblox.com/asset/?id=507785072", weight = 10 } },
    jump = { { id = "http://www.roblox.com/asset/?id=507765000", weight = 10 } },
    fall = { { id = "http://www.roblox.com/asset/?id=507767968", weight = 10 } },
    climb = { { id = "http://www.roblox.com/asset/?id=507765644", weight = 10 } },
    sit = { { id = "http://www.roblox.com/asset/?id=2506281703", weight = 10 } },
    toolnone = { { id = "http://www.roblox.com/asset/?id=507768375", weight = 10 } },
    toolslash = { { id = "http://www.roblox.com/asset/?id=522635514", weight = 10 } },
    toollunge = { { id = "http://www.roblox.com/asset/?id=522638767", weight = 10 } },
    wave = { { id = "http://www.roblox.com/asset/?id=507770239", weight = 10 } },
    point = { { id = "http://www.roblox.com/asset/?id=507770453", weight = 10 } },
    dance = {
        { id = "http://www.roblox.com/asset/?id=507771019", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507771955", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507772104", weight = 10 }
    },
    dance2 = {
        { id = "http://www.roblox.com/asset/?id=507776043", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507776720", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507776879", weight = 10 }
    },
    dance3 = {
        { id = "http://www.roblox.com/asset/?id=507777268", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507777451", weight = 10 },
        { id = "http://www.roblox.com/asset/?id=507777623", weight = 10 }
    },
    laugh = { { id = "http://www.roblox.com/asset/?id=507770818", weight = 10 } },
    cheer = { { id = "http://www.roblox.com/asset/?id=507770677", weight = 10 } }
}
local Table4 = {
    wave = false,
    point = false,
    dance = true,
    dance2 = true,
    dance3 = true,
    laugh = false,
    cheer = false
}
local Value6 = nil
local Value7 = nil
local Value8 = nil
local Value9 = nil
local Value10 = nil
local Success3, Result2 = pcall( function()
    return UserSettings( ):IsUserFeatureEnabled( "UserAnimationAbilityManagerFixed" )
end )
local Success4 = Success3 and Result2
function resetManagerListeners()
    if Value6 then
        Value6:Disconnect( )
        Value6 = nil
    end
    if Value7 then
        Value7:Disconnect( )
        Value7 = nil
    end
    if Value8 then
        Value8:Disconnect( )
        Value8 = nil
    end
end
function teardownManager()
    resetManagerListeners( )
    Value9 = nil
    Value10 = nil
end
function processIfManagerBelongsToCharacter( Manager )
    if Manager.RootPart ~= Parent.PrimaryPart then
        return false
    end
    if Value10 ~= Manager then
        resetManagerListeners( )
        Value9 = Manager.GroundSensor
        Value6 = Manager:GetPropertyChangedSignal( "GroundSensor" ):Connect( function()
            if processIfManagerBelongsToCharacter( Manager ) then
                Value6:Disconnect( )
                Value6 = nil
            end
        end )
        Value7 = Manager:GetPropertyChangedSignal( "RootPart" ):Connect( function()
            if processIfManagerBelongsToCharacter( Manager ) then
                Value7:Disconnect( )
                Value7 = nil
            end
        end )
        Value8 = Manager.AncestryChanged:Connect( function( Argument1, Argument2 )
            if Argument2 == nil then
                resetManagerListeners( )
                lookForControllerManager( )
            end
        end )
        Value10 = Manager
    end

    return true
end
function setupManager( Manager )
    Value10 = Manager
    Value9 = Manager.GroundSensor
    Value6 = Manager:GetPropertyChangedSignal( "GroundSensor" ):Connect( function()
        Value9 = Value10.GroundSensor
    end )
    Value7 = Manager:GetPropertyChangedSignal( "RootPart" ):Connect( function()
        if Manager.RootPart ~= Parent.PrimaryPart then
            teardownManager( )
            lookForControllerManager( )
        end
    end )
    Value8 = Manager.AncestryChanged:Connect( function( Argument1, Argument2 )
        if Argument2 == nil then
            teardownManager( )
            lookForControllerManager( )
        end
    end )
end
function lookForControllerManager()
    if not Success4 then
        Value9 = nil
        Value10 = nil
        local ControllerManager2 = Parent:FindFirstChildOfClass( "ControllerManager" )

        if ControllerManager2 then
            processIfManagerBelongsToCharacter( ControllerManager2 )
        end
        if Value10 == nil then
            local Connect3 = nil
            Connect3 = Parent.ChildAdded:Connect( function( Manager )
                if Manager:IsA( "ControllerManager" ) and processIfManagerBelongsToCharacter( Manager ) then
                    Connect3:Disconnect( )
                    Connect3 = nil
                end
            end )
        end

        return
    end
    local ControllerManager = Parent:FindFirstChildOfClass( "ControllerManager" )

    if not ControllerManager then
        local Connect2 = nil
        Connect2 = Parent.ChildAdded:Connect( function( Object )
            if Object:IsA( "ControllerManager" ) then
                Connect2:Disconnect( )
                lookForControllerManager( )
            end
        end )
        return
    end
    if ControllerManager.RootPart == Parent.PrimaryPart then
        setupManager( ControllerManager )
        return
    end
    local Connect = nil
    Connect = ControllerManager:GetPropertyChangedSignal( "RootPart" ):Connect( function()
        if ControllerManager.RootPart == Parent.PrimaryPart then
            Connect:Disconnect( )
            setupManager( ControllerManager )
        end
    end )
    return
end
lookForControllerManager( )
math.randomseed( tick( ) )
function findExistingAnimationInSet( List, Anim )
    if List == nil or Anim == nil then
        return 0
    end

    local Count = List.count
    local I = 1

    for I = 1, Count do
        if List[ I ].anim.AnimationId == Anim.AnimationId then
            return I
        end
    end

    return 0
end
function configureAnimationSet( Name, List )
    if Table2[ Name ] ~= nil then
        for Key, Value in pairs( Table2[ Name ].connections ) do
            Value:disconnect( )
        end
    end

    Table2[ Name ] = { }
    Table2[ Name ].count = 0
    Table2[ Name ].totalWeight = 0
    Table2[ Name ].connections = { }
    local Flag = true
    local Success = pcall( function()
        Flag = game:GetService( "StarterPlayer" ).AllowCustomAnimations
    end )

    if not Success then
        Flag = true
    end

    local FoundChild = script:FindFirstChild( Name )

    if Flag and FoundChild ~= nil then
        local Connections = Table2[ Name ].connections
        table.insert( Connections, FoundChild.ChildAdded:connect( function( Argument1 )
            configureAnimationSet( Name, List )
        end ) )
        local Connections2 = Table2[ Name ].connections
        table.insert( Connections2, FoundChild.ChildRemoved:connect( function( Argument1 )
            configureAnimationSet( Name, List )
        end ) )

        for Key2, Value3 in pairs( FoundChild:GetChildren( ) ) do
            if Value3:IsA( "Animation" ) then
                local Weight2
                local Weight = Value3:FindFirstChild( "Weight" )
                Weight2 = if Weight == nil then 1 else Weight.Value
                local Entry = Table2[ Name ]
                Entry.count = Table2[ Name ].count + 1
                local Count = Table2[ Name ].count
                Table2[ Name ][ Count ] = { }
                Table2[ Name ][ Count ].anim = Value3
                Table2[ Name ][ Count ].weight = Weight2
                local Entry2 = Table2[ Name ]
                Entry2.totalWeight = Table2[ Name ].totalWeight + Table2[ Name ][ Count ].weight
                local Connections3 = Table2[ Name ].connections
                table.insert( Connections3, Value3.Changed:connect( function( Argument1 )
                    configureAnimationSet( Name, List )
                end ) )
                local Connections4 = Table2[ Name ].connections
                table.insert( Connections4, Value3.ChildAdded:connect( function( Argument1 )
                    configureAnimationSet( Name, List )
                end ) )
                local Connections5 = Table2[ Name ].connections
                table.insert( Connections5, Value3.ChildRemoved:connect( function( Argument1 )
                    configureAnimationSet( Name, List )
                end ) )
            end
        end
    end
    if Table2[ Name ].count <= 0 then
        for Key3, Value5 in pairs( List ) do
            Table2[ Name ][ Key3 ] = { }
            local Entry3 = Table2[ Name ][ Key3 ]
            Entry3.anim = Instance.new( "Animation" )
            Table2[ Name ][ Key3 ].anim.Name = Name
            local Anim = Table2[ Name ][ Key3 ].anim
            Anim.AnimationId = Value5.id
            local Entry4 = Table2[ Name ][ Key3 ]
            Entry4.weight = Value5.weight
            local Entry5 = Table2[ Name ]
            Entry5.count = Table2[ Name ].count + 1
            local Entry6 = Table2[ Name ]
            Entry6.totalWeight = Table2[ Name ].totalWeight + Value5.weight
        end
    end
    for Key4, Value7 in pairs( Table2 ) do
        local Count2 = Value7.count
        local J = 1

        for J = 1, Count2 do
            if Table[ Value7[ J ].anim.AnimationId ] == nil then
                Humanoid:LoadAnimation( Value7[ J ].anim )
                Table[ Value7[ J ].anim.AnimationId ] = true
            end
        end
    end
end
function configureAnimationSetOld( Name, List )
    if Table2[ Name ] ~= nil then
        for Key, Value in pairs( Table2[ Name ].connections ) do
            Value:disconnect( )
        end
    end

    Table2[ Name ] = { }
    Table2[ Name ].count = 0
    Table2[ Name ].totalWeight = 0
    Table2[ Name ].connections = { }
    local Flag = true
    local Success = pcall( function()
        Flag = game:GetService( "StarterPlayer" ).AllowCustomAnimations
    end )

    if not Success then
        Flag = true
    end

    local FoundChild = script:FindFirstChild( Name )

    if Flag and FoundChild ~= nil then
        local Number
        local Connections = Table2[ Name ].connections
        table.insert( Connections, FoundChild.ChildAdded:connect( function( Argument1 )
            configureAnimationSet( Name, List )
        end ) )
        local Connections2 = Table2[ Name ].connections
        table.insert( Connections2, FoundChild.ChildRemoved:connect( function( Argument1 )
            configureAnimationSet( Name, List )
        end ) )
        Number = 1

        for Key2, Value3 in pairs( FoundChild:GetChildren( ) ) do
            if Value3:IsA( "Animation" ) then
                local Connections3 = Table2[ Name ].connections
                table.insert( Connections3, Value3.Changed:connect( function( Argument1 )
                    configureAnimationSet( Name, List )
                end ) )
                Table2[ Name ][ Number ] = { }
                Table2[ Name ][ Number ].anim = Value3
                local Weight = Value3:FindFirstChild( "Weight" )

                if Weight == nil then
                    Table2[ Name ][ Number ].weight = 1
                else
                    local Entry = Table2[ Name ][ Number ]
                    Entry.weight = Weight.Value
                end

                local Entry2 = Table2[ Name ]
                Entry2.count = Table2[ Name ].count + 1
                local Entry3 = Table2[ Name ]
                Entry3.totalWeight = Table2[ Name ].totalWeight + Table2[ Name ][ Number ].weight
                Number = Number + 1
            end
        end
    end
    if Table2[ Name ].count <= 0 then
        for Key3, Value5 in pairs( List ) do
            Table2[ Name ][ Key3 ] = { }
            local Entry4 = Table2[ Name ][ Key3 ]
            Entry4.anim = Instance.new( "Animation" )
            Table2[ Name ][ Key3 ].anim.Name = Name
            local Anim = Table2[ Name ][ Key3 ].anim
            Anim.AnimationId = Value5.id
            local Entry5 = Table2[ Name ][ Key3 ]
            Entry5.weight = Value5.weight
            local Entry6 = Table2[ Name ]
            Entry6.count = Table2[ Name ].count + 1
            local Entry7 = Table2[ Name ]
            Entry7.totalWeight = Table2[ Name ].totalWeight + Value5.weight
        end
    end
    for Key4, Value7 in pairs( Table2 ) do
        local Count = Value7.count
        local J = 1

        for J = 1, Count do
            Humanoid:LoadAnimation( Value7[ J ].anim )
        end
    end
end
function scriptChildModified( Child )
    local Entry = Table3[ Child.Name ]

    if Entry ~= nil then
        configureAnimationSet( Child.Name, Entry )
    end
end
script.ChildAdded:connect( scriptChildModified )
script.ChildRemoved:connect( scriptChildModified )

if Humanoid then
    Animator = Humanoid:FindFirstChildOfClass( "Animator" )
else
    Animator = nil
end
if Animator then
    for Index, Value in ipairs( ( Animator:GetPlayingAnimationTracks( ) ) ) do
        Value:Stop( 0 )
        Value:Destroy( )
    end
end
for Key, Value13 in pairs( Table3 ) do
    configureAnimationSet( Key, Value13 )
end

local Text3 = "None"
local Number2 = 0
local Number3 = 0
local Flag = false
function stopAllAnimations()
    local Captured

    if Table4[ Text2 ] == nil or Table4[ Text2 ] ~= false then
        Captured = Text2
    else
        Captured = "idle"
    end
    if Flag then
        Flag = false
        Captured = "idle"
    end

    Text2 = ""
    Value1 = nil

    if Value3 ~= nil then
        Value3:disconnect( )
    end
    if Value2 ~= nil then
        Value2:Stop( )
        Value2:Destroy( )
        Value2 = nil
    end
    if Value5 ~= nil then
        Value5:disconnect( )
    end
    if Value4 ~= nil then
        Value4:Stop( )
        Value4:Destroy( )
        Value4 = nil
    end

    return Captured
end
function getHeightScale()
    if not Humanoid then
        return GetRigScale( )
    end
    if not Humanoid.AutomaticScalingEnabled then
        return GetRigScale( )
    end

    local HipHeight = Humanoid.HipHeight / 2

    if ScaleDampeningPercent == nil then
        ScaleDampeningPercent = script:FindFirstChild( "ScaleDampeningPercent" )
    end
    if ScaleDampeningPercent ~= nil then
        HipHeight = 1 + ( Humanoid.HipHeight - 2 ) * ScaleDampeningPercent.Value / 2
    end

    return HipHeight
end

local function RootMotionCompensation( Amount )
    return Amount * 1.25 / getHeightScale( )
end

local function SetRunSpeed( Speed )
    local Result2, Result4, Number
    local Result = Speed * 1.25 / getHeightScale( )

    if Result <= 0.5 then
        Result2 = Result / 0.5
        Result4 = 1
        Number = 0.0001
    elseif Result < 1 then
        local Result3 = ( Result - 0.5 ) / 0.5
        Result4 = 1 - Result3
        Number = Result3
        Result2 = 1
    else
        Result4 = 0.0001
        Number = 1
        Result2 = Result / 1
    end

    Value2:AdjustWeight( Result4 )
    Value4:AdjustWeight( Number )
    Value2:AdjustSpeed( Result2 )
    Value4:AdjustSpeed( Result2 )
end

function setAnimationSpeed( Speed )
    if Text2 == "walk" then
        SetRunSpeed( Speed )
        return
    end
    if Speed ~= Number then
        Number = Speed
        Value2:AdjustSpeed( Number )
    end
end
function keyFrameReachedFunc( FrameName )
    if FrameName == "End" then
        if Text2 == "walk" then
            if Value4.Looped ~= true then
                Value4.TimePosition = 0
            end
            if Value2.Looped ~= true then
                Value2.TimePosition = 0
                return
            end
        else
            local Captured

            if Table4[ Text2 ] == nil or Table4[ Text2 ] ~= false then
                Captured = Text2
            else
                Captured = "idle"
            end
            if Flag then
                if Value2.Looped then
                    return
                end

                Flag = false
                Captured = "idle"
            end

            playAnimation( Captured, 0.15, Humanoid )
            setAnimationSpeed( Number )
        end
    end
end
function rollAnimation( AnimationName )
    local Number
    local Random = math.random( 1, Table2[ AnimationName ].totalWeight )
    Number = 1

    while Table2[ AnimationName ][ Number ].weight < Random do
        Random = Random - Table2[ AnimationName ][ Number ].weight
        Number = Number + 1
    end

    return Number
end

local function SwitchToAnim( Anim, AnimName, TransitionTime, Humanoid )
    if Anim ~= Value1 then
        if Value2 ~= nil then
            Value2:Stop( TransitionTime )
            Value2:Destroy( )
        end
        if Value4 ~= nil then
            Value4:Stop( TransitionTime )
            Value4:Destroy( )
            Value4 = nil
        end

        Number = 1
        Value2 = Humanoid:LoadAnimation( Anim )
        Value2.Priority = Enum.AnimationPriority.Core
        Value2:Play( TransitionTime )
        Text2 = AnimName
        Value1 = Anim

        if Value3 ~= nil then
            Value3:disconnect( )
        end

        Value3 = Value2.KeyframeReached:connect( keyFrameReachedFunc )

        if AnimName == "walk" then
            local RollAnimation = rollAnimation( "run" )
            Value4 = Humanoid:LoadAnimation( Table2.run[ RollAnimation ].anim )
            Value4.Priority = Enum.AnimationPriority.Core
            Value4:Play( TransitionTime )

            if Value5 ~= nil then
                Value5:disconnect( )
            end

            Value5 = Value4.KeyframeReached:connect( keyFrameReachedFunc )
        end
    end
end

function playAnimation( AnimationName, TransitionTime, Humanoid )
    local RollAnimation = rollAnimation( AnimationName )
    SwitchToAnim( Table2[ AnimationName ][ RollAnimation ].anim, AnimationName, TransitionTime, Humanoid )
    Flag = false
end
function playEmote( Anim, TransitionTime, Humanoid )
    SwitchToAnim( Anim, Anim.Name, TransitionTime, Humanoid )
    Flag = true
end
local Text4 = ""
local Value14 = nil
local Value15 = nil
local Value16 = nil
function toolKeyFrameReachedFunc( FrameName )
    if FrameName == "End" then
        playToolAnimation( Text4, 0, Humanoid )
    end
end
function playToolAnimation( AnimationName, TransitionTime, Humanoid, Priority )
    local RollAnimation = rollAnimation( AnimationName )
    local Anim = Table2[ AnimationName ][ RollAnimation ].anim

    if Value15 ~= Anim then
        if Value14 ~= nil then
            Value14:Stop( )
            Value14:Destroy( )
            TransitionTime = 0
        end

        Value14 = Humanoid:LoadAnimation( Anim )

        if Priority then
            Value14.Priority = Priority
        end

        Value14:Play( TransitionTime )
        Text4 = AnimationName
        Value15 = Anim
        Value16 = Value14.KeyframeReached:connect( toolKeyFrameReachedFunc )
    end
end
function stopToolAnimations()
    if Value16 ~= nil then
        Value16:disconnect( )
    end

    Text4 = ""
    Value15 = nil

    if Value14 ~= nil then
        Value14:Stop( )
        Value14:Destroy( )
        Value14 = nil
    end

    return Text4
end
function onRunning( Speed )
    local HeightScale = getHeightScale( )

    if Value9 ~= nil and Humanoid.EvaluateStateMachine == false then
        local RootPart = Humanoid.RootPart
        local SensedPart = Value9.SensedPart

        if SensedPart then
            local Number
            local VelocityAtPosition = SensedPart:GetVelocityAtPosition( Value9.HitFrame.Position )
            local AssemblyLinearVelocity = RootPart.AssemblyLinearVelocity
            local X = AssemblyLinearVelocity.X - VelocityAtPosition.X
            local Magnitude = Vector3.new( X, 0, AssemblyLinearVelocity.Z - VelocityAtPosition.Z ).Magnitude
            local Magnitude2 = Value10.MovingDirection.Magnitude

            if Magnitude2 < 0.1 then
                Magnitude = 0
                Number = 0
            elseif Magnitude2 > 1 then
                Number = 1
            else
                Number = Magnitude2
            end

            Speed = Magnitude * Number
        end

        Speed = Speed
    end

    local Captured

    if Flag then
        if Humanoid.MoveDirection == Vector3.new( 0, 0, 0 ) then
            Captured = true
        else
            Captured = false
        end
    else
        Captured = Flag
    end

    local WalkSpeed2

    if Captured then
        local WalkSpeed = Humanoid.WalkSpeed / HeightScale

        if WalkSpeed then
            WalkSpeed2 = WalkSpeed
        else
            WalkSpeed2 = 0.75
        end
    else
        WalkSpeed2 = 0.75
    end
    if WalkSpeed2 * HeightScale < Speed then
        playAnimation( "walk", 0.2, Humanoid )
        setAnimationSpeed( Speed / 16 )
        Text = "Running"
        return
    end
    if Table4[ Text2 ] == nil and not Flag then
        playAnimation( "idle", 0.2, Humanoid )
        Text = "Standing"
    end
end
function onDied()
    Text = "Dead"
end
function onJumping()
    playAnimation( "jump", 0.1, Humanoid )
    Number3 = 0.31
    Text = "Jumping"
end
function onClimbing( Speed )
    local HeightScale = Speed / getHeightScale( )
    playAnimation( "climb", 0.1, Humanoid )
    setAnimationSpeed( HeightScale / 5 )
    Text = "Climbing"
end
function onGettingUp()
    Text = "GettingUp"
end
function onFreeFall()
    if Number3 <= 0 then
        playAnimation( "fall", 0.2, Humanoid )
    end

    Text = "FreeFall"
end
function onFallingDown()
    Text = "FallingDown"
end
function onSeated()
    Text = "Seated"
end
function onPlatformStanding()
    Text = "PlatformStanding"
end
function onSwimming( Speed )
    local HeightScale = Speed / getHeightScale( )

    if HeightScale > 1 then
        playAnimation( "swim", 0.4, Humanoid )
        setAnimationSpeed( HeightScale / 10 )
        Text = "Swimming"
        return
    end
    playAnimation( "swimidle", 0.4, Humanoid )
    Text = "Standing"
    return
end
function animateTool()
    if Text3 == "None" then
        playToolAnimation( "toolnone", 0.1, Humanoid, Enum.AnimationPriority.Idle )
        return
    end
    if Text3 == "Slash" then
        playToolAnimation( "toolslash", 0, Humanoid, Enum.AnimationPriority.Action )
        return
    end
    if Text3 == "Lunge" then
        playToolAnimation( "toollunge", 0, Humanoid, Enum.AnimationPriority.Action )
        return
    end
    return
end
function getToolAnim( Tool )
    for Index, Value in ipairs( Tool:GetChildren( ) ) do
        if Value.Name == "toolanim" then
            if Value.className == "StringValue" then
                return Value
            end
        end
    end

    return nil
end
local Number4 = 0
function stepAnimate( Amount )
    local Captured = Amount - Number4
    Number4 = Amount

    if Number3 > 0 then
        Number3 = Number3 - Captured
    end
    if Text ~= "FreeFall" or not ( Number3 <= 0 ) then
        if Text == "Seated" then
            playAnimation( "sit", 0.5, Humanoid )
            return
        end
        if Text == "Running" then
            playAnimation( "walk", 0.2, Humanoid )
        elseif Text == "Dead" or Text == "GettingUp" or Text == "FallingDown" or Text == "Seated" or Text == "PlatformStanding" then
            stopAllAnimations( )
        end
    else
        playAnimation( "fall", 0.2, Humanoid )
    end

    local Tool = Parent:FindFirstChildOfClass( "Tool" )

    if not Tool or not Tool:FindFirstChild( "Handle" ) then
        stopToolAnimations( )
        Text3 = "None"
        Value15 = nil
        Number2 = 0
        return
    end

    local ToolAnim = getToolAnim( Tool )

    if ToolAnim then
        Text3 = ToolAnim.Value
        ToolAnim.Parent = nil
        Number2 = Amount + 0.3
    end
    if Number2 < Amount then
        Number2 = 0
        Text3 = "None"
    end

    animateTool( )
end
Humanoid.Died:connect( onDied )
Humanoid.Running:connect( onRunning )
Humanoid.Jumping:connect( onJumping )
Humanoid.Climbing:connect( onClimbing )
Humanoid.GettingUp:connect( onGettingUp )
Humanoid.FreeFalling:connect( onFreeFall )
Humanoid.FallingDown:connect( onFallingDown )
Humanoid.Seated:connect( onSeated )
Humanoid.PlatformStanding:connect( onPlatformStanding )
Humanoid.Swimming:connect( onSwimming )

if not Success2 then
    game:GetService( "Players" ).LocalPlayer.Chatted:connect( function( TextInner )
        local Sub

        if string.sub( TextInner, 1, 3 ) == "/e " then
            Sub = string.sub( TextInner, 4 )
        elseif string.sub( TextInner, 1, 7 ) == "/emote " then
            Sub = string.sub( TextInner, 8 )
        else
            Sub = ""
        end
        if Text == "Standing" and Table4[ Sub ] ~= nil then
            playAnimation( Sub, 0.1, Humanoid )
        end
    end )
end

script:WaitForChild( "PlayEmote" ).OnInvoke = function( AnimationName )
    if Text ~= "Standing" then
        return
    end
    if Table4[ AnimationName ] ~= nil then
        playAnimation( AnimationName, 0.1, Humanoid )
        return true, Value2
    end
    if typeof( AnimationName ) ~= "Instance" or not AnimationName:IsA( "Animation" ) then
        return false
    end
    playEmote( AnimationName, 0.1, Humanoid )
    return true, Value2
end

if Parent.Parent ~= nil then
    playAnimation( "idle", 0.1, Humanoid )
    Text = "Standing"
end
while Parent.Parent ~= nil do
    local _, Wait2 = wait( 0.1 )
    stepAnimate( Wait2 )
end
