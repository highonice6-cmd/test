-- Players.perkbrokeyou.PlayerScripts.HoodClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Storage = { }
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local PathfindingService = game:GetService( "PathfindingService" )
local HoodNPC = ReplicatedStorage:WaitForChild( "HoodNPC" )
local Config = require( HoodNPC:WaitForChild( "Config" ) )
local Remote = HoodNPC:WaitForChild( "Remote" )
local FarmNav = require( HoodNPC:WaitForChild( "FarmNav" ) )
local Anims = HoodNPC:WaitForChild( "Anims" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService( "UserInputService" )
local ContextActionService = game:GetService( "ContextActionService" )
local LootGui = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "LootGui", math.huge )
local Phrase = LootGui:WaitForChild( "Phrase" )
local Controls = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Controls" ) )

local function LootInputs()
    local Keys
    local Interact = Controls.Actions.Interact
    local Table = { }
    Keys = Interact and Interact.keys or { }
    local Value1 = nil

    for Key, Value in Keys, nil, nil do
        table.insert( Table, Value )
    end
    if Interact and Interact.mouse then
        table.insert( Table, Interact.mouse )
    end

    local Mice = Interact and Interact.mice or { }
    local Value2 = nil

    for Key2, Value3 in Mice, nil, nil do
        table.insert( Table, Value3 )
    end

    local Table2 = if #Table == 0 then { Enum.KeyCode.E } else Table
    return Table2
end

local function LootText()
    local LastInputType = UserInputService:GetLastInputType( )

    if LastInputType == Enum.UserInputType.Touch then
        return "Tap <font color=\"#FFD25A\">here</font> to loot"
    end

    local Text
    local Item = LootInputs( )[ 1 ]
    local KeyName = Controls.KeyName
    local Success, Result = pcall( KeyName, Item.Name, true )

    if LastInputType.Name:find( "Gamepad" ) then
        Text = "[X]"
    else
        local Result2 = Success and Result or Item.Name
        Text = "[" .. Result2 .. "]"
    end

    return "Press <font color=\"#FFD25A\">" .. Text .. "</font> to loot"
end

local function TouchNow()
    local TouchMode

    if UserInputService:GetLastInputType( ) == Enum.UserInputType.Touch then
        TouchMode = true
    else
        TouchMode = Controls.TouchMode( )
    end

    return TouchMode
end

local function SetNear( Argument1, Near )
    if Argument1.near == Near then
        return
    end

    Argument1.near = Near

    if not Near then
        Argument1.label.Visible = false
    end
end

local Callback = nil
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local MeleeData = require( Weapons:WaitForChild( "MeleeData" ) )
local Bayonneta = MeleeData.Bayonneta
local FistAnim = require( Weapons:WaitForChild( "FistAnim" ) )
local RiotShield = require( Weapons:WaitForChild( "RiotShield" ) )
local MeleeAnims = Weapons:WaitForChild( "MeleeAnims" )
local MeleeSounds = Weapons:WaitForChild( "MeleeSounds" )
local Table = {
    UpperTorso = "Waist",
    Head = "Neck",
    RightUpperArm = "RightShoulder",
    RightLowerArm = "RightElbow",
    RightHand = "RightWrist",
    LeftUpperArm = "LeftShoulder",
    LeftLowerArm = "LeftElbow",
    LeftHand = "LeftWrist"
}

local function LoadKeys( Object )
    local TableInner = { }

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Keyframe" ) then
            local Table2 = { }

            for Key2, Value2 in Value:GetDescendants( ) do
                if Value2:IsA( "Pose" ) and Table[ Value2.Name ] and Value2.Weight > 0 then
                    Table2[ Value2.Name ] = Value2.CFrame
                end
            end

            table.insert( TableInner, { t = Value.Time, poses = Table2, grip = Value:GetAttribute( "Grip" ) } )
        end
    end

    table.sort( TableInner, function( Argument1, Argument2 )
        local Flag = Argument1.t < Argument2.t and true or false
        return Flag
    end )
    return TableInner
end

local function Sample( List, Min )
    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Min <= Entry2.t then
            local Value1
            local Clamp = math.clamp( ( Min - Entry.t ) / math.max( Entry2.t - Entry.t, 0.0001 ), 0, 1 )
            local Table = { }
            local Poses = Entry.poses
            Value1 = nil

            for Key, Value in Poses, nil, nil do
                Table[ Key ] = Value:Lerp( Entry2.poses[ Key ] or Value, Clamp )
            end

            return Table
        end
    end

    return List[ #List ].poses
end

local function SampleGrip( List, Min )
    local Count = #List - 1
    local I = 1

    for I = 1, Count do
        local Entry = List[ I ]
        local Entry2 = List[ I + 1 ]

        if Min <= Entry2.t and Entry.grip and Entry2.grip then
            return Entry.grip:Lerp( Entry2.grip, ( math.clamp( ( Min - Entry.t ) / math.max( Entry2.t - Entry.t, 0.0001 ), 0, 1 ) ) )
        end
    end

    return List[ #List ].grip
end

local Table2 = { }

local function KindOf( Name )
    local Text = Name or "Knife"
    local Entry = Table2[ Text ]

    if Entry then
        return Entry
    end

    local Captured = Text == "Knife" and Bayonneta or MeleeData[ Text ]

    if type( Captured ) ~= "table" then
        local Knife = Table2.Knife
        return Knife
    end

    local Table2Inner

    if Captured.Fists then
        Table2Inner = {
            d = Captured,
            fists = true,
            cut = FistAnim.PUNCH_TIME.Right,
            swingIn = 1,
            swingOut = 0,
            hitDelay = 0.1,
            body = { "HitBody" }
        }
        Table2[ Text ] = Table2Inner
        return Table2Inner
    end
    local FoundChild

    local function Anim( Name )
        if not Name then
            return nil
        end

        local FoundChild

        if Text == "Knife" then
            local Child = MeleeAnims:WaitForChild( Name )

            if Child then
                FoundChild = Child
            else
                FoundChild = MeleeAnims:FindFirstChild( Name )
            end
        else
            FoundChild = MeleeAnims:FindFirstChild( Name )
        end

        return FoundChild
    end

    local Visee = Captured.Visee

    if Visee then
        if Text == "Knife" then
            local Child = MeleeAnims:WaitForChild( Visee )

            if Child then
                FoundChild = Child
            else
                FoundChild = MeleeAnims:FindFirstChild( Visee )
            end
        else
            FoundChild = MeleeAnims:FindFirstChild( Visee )
        end
    else
        FoundChild = nil
    end

    local FoundChild2
    local Frappe = Captured.Frappe

    if Frappe then
        if Text == "Knife" then
            local Child2 = MeleeAnims:WaitForChild( Frappe )

            if Child2 then
                FoundChild2 = Child2
            else
                FoundChild2 = MeleeAnims:FindFirstChild( Frappe )
            end
        else
            FoundChild2 = MeleeAnims:FindFirstChild( Frappe )
        end
    else
        FoundChild2 = nil
    end

    local FoundChild3

    if Captured.FreeHold then
        FoundChild3 = nil
    else
        local Tenue = Captured.Tenue

        if Tenue then
            if Text == "Knife" then
                local Child3 = MeleeAnims:WaitForChild( Tenue )

                if Child3 then
                    FoundChild3 = Child3
                else
                    FoundChild3 = MeleeAnims:FindFirstChild( Tenue )
                end
            else
                FoundChild3 = MeleeAnims:FindFirstChild( Tenue )
            end
        else
            FoundChild3 = nil
        end
        if not FoundChild3 then
            FoundChild3 = nil
        end
    end
    if FoundChild and FoundChild2 then
        if Captured.FreeHold or FoundChild3 then
            local Cut2
            local Keys = LoadKeys( FoundChild )
            local Keys2 = LoadKeys( FoundChild2 )
            local Cut = FoundChild2:GetAttribute( "Cut" )
            Cut2 = if Cut then Cut else Keys2[ #Keys2 ].t
            local FreeHold
            local Table = { d = Captured }
            FreeHold = Captured.FreeHold == true and true or false
            local SwingSound
            Table.freeHold = FreeHold
            Table.cut = Cut2
            Table.swingIn = Captured.SwingIn
            Table.swingOut = Captured.SwingOut
            Table.hitDelay = Captured.HitDelay
            local Sounds = Captured.Sounds
            SwingSound = if Sounds then Captured.Sounds.Swing else Sounds
            local Body2
            Table.swingSound = SwingSound

            if Captured.Sounds then
                local Body = Captured.Sounds.Body

                if Body then
                    Body2 = Body
                else
                    Body2 = { "HitBody" }
                end
            else
                Body2 = { "HitBody" }
            end

            Table.body = Body2
            Table.swingT = { }
            Table.gripT = { }
            Table.aimT = { }

            if FoundChild3 then
                Table.hold = LoadKeys( FoundChild3 )[ 1 ].poses
            end
            if Captured.Parts then
                local Value3
                Table.parts = { }
                local Parts = Captured.Parts
                Value3 = nil

                for Key, Value in Parts, nil, nil do
                    Table.parts[ Value ] = true
                end
            end

            local Ceil = math.ceil( Cut2 * 120 )
            local I = 0

            for I = 0, Ceil do
                local Min = math.min( I / 120, Cut2 )
                local SwingT = Table.swingT
                local GripT = Table.gripT
                local Sample2 = Sample( Keys2, Min )
                local SampleGrip2 = SampleGrip( Keys2, Min )
                SwingT[ I ] = Sample2
                GripT[ I ] = SampleGrip2
            end

            Table.aimN = math.floor( Keys[ #Keys ].t * 30 )
            local Max = math.max( Table.aimN - 1, 0 )
            local I2 = 0
            Table2Inner = Table

            for I2 = 0, Max do
                local AimT = Table.aimT
                AimT[ I2 ] = Sample( Keys, I2 / 30 )
                Table2Inner = Table
            end

            Table2[ Text ] = Table2Inner
            return Table2Inner
        end
    end

    local Knife2 = Table2.Knife
    return Knife2
end

KindOf( "Knife" )
local RunGait = require( Weapons:WaitForChild( "RunGait" ) )
local CycleLength = require( Weapons:WaitForChild( "Config" ) ).RunCycle.CycleLength
local Clips = require( Weapons:WaitForChild( "Clips" ) )
local FarmZone = require( ReplicatedStorage:WaitForChild( "FarmZone" ) )

local function ClipPose( Argument1, Argument2 )
    local Sample, Sample2, Sample3 = Clips.Sample( Argument1, Argument2 )
    Sample3.Root = CFrame.new( Sample.X, Sample.Y - Argument1.baseY, Sample.Z ) * Sample2
    return Sample3
end

local Table3 = { }
local Table4 = { }
local I = 1

for I = 1, 60 do
    local ZombieRun = Clips.ZombieRun
    local Total = ( I - 1 ) / 60 * Clips.ZombieRun.length
    local Sample2, Sample22, Sample3 = Clips.Sample( ZombieRun, Total )
    Sample3.Root = CFrame.new( Sample2.X, Sample2.Y - ZombieRun.baseY, Sample2.Z ) * Sample22
    Table3[ I ] = Sample3
end

local Max = math.max( 1, ( math.floor( Clips.ZombieIdle.length * 30 ) ) )
local I2 = 1

for I2 = 1, Max do
    local ZombieIdle = Clips.ZombieIdle
    local Total2 = ( I2 - 1 ) / 30
    local Sample4, Sample23, Sample32 = Clips.Sample( ZombieIdle, Total2 )
    Sample32.Root = CFrame.new( Sample4.X, Sample4.Y - ZombieIdle.baseY, Sample4.Z ) * Sample23
    Table4[ I2 ] = Sample32
end

local Flag

local function ZombieFor( Argument1 )
    local Flag

    if ReplicatedStorage:GetAttribute( "HalloweenEvent" ) == true then
        if typeof( Argument1 ) == "Vector3" then
            if FarmZone.Contains( Argument1 ) == true then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local Table5 = {
    Root = "LowerTorso",
    Waist = "UpperTorso",
    Neck = "Head",
    RightShoulder = "RightUpperArm",
    RightElbow = "RightLowerArm",
    RightWrist = "RightHand",
    LeftShoulder = "LeftUpperArm",
    LeftElbow = "LeftLowerArm",
    LeftWrist = "LeftHand",
    RightHip = "RightUpperLeg",
    RightKnee = "RightLowerLeg",
    RightAnkle = "RightFoot",
    LeftHip = "LeftUpperLeg",
    LeftKnee = "LeftLowerLeg",
    LeftAnkle = "LeftFoot"
}

local function Same( Argument1, Argument2 )
    local Flag

    if ( Argument1.Position - Argument2.Position ).Magnitude < 0.001 then
        if Argument1.LookVector:Dot( Argument2.LookVector ) > 0.99999 then
            if Argument1.UpVector:Dot( Argument2.UpVector ) > 0.99999 then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function WeldAccessories( Clone )
    for Key, Value in Clone:GetDescendants( ) do
        if Value:IsA( "RigidConstraint" ) and Value.Attachment0 and Value.Attachment1 then
            local Attachment0 = Value.Attachment0
            local Attachment1 = Value.Attachment1
            local Weld = Instance.new( "Weld" )
            Weld.Name = "AccessoryWeld"
            local Part0 = Attachment0.Parent
            local Part1 = Attachment1.Parent
            Weld.Part0 = Part0
            Weld.Part1 = Part1
            local C0 = Attachment0.CFrame
            local C1 = Attachment1.CFrame
            Weld.C0 = C0
            Weld.C1 = C1
            Weld.Parent = Attachment0.Parent
            Value:Destroy( )
        end
    end
end

local function PlaySound( List, Parent, WorldPosition )
    local Table = { }

    for Key, Value in MeleeSounds:GetChildren( ) do
        local Name = Value.Name

        if Name:sub( 1, #List ) == List then
            table.insert( Table, Value )
        end
    end
    if #Table == 0 then
        return
    end

    local Parent2
    local Clone = Table[ math.random( #Table ) ]:Clone( )
    Clone.PlaybackSpeed = Clone.PlaybackSpeed * ( 0.94 + math.random( ) * 0.12 )

    if Parent then
        Parent2 = Parent
    else
        local Attachment = Instance.new( "Attachment" )
        Attachment.WorldPosition = WorldPosition
        Attachment.Parent = workspace.Terrain
        Parent2 = Attachment
    end

    Clone.Parent = Parent2
    Clone:Play( )
    Clone.Ended:Once( function()
        Clone:Destroy( )

        if not Parent then
            Parent2:Destroy( )
        end
    end )
end

Flag = game:GetService( "ReplicatedStorage" ):GetAttribute( "HalloweenEvent" ) == true and true or false
local ZombieSounds2
local ZombieSounds = HoodNPC:FindFirstChild( "ZombieSounds" )

if ZombieSounds then
    ZombieSounds2 = ZombieSounds
elseif not Flag or not HoodNPC:WaitForChild( "ZombieSounds", 10 ) then
    ZombieSounds2 = nil
else
    ZombieSounds2 = HoodNPC:WaitForChild( "ZombieSounds", 10 )
end

local HalloweenTemplates2
local Number = 0

local function ZombieGrowl( Value )
    local Parent = Value.e.model:FindFirstChild( "Head" )
    local CurrentCamera = workspace.CurrentCamera

    if not Parent or not CurrentCamera or Number >= 4 then
        return
    end
    if ( Parent.Position - CurrentCamera.CFrame.Position ).Magnitude > 80 then
        return
    end

    local Children = ZombieSounds2:GetChildren( )

    if #Children == 0 then
        return
    end
    local Clone = Children[ math.random( #Children ) ]:Clone( )
    Clone.PlaybackSpeed = Clone.PlaybackSpeed * ( 0.8 + math.random( ) * 0.4 )
    Clone.Parent = Parent
    Number = Number + 1
    local Flag = false

    local function Fin()
        if Flag then
            return
        end

        Flag = true
        Number = Number - 1

        if Clone.Parent then
            Clone:Destroy( )
        end
    end

    Clone.Ended:Once( Fin )
    Clone.Destroying:Once( Fin )
    Clone:Play( )
    return
end

local Parent = Instance.new( "Folder" )
Parent.Name = "HoodLocal"
Parent.Parent = workspace
local CFrame2 = CFrame.new( 0, -5000, 0 )
local Children = HoodNPC:WaitForChild( "Templates" ):GetChildren( )
table.sort( Children, function( Argument1, Argument2 )
    local Flag = Argument1.Name < Argument2.Name and true or false
    return Flag
end )
local Count = #Children
local Table6 = { }
local HalloweenTemplates = HoodNPC:FindFirstChild( "HalloweenTemplates" )

if HalloweenTemplates then
    HalloweenTemplates2 = HalloweenTemplates
elseif not Flag or not HoodNPC:WaitForChild( "HalloweenTemplates", 10 ) then
    HalloweenTemplates2 = nil
else
    HalloweenTemplates2 = HoodNPC:WaitForChild( "HalloweenTemplates", 10 )
end
if HalloweenTemplates2 then
    local Value1
    local Children2 = HalloweenTemplates2:GetChildren( )
    table.sort( Children2, function( Argument1, Argument2 )
        local Flag = Argument1.Name < Argument2.Name and true or false
        return Flag
    end )
    Value1 = nil

    for Key, Value in Children2, nil, nil do
        if Value:IsA( "Model" ) then
            table.insert( Children, Value )
            table.insert( Table6, #Children )
        end
    end
end

local Value2
local Table7 = { }
local Table8 = { }
Value2 = nil

for Key2, Value3 in Table6, nil, nil do
    Storage.Chance = Children[ Value3 ]:GetAttribute( "Chance" )

    if type( Storage.Chance ) == "number" then
        table.insert( Table7, { t = Value3, chance = Storage.Chance } )
    else
        table.insert( Table8, Value3 )
    end
end

local function TplFor( Amount, Argument2, Armor )
    if not Argument2 or not ( Amount <= Count ) or not ( #Table6 > 0 ) then
        return Amount
    end
    if type( Armor ) == "boolean" then
        if Armor and #Table7 > 0 then
            return Table7[ 1 ].t
        end

        local Captured = #Table8 > 0 and Table8 or Table6
        return Captured[ ( Amount - 1 ) % #Captured + 1 ]
    end
    local Value1
    local Random = math.random( )
    Value1 = nil

    for Key, Value in Table7, nil, nil do
        if Random < Value.chance then
            return Value.t
        end

        Random = Random - Value.chance
    end

    local Captured2 = #Table8 > 0 and Table8 or Table6
    return Captured2[ ( Amount - 1 ) % #Captured2 + 1 ]
end

local Table9 = { }
local Table10 = { }
local Table11 = { }
local Number2 = 0
local Callback2 = nil

local function CrossOff( Argument1 )
    local Cross = Argument1.cross

    if Cross then
        Argument1.cross = nil
        Cross.gui:Destroy( )
        Cross.anchor:Destroy( )
        return
    end
    return
end

local function CrossOn( E )
    local Cross = E.cross

    if Cross then
        E.cross = nil
        Cross.gui:Destroy( )
        Cross.anchor:Destroy( )
    end

    local DownedCross
    local WorldUI = game:GetService( "StarterGui" ):FindFirstChild( "WorldUI" )

    if WorldUI then
        DownedCross = WorldUI:FindFirstChild( "DownedCross" )
    else
        DownedCross = WorldUI
    end

    local Parent = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

    if not DownedCross or not Parent then
        return
    end
    local Adornee = Instance.new( "Part" )
    Adornee.Name = "DownedCrossAnchor"
    Adornee.Anchored = true
    Adornee.CanCollide = false
    Adornee.CanQuery = false
    Adornee.CanTouch = false
    Adornee.Transparency = 1
    Adornee.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
    Adornee.Parent = workspace.CurrentCamera
    local Clone = DownedCross:Clone( )
    Clone.Adornee = Adornee
    Clone.Enabled = true
    Clone.Parent = Parent
    E.cross = {
        anchor = Adornee,
        gui = Clone,
        ut = E.model:FindFirstChild( "UpperTorso" ),
        lt = E.model:FindFirstChild( "LowerTorso" )
    }
    return
end

local function Build( Key )
    local Clone = Children[ Key ]:Clone( )

    for Key2, Value in Clone:GetDescendants( ) do
        if Value:IsA( "FaceControls" ) then
            for Key9, Value11 in Value:GetAttributes( ) do
                pcall( function()
                    Value[ Key9 ] = Value11
                end )
            end
        end
    end

    local Animator2
    local HumanoidRootPart = Clone.HumanoidRootPart
    local ParentInner = Clone:FindFirstChildOfClass( "Humanoid" )
    local Animator = ParentInner:FindFirstChildOfClass( "Animator" )

    if Animator then
        Animator2 = Animator
    else
        Animator2 = Instance.new( "Animator" )
    end

    local Value1
    Animator2.Parent = ParentInner
    Clone:PivotTo( CFrame2 )
    Clone.Parent = Parent
    WeldAccessories( Clone )
    task.defer( WeldAccessories, Clone )
    Clone.DescendantAdded:Connect( function( Object )
        if Object:IsA( "RigidConstraint" ) then
            task.defer( WeldAccessories, Clone )
        end
    end )
    local TableInner = { model = Clone, root = HumanoidRootPart, tpl = Key, parts = { } }
    TableInner.tracks = { Idle = Animator2:LoadAnimation( Anims.Idle ) }
    TableInner.tracks.Idle.Looped = true
    local Table2 = { "Walk", "Run" }
    Value1 = nil

    for Key3, Value2 in Table2, nil, nil do
        if Anims:FindFirstChild( Value2 ) then
            local Tracks2 = TableInner.tracks
            Tracks2[ Value2 ] = Animator2:LoadAnimation( Anims[ Value2 ] )
            TableInner.tracks[ Value2 ].Looped = true
        end
    end
    if Anims:FindFirstChild( "Climb" ) then
        local Tracks = TableInner.tracks
        Tracks.Climb = Animator2:LoadAnimation( Anims.Climb )
        TableInner.tracks.Climb.Looped = true
    end

    local Base = { }
    local Wr = { }
    local Anim = { }
    TableInner.cyc = { }
    TableInner.base = Base
    TableInner.wr = Wr
    TableInner.anim = Anim
    TableInner.sockets = { }

    for Key4, Value3 in Clone:GetDescendants( ) do
        if Value3:IsA( "BallSocketConstraint" ) and Value3.Name:sub( -10 ) == "BallSocket" then
            table.insert( TableInner.sockets, Value3 )
        end
    end

    local Value4 = nil

    for Key5, Value5 in Table5, nil, nil do
        local FoundChild4
        local FoundChild3 = Clone:FindFirstChild( Value5 )

        if FoundChild3 then
            FoundChild4 = Clone[ Value5 ]:FindFirstChild( Key5 )
        else
            FoundChild4 = FoundChild3
        end
        if FoundChild4 then
            TableInner.cyc[ Key5 ] = FoundChild4
        end
    end

    local Value6
    TableInner.upper = { }
    Value6 = nil

    for Key6, Value7 in Table, nil, nil do
        local Entry = TableInner.cyc[ Value7 ]

        if Entry then
            TableInner.upper[ Value7 ] = Entry
        end
    end

    local Value8
    TableInner.joints = { }
    Value8 = nil

    for Key7, Value9 in Table, nil, nil do
        local FoundChild2
        local FoundChild = Clone:FindFirstChild( Key7 )

        if FoundChild then
            FoundChild2 = Clone[ Key7 ]:FindFirstChild( Value9 )
        else
            FoundChild2 = FoundChild
        end
        if FoundChild2 then
            TableInner.joints[ Key7 ] = FoundChild2
        end
    end

    local GripHold
    TableInner.grip = Clone.RightHand:FindFirstChild( "MeleeGrip" )
    TableInner.knife = Clone:FindFirstChild( "Knife" )
    local Knife = TableInner.knife
    GripHold = if Knife then TableInner.knife:GetAttribute( "GripRight" ) else Knife
    local GripStrike
    TableInner.gripHold = GripHold
    local Knife2 = TableInner.knife
    GripStrike = if Knife2 then TableInner.knife:GetAttribute( "GripStrike" ) else Knife2
    TableInner.gripStrike = GripStrike
    TableInner.hip = ParentInner.HipHeight + HumanoidRootPart.Size.Y / 2

    for Key8, Value10 in Clone:GetDescendants( ) do
        if Value10:IsA( "BasePart" ) and Value10.CanQuery then
            Table10[ Value10 ] = TableInner
            table.insert( TableInner.parts, Value10 )
        end
    end

    local Interactable
    TableInner.torso = Clone:FindFirstChild( "UpperTorso" ) or HumanoidRootPart
    TableInner.label = Phrase:Clone( )
    TableInner.label.Parent = LootGui
    local Text = TableInner.label.Text
    Text.Text = LootText( )
    local Label = TableInner.label

    if UserInputService:GetLastInputType( ) == Enum.UserInputType.Touch then
        Interactable = true
    else
        Interactable = Controls.TouchMode( )
    end

    Label.Interactable = Interactable
    TableInner.label.Activated:Connect( function( Argument1 )
        if TableInner.near and Argument1 and Argument1.UserInputType == Enum.UserInputType.Touch then
            Callback( TableInner )
        end
    end )
    local TouchZone = TableInner.label:FindFirstChild( "TouchZone" )

    if TouchZone and TouchZone:IsA( "GuiObject" ) then
        local Visible

        if UserInputService:GetLastInputType( ) == Enum.UserInputType.Touch then
            Visible = true
        else
            Visible = Controls.TouchMode( )
        end

        TouchZone.Visible = Visible
        TouchZone.InputBegan:Connect( function( Object )
            local Flag
            Flag = Object.UserInputType == Enum.UserInputType.Touch and true or false

            if Flag then
                Controls.LookTouch( Object )
                local Position = Object.Position
                local Clock = os.clock( )
                local Connect = nil
                Connect = Object:GetPropertyChangedSignal( "UserInputState" ):Connect( function()
                    local UserInputState = Object.UserInputState

                    if UserInputState ~= Enum.UserInputState.End and UserInputState ~= Enum.UserInputState.Cancel then
                        return
                    end

                    Connect:Disconnect( )

                    if UserInputState == Enum.UserInputState.End and ( Object.Position - Position ).Magnitude <= 25 and os.clock( ) - Clock <= 0.6 and TableInner.near then
                        Callback( TableInner )
                    end
                end )
                return
            end
            return
        end )
    end

    return TableInner
end

local function Acquire( Key2 )
    local Remove2
    local Entry = Table9[ Key2 ]

    if Entry then
        local Remove = table.remove( Entry )

        if Remove then
            Remove2 = Remove
        else
            Remove2 = Build( Key2 )
        end
    else
        Remove2 = Build( Key2 )
    end

    return Remove2
end

local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals", 10 )
local StarterPack = game:GetService( "StarterPack" )
local Table12 = { }
local Table13 = { }
local Weapons2 = Config.Weapons
Storage.Weapons3 = if Weapons2 then Weapons2 else { }
local Value4 = nil

for Key3, Value5 in Storage.Weapons3, nil, nil do
    Storage.Key5 = Value5.key
    Table12[ Key3 ] = Value5.key
    Table13[ Storage.Key5 ] = Key3
end

local Global2
task.defer( function()
    local Value1 = nil

    for Key, Value in Table12, nil, nil do
        KindOf( Value )
    end
end )

local function SetKnifeShown( E, Argument2 )
    if not E.knife then
        return
    end

    local KnifeT2
    local KnifeT = E.knifeT
    KnifeT2 = if KnifeT then KnifeT else { }
    E.knifeT = KnifeT2

    for Key, Value in E.knife:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            if E.knifeT[ Value ] == nil then
                local KnifeT3 = E.knifeT
                KnifeT3[ Value ] = Value.Transparency
            end

            local Transparency

            if Argument2 then
                local Entry = E.knifeT[ Value ]

                if Entry then
                    Transparency = Entry
                else
                    Transparency = 1
                end
            else
                Transparency = 1
            end

            Value.Transparency = Transparency
        end
    end
end

local function ResetGrip( Argument1 )
    if Argument1.grip and Argument1.gripHold then
        local Grip = Argument1.grip
        Grip.C0 = Argument1.gripHold
    end
    if Argument1.wgrip and Argument1.gl then
        local Wgrip = Argument1.wgrip
        Wgrip.C0 = Argument1.gl
    end

    Argument1.gripNow = nil
end

local function EquipWeapon( Argument1, WeaponName )
    local WeaponKey = WeaponName or "Knife"

    if Argument1.weaponKey == WeaponKey then
        return
    end
    if Argument1.weaponModel then
        Argument1.weaponModel:Destroy( )
        Argument1.weaponModel = nil
    end

    Argument1.weaponKey = WeaponKey
    local Kind = Table2.Knife
    local Wgrip = Argument1.grip
    local Gl = Argument1.gripHold
    local Gs = Argument1.gripStrike
    Argument1.kind = Kind
    Argument1.wgrip = Wgrip
    Argument1.gl = Gl
    Argument1.ga = nil
    Argument1.gs = Gs

    if Argument1.grip and Argument1.gripHold then
        local Grip = Argument1.grip
        Grip.C0 = Argument1.gripHold
    end
    if Argument1.wgrip and Argument1.gl then
        local Wgrip2 = Argument1.wgrip
        Wgrip2.C0 = Argument1.gl
    end

    Argument1.gripNow = nil
    SetKnifeShown( Argument1, true )

    if WeaponKey == "Knife" or not WeaponVisuals then
        return
    end

    local FoundChild2
    local Entry = MeleeData[ WeaponKey ]
    local Kind2 = KindOf( WeaponKey )
    local FoundChild = WeaponVisuals:FindFirstChild( WeaponKey )
    local BetaRollWeapons = ReplicatedStorage:FindFirstChild( "BetaRollWeapons" )

    if not BetaRollWeapons or not BetaRollWeapons:FindFirstChild( WeaponKey ) then
        FoundChild2 = StarterPack:FindFirstChild( WeaponKey )
    else
        FoundChild2 = BetaRollWeapons:FindFirstChild( WeaponKey )
    end

    local Part0

    if type( Entry ) == "table" then
        Part0 = Argument1.model:FindFirstChild( Entry.Hand )
    else
        Part0 = false
    end

    local C0

    if Part0 then
        if FoundChild2 then
            C0 = FoundChild2:GetAttribute( Entry.GripAttr )
        else
            C0 = FoundChild2
        end
    else
        C0 = Part0
    end
    if not FoundChild or typeof( C0 ) ~= "CFrame" or Kind2.d ~= Entry then
        return
    end

    local WeaponModel = FoundChild:Clone( )
    local Part02 = WeaponModel.PrimaryPart

    if not Part02 then
        WeaponModel:Destroy( )
        return
    end
    for Key, Value in WeaponModel:GetDescendants( ) do
        if Value:IsA( "BasePart" ) then
            Value.Anchored = false
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
            Value.Massless = true

            if Value ~= Part02 then
                local Weld = Instance.new( "Weld" )
                Weld.Part0 = Part02
                Weld.Part1 = Value
                Weld.C0 = Part02.CFrame:ToObjectSpace( Value.CFrame )
                Weld.Parent = Value
            end
        end
    end

    local Attribute
    local Wgrip3 = Instance.new( "Motor6D" )
    Wgrip3.Name = "HeldGrip"
    Wgrip3.Part0 = Part0
    Wgrip3.Part1 = Part02
    Wgrip3.C0 = C0
    Wgrip3.Parent = Part02
    WeaponModel.Name = "HeldWeapon"
    WeaponModel.Parent = Argument1.model
    Argument1.weaponModel = WeaponModel
    local AimGripAttr = Entry.AimGripAttr

    if AimGripAttr then
        Attribute = FoundChild2:GetAttribute( Entry.AimGripAttr )
    else
        Attribute = AimGripAttr
    end

    local Attribute2
    local StrikeGripAttr = Entry.StrikeGripAttr

    if StrikeGripAttr then
        Attribute2 = FoundChild2:GetAttribute( Entry.StrikeGripAttr )
    else
        Attribute2 = StrikeGripAttr
    end

    local Ga
    Argument1.kind = Kind2
    Argument1.wgrip = Wgrip3
    Argument1.gl = C0
    Argument1.gripNow = C0
    Ga = if typeof( Attribute ) ~= "CFrame" or not Attribute then nil else Attribute
    local Gs2
    Argument1.ga = Ga
    Gs2 = if typeof( Attribute2 ) ~= "CFrame" or not Attribute2 then nil else Attribute2
    Argument1.gs = Gs2
    SetKnifeShown( Argument1, false )
end

local Table14 = { }
local CollectionService = game:GetService( "CollectionService" )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local ModCatalog = require( Weapons:WaitForChild( "ModCatalog" ) )
local Holds = require( Weapons:WaitForChild( "Holds" ) )
local Global = require( Weapons:WaitForChild( "Config" ) ).Global
Global2 = if Global then Global else { }
local Tuto
local WALK = Global2.WalkSpeed or 16
local TURN = Global2.TurnSpeed or 14
Table14.WALK = WALK
Table14.TURN = TURN
Table14.WeaponData = WeaponData
local STANCE = { Low = 0, Aim = 1, Sprint = 2, Reload = 3, ReloadAim = 4 }
Table14.STANCE = STANCE
function Table14.setStance( Argument1, Stance )
    if Argument1.stance ~= Stance then
        Argument1.stance = Stance
        Argument1.model:SetAttribute( "GunStance", Stance )
    end
end

local function Drop( Argument1 )
    local GunTool = Argument1.gunTool

    if GunTool then
        Argument1.gunTool = nil
        GunTool:Destroy( )
        Argument1.root.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
        local GunTok = ( Argument1.gunTok or 0 ) + 1
        Argument1.gunTok = GunTok
        task.delay( 1.5, function()
            if Argument1.gunTok ~= GunTok or Argument1.gunTool then
                return
            end
            CollectionService:RemoveTag( Argument1.model, "GunBot" )
            Argument1.model:SetAttribute( "GunStance", nil )
            Argument1.model:SetAttribute( "GunPitch", nil )
            Argument1.stance = nil
            return
        end )
        return
    end
    return
end

local function Equip( Argument1, Name, Argument3 )
    local FoundChild
    local Entry = WeaponData[ Name ]
    local BetaRollWeapons = ReplicatedStorage:FindFirstChild( "BetaRollWeapons" )

    if not BetaRollWeapons or not BetaRollWeapons:FindFirstChild( Name ) then
        FoundChild = StarterPack:FindFirstChild( Name )
    else
        FoundChild = BetaRollWeapons:FindFirstChild( Name )
    end
    if not Entry or not FoundChild or not FoundChild:IsA( "Tool" ) or not FoundChild:FindFirstChild( "Handle" ) then
        return nil
    end
    if not Table14.Effects then
        local Success, Effects = pcall( require, Weapons:WaitForChild( "Effects" ) )

        if not Success then
            return nil
        end

        Table14.Effects = Effects
    end

    Drop( Argument1 )
    EquipWeapon( Argument1, "Knife" )
    SetKnifeShown( Argument1, false )
    local GunTool = FoundChild:Clone( )

    for Key, Value in GunTool:GetDescendants( ) do
        if Value:IsA( "LuaSourceContainer" ) then
            Value:Destroy( )
        elseif Value:IsA( "BasePart" ) then
            Value.Anchored = false
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
            Value.Massless = true
        end
    end

    local Decode = ModCatalog.Decode( Argument3 )
    local MagSize = ModCatalog.MagSize
    local MagSize2 = MagSize( Name, Decode, Entry.Ammo.Mag )
    local ReloadTime = ModCatalog.ReloadTime
    local ReloadTime2 = ReloadTime( Name, Decode, Entry.Ammo.ReloadTime )
    GunTool:SetAttribute( "Weapon", Name )
    GunTool:SetAttribute( "Mods", Argument3 )
    GunTool:SetAttribute( "ReloadTime", ReloadTime2 )
    GunTool:SetAttribute( "Reloading", false )
    GunTool:SetAttribute( "Ammo", MagSize2 )
    Argument1.gunTok = ( Argument1.gunTok or 0 ) + 1
    Argument1.gunTool = GunTool
    Argument1.model:SetAttribute( "GunPitch", 0 )
    local Stance = STANCE.Sprint

    if Argument1.stance ~= Stance then
        Argument1.stance = Stance
        Argument1.model:SetAttribute( "GunStance", Stance )
    end

    GunTool.Parent = Argument1.model
    CollectionService:AddTag( Argument1.model, "GunBot" )
    local Clock = os.clock( )
    return {
        key = Name,
        tool = GunTool,
        rpm = Entry.Fire.RPM,
        mag = MagSize2,
        ammo = MagSize2,
        reload = ReloadTime2,
        range = math.min( Entry.Damage.Range, 160 ),
        base = 3.5 + math.random( ) * 1.5,
        engage = 45 + math.random( ) * 30,
        keepFire = 0.4 + math.random( ) * 0.6,
        mode = "chase",
        nextSee = Clock + math.random( ) * 0.2,
        seeMe = false,
        reactAt = 0,
        nextShot = 0,
        burst = 0,
        repShots = 0,
        repHits = 0,
        repBotHits = 0,
        repAt = 0,
        strafe = 0,
        strafeUntil = 0,
        meBias = 0.7 + math.random( ) * 0.9,
        retargetAt = 0,
        nextScan = 0,
        vis = { },
        twist = Holds.AimTwist( Name ) or 0,
        aimWalk = Entry.Handling.AimWalkSpeed or 11,
        wantMove = Vector3.new( 0, 0, 0 ),
        pitchSent = 0,
        vel = Vector3.new( 0, 0, 0 )
    }
end

Table14.drop = Drop
Table14.equip = Equip

local function SetAnim( Argument1, Anim )
    local Anim2 = if Anim ~= "Idle" or not Argument1.zombie then Anim else nil

    if Argument1.anim == Anim2 then
        return
    end

    local Tracks = Argument1.e.tracks

    if Argument1.anim then
        Tracks[ Argument1.anim ]:Stop( 0.15 )
    end

    Argument1.anim = Anim2

    if Anim2 then
        Tracks[ Anim2 ]:Play( 0.15 )
    end
end

local function Callback3( Argument1 )
    if Table11[ Argument1.id ] ~= Argument1 then
        return
    end

    Table11[ Argument1.id ] = nil

    if Argument1.state ~= "dead" then
        Number2 = Number2 - 1
    end

    local E = Argument1.e
    E.npc = nil
    E.label.Visible = false
    E.near = nil
    E.ready = nil
    E.model:SetAttribute( "Lootable", nil )
    E.model:SetAttribute( "HoodDowned", nil )
    local Cross = E.cross

    if Cross then
        E.cross = nil
        Cross.gui:Destroy( )
        Cross.anchor:Destroy( )
    end
    if Argument1.gun then
        Table14.drop( E )
        Table14.physOff( E )
        SetKnifeShown( E, true )
    end

    local Anim
    Callback2( E )
    Anim = if true or not Argument1.zombie then nil else nil

    if Argument1.anim ~= Anim then
        local Tracks = Argument1.e.tracks

        if Argument1.anim then
            Tracks[ Argument1.anim ]:Stop( 0.15 )
        end

        Argument1.anim = Anim

        if Anim then
            Tracks[ Anim ]:Play( 0.15 )
        end
    end

    local Value1
    local Cyc = E.cyc
    Value1 = nil

    for Key, Value in Cyc, nil, nil do
        Value.Transform = CFrame.identity
    end

    table.clear( E.wr )
    table.clear( E.anim )

    if E.grip and E.gripHold then
        local Grip = E.grip
        Grip.C0 = E.gripHold
    end
    if E.wgrip and E.gl then
        local Wgrip = E.wgrip
        Wgrip.C0 = E.gl
    end

    local Value2
    E.gripNow = nil
    local Parts = E.parts
    Value2 = nil

    for Key2, Value3 in Parts, nil, nil do
        Value3.CanQuery = true
    end

    local Entry2
    E.root.CFrame = CFrame2
    local Tpl = E.tpl
    local Entry = Table9[ E.tpl ]
    Entry2 = if Entry then Entry else { }
    Table9[ Tpl ] = Entry2
    table.insert( Table9[ E.tpl ], E )
end

local function Gone( Argument1 )
    Remote:FireServer( "gone", Argument1.id )
    Callback3( Argument1 )
end

local PhysicsService = game:GetService( "PhysicsService" )
local AntiTunnel = require( ReplicatedStorage:WaitForChild( "AntiTunnel" ) )

local function Settled( Argument1, Amount )
    local Flag

    if Amount > 12 then
        Flag = true
    elseif Amount > 4 then
        if Argument1.torso.AssemblyLinearVelocity.Magnitude < 2 then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function RagGroup()
    local Success, Result = pcall( PhysicsService.IsCollisionGroupRegistered, PhysicsService, "Ragdoll" )

    if not Success or not Result then
        return "Default"
    end
    return "Ragdoll"
end

local function RagdollGo( Argument1 )
    local Value1
    local E = Argument1.e
    local Cyc = E.cyc
    Value1 = nil

    for Key, Value in Cyc, nil, nil do
        if Key ~= "Root" then
            Value.Enabled = false
        end
    end

    local Value2
    local Sockets = E.sockets
    Value2 = nil

    for Key2, Value3 in Sockets, nil, nil do
        Value3.Enabled = true
    end

    local CollisionGroup
    local Success, Result = pcall( PhysicsService.IsCollisionGroupRegistered, PhysicsService, "Ragdoll" )
    CollisionGroup = ( not Success or not Result ) and "Default" or "Ragdoll"
    local Value4
    local Parts = E.parts
    Value4 = nil

    for Key3, Value5 in Parts, nil, nil do
        Value5.CanCollide = true
        Value5.CollisionGroup = CollisionGroup
    end
    if Argument1.dir then
        local Value6
        local Table = { "UpperTorso", "LowerTorso", "Head" }
        Value6 = nil

        for Key4, Value7 in Table, nil, nil do
            local FoundChild = E.model:FindFirstChild( Value7 )

            if FoundChild then
                FoundChild:ApplyImpulse( Argument1.dir * FoundChild:GetMass( ) * 12 )
            end
        end
    end

    local Track2
    local Track = AntiTunnel.Track
    local Success2, Result2 = pcall( Track, E.model, nil )
    Track2 = Success2 and Result2 or nil
    Argument1.track = Track2
end

local function Freeze( Argument1 )
    local Value1
    local Parts = Argument1.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        Value.Anchored = true
        Value.CanCollide = false
    end

    Argument1.root.Anchored = true
end

Callback2 = function( E )
    local Value1
    local Sockets = E.sockets
    Value1 = nil

    for Key, Value in Sockets, nil, nil do
        Value.Enabled = false
    end

    local Value2
    local Cyc = E.cyc
    Value2 = nil

    for Key2, Value3 in Cyc, nil, nil do
        Value3.Enabled = true
        Value3.Transform = CFrame.identity
    end

    local Value4
    local Parts = E.parts
    Value4 = nil

    for Key3, Value5 in Parts, nil, nil do
        Value5.Anchored = false
        Value5.CanCollide = false
        Value5.Massless = true
        Value5.CollisionGroup = "Hitbox"
        Value5.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
        Value5.AssemblyAngularVelocity = Vector3.new( 0, 0, 0 )
    end

    E.root.Anchored = true
end

local function Die( Argument1, Dir )
    if Argument1.state == "dead" then
        return
    end

    local Anim
    Argument1.state = "dead"
    Number2 = Number2 - 1
    Argument1.deadAt = os.clock( )
    Anim = if true or not Argument1.zombie then nil else nil

    if Argument1.anim ~= Anim then
        local Tracks = Argument1.e.tracks

        if Argument1.anim then
            Tracks[ Argument1.anim ]:Stop( 0.15 )
        end

        Argument1.anim = Anim

        if Anim then
            Tracks[ Anim ]:Play( 0.15 )
        end
    end

    Argument1.swing = nil
    local E = Argument1.e
    E.model:SetAttribute( "HoodDowned", nil )
    local Cross = E.cross

    if Cross then
        E.cross = nil
        Cross.gui:Destroy( )
        Cross.anchor:Destroy( )
    end

    local Value1
    local Parts = E.parts
    Value1 = nil

    for Key, Value in Parts, nil, nil do
        Value.CanQuery = false
        Value.Massless = false
    end
    if not Argument1.noLoot and not Argument1.gun then
        E.model:SetAttribute( "Lootable", true )
        task.delay( 0.3, function()
            if E.npc == Argument1 and Argument1.state == "dead" then
                E.ready = true
            end
        end )
    end

    Argument1.dir = Dir
    Argument1.rag = 1

    if Argument1.gun then
        Table14.drop( E )
        Table14.physOff( E, true )
    end

    E.root.Anchored = false
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.RespectCanCollide = true
Table14.shotParams = RaycastParams.new( )
Table14.shotParams.FilterType = Enum.RaycastFilterType.Exclude
Table14.shotParams.CollisionGroup = "Bullet"
local Table15 = nil
local Number3 = 0

local function RefreshIgnore( Amount )
    if Amount < Number3 then
        return
    end

    Number3 = Amount + 2
    local FilterDescendantsInstances = { Parent }
    local FX = workspace:FindFirstChild( "FX" )

    if FX then
        table.insert( FilterDescendantsInstances, FX )
    end
    for Key, Value in Players:GetPlayers( ) do
        if Value.Character then
            table.insert( FilterDescendantsInstances, Value.Character )
        end
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    Table14.shotParams.FilterDescendantsInstances = FilterDescendantsInstances
    local FilterDescendantsInstances2 = table.clone( FilterDescendantsInstances )
    local Value1 = nil

    for Key2, Value2 in Table15 or { }, nil, nil do
        table.insert( FilterDescendantsInstances2, Value2 )
    end

    RaycastParams3.FilterDescendantsInstances = FilterDescendantsInstances2
end

local Callback4 = nil

local function ClearLine( Argument1, Argument2 )
    local Total = Argument2 - Argument1

    if Total.Magnitude < 0.5 then
        return true
    end
    if Callback4 and Callback4( Argument1, Argument2 ) then
        return false
    end

    local Spherecast2
    local Spherecast = workspace:Spherecast( Argument1 + Vector3.new( 0, 3.0999999046325684, 0 ), 1, Total, RaycastParams2 )
    Spherecast2 = if Spherecast then Spherecast else workspace:Spherecast( Argument1 + Vector3.new( 0, 4.300000190734863, 0 ), 1, Total, RaycastParams2 )
    return not Spherecast2
end

local Table16 = { }
Table15 = { }
local Folder = Instance.new( "Folder" )
Folder.Name = "HoodNav"
Folder.Parent = workspace
local Table17 = { }

local function ShelfOf( Object, Map )
    local Parent = Object

    while Parent do
        if Parent == Map then
            break
        end
        if Parent:IsA( "Model" ) and string.find( string.lower( Parent.Name ), "shelf", 1, true ) then
            return Parent
        end

        Parent = Parent.Parent
    end

    return nil
end

local function UpdateShelf( Model )
    if not Model.Parent or not Model:FindFirstChildWhichIsA( "BasePart", true ) then
        return
    end

    local Entry2
    local Cf, BoundingBox2 = Model:GetBoundingBox( )
    local Entry = Table17[ Model ]

    if Entry then
        Entry2 = Entry
    else
        local Table = { }
        Table17[ Model ] = Table
        table.insert( Table16, Table )
        table.insert( Table15, Model )
        local Parent = Instance.new( "Part" )
        Parent.Name = "HoodShelfAvoid"
        Parent.Anchored = true
        Parent.CanCollide = false
        Parent.CanQuery = false
        Parent.CanTouch = false
        Parent.Transparency = 1
        local PathfindingModifier = Instance.new( "PathfindingModifier" )
        PathfindingModifier.Label = "HoodShelf"
        PathfindingModifier.Parent = Parent
        Parent.Parent = Folder
        Table.vol = Parent
        Entry2 = Table
    end

    local Half = BoundingBox2 / 2
    Entry2.cf = Cf
    Entry2.half = Half
    Entry2.vol.CFrame = Cf
    local Vol = Entry2.vol
    Vol.Size = BoundingBox2 + Vector3.new( 1.5, 0, 1.5 )
end

task.spawn( function()
    local Map = workspace:WaitForChild( "Map", 30 )

    if not Map then
        return
    end

    local Table = { }
    Map.DescendantAdded:Connect( function( Object2 )
        if Object2:IsA( "BasePart" ) or Object2:IsA( "Model" ) then
            local ShelfOf2 = ShelfOf( Object2, Map )

            if ShelfOf2 then
                Table[ ShelfOf2 ] = true
            end
        end
    end )

    for Key, Value in Map:GetDescendants( ) do
        if Value:IsA( "Model" ) and string.find( string.lower( Value.Name ), "shelf", 1, true ) then
            UpdateShelf( Value )
        end
    end
    while true do
        task.wait( 1 )

        if next( Table ) then
            local Value1 = nil

            for Value2 in Table, nil, nil do
                UpdateShelf( Value2 )
            end

            table.clear( Table )
            Number3 = 0
        end
    end
end )

local function SolidAt( Argument1, Argument2 )
    local Value1 = nil

    for Key, Value in Table16, nil, nil do
        local PointToObjectSpace = Value.cf:PointToObjectSpace( Argument1 )
        local X = Value.half.X + 1
        local Z = Value.half.Z + 1

        if math.abs( PointToObjectSpace.X ) < X and math.abs( PointToObjectSpace.Z ) < Z and -Value.half.Y - 6 < PointToObjectSpace.Y then
            if PointToObjectSpace.Y < Value.half.Y + 1 then
                local Flag, PointToObjectSpace3

                if Argument2 then
                    local PointToObjectSpace2 = Value.cf:PointToObjectSpace( Argument2 )
                    local Abs = math.abs( PointToObjectSpace2.X ) - X
                    local Abs2 = math.abs( PointToObjectSpace2.Z ) - Z

                    if Abs > 0 or Abs2 > 0 then
                        if Abs2 < Abs then
                            Flag = true
                        else
                            Flag = false
                        end

                        PointToObjectSpace3 = PointToObjectSpace2
                    else
                        Flag = nil
                        PointToObjectSpace3 = PointToObjectSpace
                    end
                else
                    Flag = nil
                    PointToObjectSpace3 = PointToObjectSpace
                end
                if Flag == nil then
                    if X - math.abs( PointToObjectSpace3.X ) < Z - math.abs( PointToObjectSpace3.Z ) then
                        Flag = true
                    else
                        Flag = false
                    end
                end

                local VectorToWorldSpace2

                if Flag then
                    local VectorToWorldSpace = Value.cf:VectorToWorldSpace( ( Vector3.new( math.sign( PointToObjectSpace3.X ), 0, 0 ) ) )

                    if VectorToWorldSpace then
                        VectorToWorldSpace2 = VectorToWorldSpace
                    else
                        VectorToWorldSpace2 = Value.cf:VectorToWorldSpace( ( Vector3.new( 0, 0, ( math.sign( PointToObjectSpace3.Z ) ) ) ) )
                    end
                else
                    VectorToWorldSpace2 = Value.cf:VectorToWorldSpace( ( Vector3.new( 0, 0, ( math.sign( PointToObjectSpace3.Z ) ) ) ) )
                end

                local X2 = VectorToWorldSpace2.X
                return Vector3.new( X2, 0, VectorToWorldSpace2.Z ).Unit
            end
        end
    end

    return nil
end

Callback4 = function( Argument1, Argument2 )
    local Captured, Value1, Value2, Value3, Value4, Table2, Value5, Value6, Number, Number2, Flag
    local Total = ( Argument1 + Argument2 ) / 2
    local Magnitude = ( Argument2 - Argument1 ).Magnitude / 2
    Captured = Table16
    Value1 = nil
    Value2 = nil
    Value3 = Argument1
    Value4 = Argument2

    for Key, Value in Captured, Value1, nil do
        local X = Value.half.X
        local Max = math.max( X, Value.half.Z ) + 1 + Magnitude + 1
        local Position = Value.cf.Position
        local X2 = Position.X - Total.X

        if Vector3.new( X2, 0, Position.Z - Total.Z ).Magnitude <= Max and math.abs( Position.Y - Total.Y ) < Value.half.Y + 6 then
            local PointToObjectSpace = Value.cf:PointToObjectSpace( Value3 )
            local PointToObjectSpace2 = Value.cf:PointToObjectSpace( Value4 )
            local X3 = Value.half.X + 1
            local Z = Value.half.Z + 1
            local X4 = PointToObjectSpace.X
            local Table = { X4, PointToObjectSpace2.X - PointToObjectSpace.X, X3 }
            local Z2 = PointToObjectSpace.Z
            Table2 = { Table, { Z2, PointToObjectSpace2.Z - PointToObjectSpace.Z, Z } }
            Value5 = nil
            Value6 = nil
            Number = 0
            Number2 = 1
            Flag = true
            Value2 = Key

            for Key2, Value7 in Table2, Value5, Value6 do
                local Item = Value7[ 1 ]
                local Item2 = Value7[ 2 ]
                local Item3 = Value7[ 3 ]

                if math.abs( Item2 ) < 1e-06 then
                    if Item3 < math.abs( Item ) then
                        Flag = false
                        break
                    end
                    Value6 = Key2
                else
                    local Amount2, Item5
                    local Amount = ( -Item3 - Item ) / Item2
                    local Item4 = ( Item3 - Item ) / Item2

                    if Item4 < Amount then
                        Amount2 = Item4
                        Item5 = Amount
                    else
                        Amount2 = Amount
                        Item5 = Item4
                    end

                    local Max2 = math.max( Number, Amount2 )
                    local Min = math.min( Number2, Item5 )

                    if Min < Max2 then
                        Flag = false
                        break
                    end
                    Value6 = Key2
                    Number = Max2
                    Number2 = Min
                end
            end
            if Flag then
                return true
            end
        end
    end

    return false
end

local function ShelfExit( Argument1 )
    local Value1 = nil

    for Key, Value in Table16, nil, nil do
        local PointToObjectSpace = Value.cf:PointToObjectSpace( Argument1 + Vector3.new( 0, 2, 0 ) )
        local X = Value.half.X + 1
        local Z = Value.half.Z + 1

        if math.abs( PointToObjectSpace.X ) < X and math.abs( PointToObjectSpace.Z ) < Z and -Value.half.Y - 6 < PointToObjectSpace.Y then
            if PointToObjectSpace.Y < Value.half.Y + 1 then
                local Vector32

                if X - math.abs( PointToObjectSpace.X ) < Z - math.abs( PointToObjectSpace.Z ) then
                    local Sign = math.sign( PointToObjectSpace.X ) * ( X + 0.3 )
                    local Y = PointToObjectSpace.Y
                    Vector32 = Vector3.new( Sign, Y, PointToObjectSpace.Z )
                else
                    local X2 = PointToObjectSpace.X
                    local Y2 = PointToObjectSpace.Y
                    Vector32 = Vector3.new( X2, Y2, math.sign( PointToObjectSpace.Z ) * ( Z + 0.3 ) )
                end

                local PointToWorldSpace = Value.cf:PointToWorldSpace( Vector32 )
                local X3 = PointToWorldSpace.X
                local Y3 = Argument1.Y
                return ( Vector3.new( X3, Y3, PointToWorldSpace.Z ) )
            end
        end
    end

    return nil
end

local function BlockedBy( Argument1, Argument2 )
    local Magnitude = Argument2.Magnitude

    if Magnitude < 0.0001 then
        return nil
    end

    local Spherecast2
    local Magnitude2 = Argument2 / Magnitude * ( Magnitude + 0.5 )
    local Spherecast = workspace:Spherecast( Argument1 + Vector3.new( 0, 3.0999999046325684, 0 ), 1, Magnitude2, RaycastParams2 )
    Spherecast2 = if Spherecast then Spherecast else workspace:Spherecast( Argument1 + Vector3.new( 0, 4.300000190734863, 0 ), 1, Magnitude2, RaycastParams2 )
    return Spherecast2
end

local function Ground( Argument1 )
    local Raycast2
    local Raycast = workspace:Raycast( Argument1 + Vector3.new( 0, 2, 0 ), Vector3.new( 0, -90, 0 ), RaycastParams2 )
    Raycast2 = if Raycast then Raycast.Position.Y else Raycast
    return Raycast2
end

local Table18 = {
    {
        obj = PathfindingService:CreatePath( {
            AgentRadius = 1.6,
            AgentHeight = 5,
            AgentCanJump = false,
            WaypointSpacing = 5,
            Costs = { HoodShelf = math.huge }
        } ),
        busy = false
    },
    {
        obj = PathfindingService:CreatePath( {
            AgentRadius = 1.6,
            AgentHeight = 5,
            AgentCanJump = false,
            WaypointSpacing = 5,
            Costs = { HoodShelf = math.huge }
        } ),
        busy = false
    },
    {
        obj = PathfindingService:CreatePath( {
            AgentRadius = 1.6,
            AgentHeight = 5,
            AgentCanJump = false,
            WaypointSpacing = 5,
            Costs = { HoodShelf = math.huge }
        } ),
        busy = false
    },
    {
        obj = PathfindingService:CreatePath( {
            AgentRadius = 1.6,
            AgentHeight = 5,
            AgentCanJump = false,
            WaypointSpacing = 5,
            Costs = { HoodShelf = math.huge }
        } ),
        busy = false
    }
}

local function RequestPath( Argument1, Argument2, Amount )
    if Amount < Argument1.nextPathAt then
        return
    end

    local Value1, Value2
    Value1 = nil

    for Key, Value in Table18, nil, nil do
        if not Value.busy then
            Value2 = Value
            break
        end

        Value2 = nil
    end
    if not Value2 then
        return
    end

    local LastFree
    Argument1.nextPathAt = Amount + 1
    Value2.busy = true
    local Obj = Value2.obj
    LastFree = Argument1.startFail and Argument1.lastFree or Argument1.pos
    Argument1.startFail = nil
    task.spawn( function()
        local Success = pcall( Obj.ComputeAsync, Obj, LastFree, Argument2 )
        Value2.busy = false

        if not Success or Table11[ Argument1.id ] ~= Argument1 or Argument1.state == "dead" then
            return
        end

        local Status = Obj.Status

        if Status == Enum.PathStatus.FailStartNotEmpty then
            Argument1.startFail = true
            Argument1.nextPathAt = 0
            return
        end
        if Status ~= Enum.PathStatus.Success and Status ~= Enum.PathStatus.ClosestNoPath then
            return
        end

        local Number
        local Path = { }
        Number = 0

        for Key, Value in Obj:GetWaypoints( ) do
            if #Path > 0 then
                Number = Number + ( Value.Position - Path[ #Path ] ).Magnitude
            end

            table.insert( Path, Value.Position )
        end

        local PathUntil = os.clock( ) + math.max( 2.5, Number / Config.Speed + 1 )
        Argument1.path = Path
        Argument1.wp = 2
        Argument1.pathUntil = PathUntil
        Argument1.pathGoal = Argument2
    end )
end

Callback = function( Argument1 )
    local Npc = Argument1.npc

    if not Npc or Npc.state ~= "dead" or not Argument1.ready or not Argument1.near then
        return false
    end
    Remote:FireServer( "loot", Npc.id, Argument1.torso.Position )
    Callback3( Npc )
    return true
end

local function InRange( E, Argument2 )
    local Position = E.torso.Position - Argument2

    if FarmNav.PlayerOnLedge( Argument2 ) then
        local Flag

        if Vector2.new( Position.X, Position.Z ).Magnitude <= FarmNav.LEDGE_LOOT_RANGE then
            if math.abs( Position.Y ) <= FarmNav.LEDGE_LOOT_DY then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end

        return Flag
    end
    local Flag2

    if Vector2.new( Position.X, Position.Z ).Magnitude <= 12 then
        if math.abs( Position.Y ) <= 7 then
            Flag2 = true
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    return Flag2
end

RunService.RenderStepped:Connect( function()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Value1
    local CurrentCamera = workspace.CurrentCamera
    local ViewportSize = CurrentCamera.ViewportSize
    Value1 = nil

    for Key, Value in Table11, nil, nil do
        local E = Value.e
        local Cross = E.cross

        if Cross then
            local Position2

            if not Cross.ut or not Cross.lt then
                Position2 = E.root.Position
            else
                local Position = ( Cross.ut.Position + Cross.lt.Position ) / 2

                if Position then
                    Position2 = Position
                else
                    Position2 = E.root.Position
                end
            end

            local Anchor = Cross.anchor
            Anchor.CFrame = CFrame.new( Position2 + Vector3.new( 0, 3, 0 ) )
        end
        if Value.state == "dead" and E.ready then
            local Near

            if HumanoidRootPart == nil then
                Near = false
            else
                Near = InRange( E, HumanoidRootPart.Position )
            end
            if E.near ~= Near then
                E.near = Near

                if not Near then
                    E.label.Visible = false
                end
            end
            if E.near then
                local WorldToViewportPoint, Visible = CurrentCamera:WorldToViewportPoint( E.torso.Position + Vector3.new( 0, 0.699999988079071, 0 ) )
                E.label.Visible = Visible

                if Visible then
                    local Label = E.label
                    Label.Position = UDim2.fromScale( WorldToViewportPoint.X / ViewportSize.X, WorldToViewportPoint.Y / ViewportSize.Y )
                end
            end
        end
    end
end )

local function NearestLoot()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Magnitude2, E2

    if HumanoidRootPart then
        local Value1 = nil
        Magnitude2 = nil
        E2 = nil

        for Key, Value in Table11, nil, nil do
            local E = Value.e

            if Value.state == "dead" and E.ready and E.near then
                local Magnitude = ( E.torso.Position - HumanoidRootPart.Position ).Magnitude

                if not Magnitude2 or Magnitude < Magnitude2 then
                    Magnitude2 = Magnitude
                    E2 = E
                end
            end
        end
    else
        E2 = nil
        Magnitude2 = nil
    end

    return E2, Magnitude2
end

function ClientState.HoodLootNear()
    return ( select( 2, NearestLoot( ) ) )
end
function ClientState.HoodLootNow()
    local Flag
    local NearestLoot2 = NearestLoot( )

    if NearestLoot2 == nil then
        Flag = false
    else
        Flag = Callback( NearestLoot2 )
    end

    return Flag
end

local function OnLootKey( Argument1, Argument2 )
    if Argument2 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass
    end

    local NearestLoot2 = NearestLoot( )

    if NearestLoot2 then
        Callback( NearestLoot2 )
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

local function RefreshLootTexts()
    local Visible
    local Text = LootText( )

    if UserInputService:GetLastInputType( ) == Enum.UserInputType.Touch then
        Visible = true
    else
        Visible = Controls.TouchMode( )
    end

    local Value1

    local function Apply( Argument1 )
        Argument1.label.Text.Text = Text
        local TouchZone = Argument1.label:FindFirstChild( "TouchZone" )

        if TouchZone then
            TouchZone.Visible = Visible
        end

        Argument1.label.Interactable = Visible
    end

    Value1 = nil

    for Key, Value in Table9, nil, nil do
        local Value4 = nil

        for Key3, Value5 in Value, nil, nil do
            Value5.label.Text.Text = Text
            local TouchZone2 = Value5.label:FindFirstChild( "TouchZone" )

            if TouchZone2 then
                TouchZone2.Visible = Visible
            end

            Value5.label.Interactable = Visible
        end
    end

    local Value2 = nil

    for Key2, Value3 in Table11, nil, nil do
        local E = Value3.e
        E.label.Text.Text = Text
        local TouchZone = E.label:FindFirstChild( "TouchZone" )

        if TouchZone then
            TouchZone.Visible = Visible
        end

        E.label.Interactable = Visible
    end
end

local function BindLoot()
    ContextActionService:UnbindAction( "HoodLoot" )
    local LootInputs2 = LootInputs( )
    table.insert( LootInputs2, Enum.KeyCode.ButtonX )
    ContextActionService:BindActionAtPriority( "HoodLoot", OnLootKey, false, Enum.ContextActionPriority.High.Value + 50, table.unpack( LootInputs2 ) )
end

ContextActionService:UnbindAction( "HoodLoot" )
local LootInputs2 = LootInputs( )
table.insert( LootInputs2, Enum.KeyCode.ButtonX )
ContextActionService:BindActionAtPriority( "HoodLoot", OnLootKey, false, Enum.ContextActionPriority.High.Value + 50, table.unpack( LootInputs2 ) )
Controls.BindsChanged:Connect( function()
    ContextActionService:UnbindAction( "HoodLoot" )
    local LootInputs2 = LootInputs( )
    table.insert( LootInputs2, Enum.KeyCode.ButtonX )
    ContextActionService:BindActionAtPriority( "HoodLoot", OnLootKey, false, Enum.ContextActionPriority.High.Value + 50, table.unpack( LootInputs2 ) )
    RefreshLootTexts( )
end )
UserInputService.LastInputTypeChanged:Connect( RefreshLootTexts )
Remote.OnClientEvent:Connect( function( Name, Key, Key2, Hp, Argument5, WeaponName, Pack, Armor, Amount, Amount2 )
    if Name == "spawn" then
        if Table11[ Key ] or typeof( Key2 ) ~= "Vector3" or not Children[ Hp ] then
            return
        end

        local Zombie

        if ReplicatedStorage:GetAttribute( "HalloweenEvent" ) == true then
            if typeof( Key2 ) == "Vector3" then
                if FarmZone.Contains( Key2 ) == true then
                    Zombie = true
                else
                    Zombie = false
                end
            else
                Zombie = false
            end
        else
            Zombie = false
        end

        local Remove2
        local TplFor2 = TplFor( Hp, Zombie, Armor )
        local Entry = Table9[ TplFor2 ]

        if Entry then
            local Remove = table.remove( Entry )

            if Remove then
                Remove2 = Remove
            else
                Remove2 = Build( TplFor2 )
            end
        else
            Remove2 = Build( TplFor2 )
        end

        local Gun

        if type( WeaponName ) ~= "string" or type( Amount ) ~= "string" then
            Gun = nil
        else
            local Equip = Table14.equip( Remove2, WeaponName, Amount )

            if Equip then
                Gun = Equip
            else
                Gun = nil
            end
        end
        if not Gun then
            local Value2 = type( WeaponName ) == "string" and not Table14.WeaponData[ WeaponName ] and WeaponName or nil
            EquipWeapon( Remove2, Value2 )
        end

        local Npc = {
            id = Key,
            e = Remove2,
            pos = Key2,
            gy = Key2.Y,
            hp = Argument5,
            state = "chase",
            yaw = math.random( ) * 6.28,
            lastAtk = 0,
            nextProbe = 0,
            nextPathAt = 0,
            gAcc = math.random( 0, 1 ),
            phase = math.random( ),
            runW = 0,
            aim = 0,
            dist = math.huge,
            moving = false
        }

        if typeof( Pack ) == "Vector3" then
            Npc.pack = Pack
        end

        Npc.zombie = Zombie
        Npc.gun = Gun

        if Gun then
            Table14.physOn( Npc )
        end
        if type( Amount2 ) == "number" and Amount2 > 0 then
            Npc.armored = true
            local CollectionService = game:GetService( "CollectionService" )
            CollectionService:AddTag( Remove2.model, "ArmorWearer" )
            Remove2.model:SetAttribute( "Armor", Amount2 )
        end

        Remove2.npc = Npc
        Table11[ Key ] = Npc
        Number2 = Number2 + 1
        return
    end
    if Name == "dmg" then
        local Entry2 = Table11[ Key ]

        if not Entry2 then
            return
        end

        local Head2
        Entry2.hp = Hp

        if typeof( WeaponName ) ~= "Vector3" or not WeaponName then
            local Head = Entry2.e.model:FindFirstChild( "Head" )

            if Head then
                Head2 = Entry2.e.model.Head.Position
            else
                Head2 = Head
            end
        else
            Head2 = WeaponName
        end

        local Headshot
        local Table = { HitPos = Head2, Damage = Key2, Downable = false }
        Headshot = Argument5 == true and true or false
        local Killed
        Table.Headshot = Headshot
        Table.Target = Entry2.e.model
        Killed = Hp <= 0 and true or false
        Table.Killed = Killed

        if Entry2.armored then
            if type( Armor ) == "number" and Armor > 0 then
                Table.Armor = Armor
            end
            if type( Amount ) == "number" then
                local ObjectValue
                local Parent = Entry2.e.hum
                local LastAttackerChar = Parent:FindFirstChild( "LastAttackerChar" )

                if LastAttackerChar then
                    ObjectValue = LastAttackerChar
                else
                    ObjectValue = Instance.new( "ObjectValue" )
                end

                ObjectValue.Name = "LastAttackerChar"
                ObjectValue.Value = LocalPlayer.Character
                ObjectValue.Parent = Parent

                if Amount <= 0 then
                    Entry2.armored = nil
                end

                local Value3
                local Model = Entry2.e.model
                Value3 = Amount > 0 and Amount or nil
                Model:SetAttribute( "Armor", Value3 )
            end
        end
        if ClientState.ShowDamageNumber and Head2 then
            ClientState.ShowDamageNumber( Table )
        end
        if not ClientState.ConfirmHit or not Head2 then
            if ClientState.ShowHitmarker then
                ClientState.ShowHitmarker( Table )
            end
        else
            ClientState.ConfirmHit( Table )
        end
        if Hp <= 0 then
            local HumanoidRootPart
            local Character = LocalPlayer.Character

            if Character then
                HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
            else
                HumanoidRootPart = Character
            end

            local Character2 = if HumanoidRootPart then ( Entry2.e.root.Position - HumanoidRootPart.Position ) * Vector3.new( 1, 0, 1 ) else HumanoidRootPart
            local Unit = Character2 and Character2.Magnitude > 0.1 and Character2.Unit or nil
            Die( Entry2, Unit )
            return
        end
    elseif Name == "down" then
        local Entry3 = Table11[ Key ]

        if not Entry3 or not Entry3.gun or Entry3.state == "dead" or Entry3.state == "down" then
            return
        end

        local HumanoidRootPart2
        local E = Entry3.e
        local Character3 = LocalPlayer.Character

        if Character3 then
            HumanoidRootPart2 = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart2 = Character3
        end

        local Character4 = if HumanoidRootPart2 then ( E.root.Position - HumanoidRootPart2.Position ) * Vector3.new( 1, 0, 1 ) else HumanoidRootPart2
        local Anim
        local DownAt = os.clock( )
        Entry3.state = "down"
        Entry3.downAt = DownAt
        Anim = if true or not Entry3.zombie then nil else nil

        if Entry3.anim ~= Anim then
            local Tracks = Entry3.e.tracks

            if Entry3.anim then
                Tracks[ Entry3.anim ]:Stop( 0.15 )
            end

            Entry3.anim = Anim

            if Anim then
                Tracks[ Anim ]:Play( 0.15 )
            end
        end

        local Value4
        Entry3.swing = nil
        local Parts = E.parts
        Value4 = nil

        for Key4, Value in Parts, nil, nil do
            Value.Massless = false
        end

        local Dir
        Table14.drop( E )
        Table14.physOff( E, true )
        E.root.Anchored = false
        Dir = Character4 and Character4.Magnitude > 0.1 and Character4.Unit or nil
        Entry3.dir = Dir
        Entry3.rag = 1
        E.model:SetAttribute( "HoodDowned", true )
        CrossOn( E )
        return
    elseif Name == "bkill" then
        local Entry4 = Table11[ Key ]

        if not Entry4 or Entry4.state == "dead" then
            return
        end

        local Entry6
        Entry4.noLoot = true
        local Entry5 = Table11[ Key2 ]
        Entry6 = if Entry5 then ( Entry4.pos - Entry5.pos ) * Vector3.new( 1, 0, 1 ) else Entry5
        local Unit2 = Entry6 and Entry6.Magnitude > 0.1 and Entry6.Unit or nil
        Die( Entry4, Unit2 )
        return
    elseif Name == "gone" then
        local Entry7 = Table11[ Key ]

        if Entry7 then
            Callback3( Entry7 )
            return
        end
    elseif Name == "clear" then
        local Value5 = nil

        for Key5, Value6 in Table11, nil, nil do
            Callback3( Value6 )
        end
    end

    return
end )

local function OnHead( Accessory, Head )
    local Handle = Accessory:FindFirstChild( "Handle" )

    if not Handle then
        return false
    end
    for Key, Value in Handle:GetChildren( ) do
        if Value:IsA( "Attachment" ) then
            if Head:FindFirstChild( Value.Name ) then
                return true
            end
        end
    end

    return false
end

local function IsHead( Self, Argument2, Argument3 )
    if Self.Name == "Head" then
        return true
    end

    local Head = Argument2.model:FindFirstChild( "Head" )
    local Accessory = Self:FindFirstAncestorOfClass( "Accessory" )

    if not Head or not Accessory then
        return false
    end
    if OnHead( Accessory, Head ) then
        return true
    end
    if typeof( Argument3 ) ~= "Vector3" then
        return false
    end

    local Flag
    local PointToObjectSpace = Head.CFrame:PointToObjectSpace( Argument3 )
    local Size = Head.Size / 2 + Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )

    if math.abs( PointToObjectSpace.X ) <= Size.X then
        if math.abs( PointToObjectSpace.Y ) <= Size.Y then
            if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

function ClientState.HoodShot( Key, Argument2, Self, Argument4, Argument5 )
    if not ( Self and Table10[ Self ] and ( Self and Table10[ Self ] ).npc ) or ( Self and Table10[ Self ] and ( Self and Table10[ Self ] ).npc ).state == "dead" then
        return false
    end

    local Value1

    if Table10[ Key ] == ( Self and Table10[ Self ] ) then
        Value1 = Argument2
    else
        if typeof( Argument4 ) ~= "Vector3" or typeof( Argument5 ) ~= "Vector3" then
            return false
        end
        if typeof( Argument2 ) == "Vector3" and ( Argument2 - Argument5 ).Magnitude < ( Argument4 - Argument5 ).Magnitude - 0.5 then
            return false
        end

        Value1 = Argument4
    end

    local Id = ( Self and Table10[ Self ] and ( Self and Table10[ Self ] ).npc ).id
    Remote:FireServer( "shot", Id, Value1, ( IsHead( Self, Self and Table10[ Self ], Argument4 ) ) )
    return true
end
local RaycastParams4 = RaycastParams.new( )
RaycastParams4.FilterType = Enum.RaycastFilterType.Include
RaycastParams4.FilterDescendantsInstances = { Parent }
function ClientState.HoodCamHit( Argument1, Argument2, Argument3 )
    if Number2 <= 0 or typeof( Argument1 ) ~= "Vector3" or typeof( Argument2 ) ~= "Vector3" then
        return nil
    end

    local Raycast2
    local Raycast = workspace:Raycast( Argument1, Argument2.Unit * math.max( 0.1, Argument3 ), RaycastParams4 )
    Raycast2 = if Raycast then Table10[ Raycast.Instance ] else Raycast
    local Raycast3 = Raycast2 and Raycast2.npc and Raycast2.npc.state ~= "dead" and Raycast or nil
    return Raycast3
end
local RaycastParams5 = RaycastParams.new( )
RaycastParams5.FilterType = Enum.RaycastFilterType.Include
RaycastParams5.FilterDescendantsInstances = { Parent }
RaycastParams5.CollisionGroup = "Bullet"
function ClientState.HoodMelee( Argument1, Argument2, Argument3 )
    if Number2 <= 0 then
        return nil
    end

    local Spherecast2
    local Spherecast = workspace:Spherecast( Argument1, Argument3.HitRadius, Argument2 * ( Argument3.Reach + 0.8 ), RaycastParams5 )
    Spherecast2 = if Spherecast then Table10[ Spherecast.Instance ] else Spherecast
    local Spherecast3 = if Spherecast2 then Spherecast2.npc else Spherecast2

    if not Spherecast3 or Spherecast3.state == "dead" then
        return nil
    end
    local Instance = Spherecast.Instance
    local IsHead2 = IsHead( Instance, Spherecast2, Spherecast.Position )
    local Id = Spherecast3.id
    Remote:FireServer( "melee", Id, Spherecast.Position, IsHead2 )
    return Spherecast.Position
end

local function MyTarget()
    if LocalPlayer:GetAttribute( "InWardrobe" ) or LocalPlayer:GetAttribute( "Onboarding" ) then
        return nil
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local HumanoidRootPart

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart then
        return nil, HumanoidRootPart
    end
    if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "InSafeZone" ) then
        return nil, HumanoidRootPart
    end
    if Character:GetAttribute( "HoodSafe" ) then
        return nil, HumanoidRootPart
    end
    return HumanoidRootPart, HumanoidRootPart
end

local function Turn( Argument1, Argument2, Argument3 )
    return Argument1 + ( ( Argument2 - Argument1 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * math.min( 1, Argument3 )
end

local function LadderFree( Argument1, Amount, Argument3 )
    local Y2

    if Amount > 0 then
        local Y = Argument1.foot.Y

        if Y then
            Y2 = Y
        else
            Y2 = Argument1.top
        end
    else
        Y2 = Argument1.top
    end

    local Value1 = nil

    for Key, Value in Table11, nil, nil do
        if Value ~= Argument3 and Value.climb and Value.climb.lad == Argument1 and Value.state ~= "dead" then
            if Value.climb.dir == Amount then
                if not ( math.abs( Value.pos.Y - Y2 ) < 5 ) then
                    continue
                end
            end

            return false
        end
    end

    return true
end

local Table19 = { }

local function HatchOf( Name )
    local Entry = Table19[ Name ]

    if Entry ~= nil then
        return Entry or nil
    end

    local Buildings
    local Map = workspace:FindFirstChild( "Map" )

    if Map then
        Buildings = Map:FindFirstChild( "Buildings" )
    else
        Buildings = Map
    end

    local RemoteWarehouse

    if Buildings then
        RemoteWarehouse = Buildings:FindFirstChild( "RemoteWarehouse" )
    else
        RemoteWarehouse = Buildings
    end
    if RemoteWarehouse then
        RemoteWarehouse = RemoteWarehouse:FindFirstChild( "Doors" )
    end

    local FoundChild

    if RemoteWarehouse then
        FoundChild = RemoteWarehouse:FindFirstChild( Name )
    else
        FoundChild = RemoteWarehouse
    end

    local Porte_Charniere

    if FoundChild then
        Porte_Charniere = FoundChild:FindFirstChild( "Porte_Charniere", true )
    else
        Porte_Charniere = FoundChild
    end
    if not FoundChild or not Porte_Charniere or not Porte_Charniere:IsA( "Attachment" ) then
        Table19[ Name ] = false
        return nil
    end

    local Number
    local WorldPosition = Porte_Charniere.WorldPosition
    local LookVector = Porte_Charniere.WorldCFrame.LookVector
    local Position = FoundChild:GetBoundingBox( ).Position - WorldPosition
    local Y = ( CFrame.fromAxisAngle( LookVector, 0.5 ) * Position ).Y
    Number = not ( Position.Y < Y ) and -1 or 1
    local Table = {
        m = FoundChild,
        hinge = WorldPosition,
        axis = LookVector,
        closed = FoundChild:GetPivot( ),
        angle = 0,
        sign = Number,
        openUntil = 0
    }
    Table19[ Name ] = Table
    return Table
end

local function Callback5( Argument1, Amount )
    local HatchOf2 = HatchOf( Argument1.hatch )

    if HatchOf2 then
        HatchOf2.openUntil = Amount + 1.5
    end
end

local function HatchStep( Argument1, Amount )
    local Value1 = nil

    for Key, Value in Table19, nil, nil do
        if Value then
            local Number = not ( Argument1 < Value.openUntil ) and 0 or 1.8325957145940461

            if Value.angle ~= Number then
                local Angle
                local Result = Amount * 4.537856055185257

                if Value.angle < Number then
                    local Min = math.min( Number, Value.angle + Result )

                    if Min then
                        Angle = Min
                    else
                        Angle = math.max( Number, Value.angle - Result )
                    end
                else
                    Angle = math.max( Number, Value.angle - Result )
                end

                Value.angle = Angle
                local CFrame2 = CFrame.new( Value.hinge ) * CFrame.fromAxisAngle( Value.axis, Value.sign * Value.angle ) * CFrame.new( -Value.hinge )
                Value.m:PivotTo( CFrame2 * Value.closed )
            end
        end
    end
end

local Value6 = nil
task.spawn( function()
    Value6 = HoodNPC:WaitForChild( "Share", 30 )
end )
local Number4 = 0

local function ShareNpcs( Amount )
    if not Value6 or Amount < Number4 then
        return
    end

    local Value1
    Number4 = Amount + 0.2
    local Table = { }
    Value1 = nil

    for Key, Value in Table11, nil, nil do
        if Value.e and Value.e.tpl and #Table < 24 then
            table.insert( Table, Value )
        end
    end
    if #Table == 0 then
        return
    end

    local Value2
    local Create = buffer.create( #Table * 18 + 1 )
    buffer.writeu8( Create, 0, #Table )
    Value2 = nil

    for Key2, Value3 in Table, nil, nil do
        local Flag
        local Total = 1 + ( Key2 - 1 ) * 18
        Flag = Value3.state == "dead" and true or false
        local Number = not Value3.moving and 0 or 1
        local Number2 = not Value3.climb and 0 or 2
        local Number4Inner
        local Number3 = Number + Number2
        Number4Inner = not Flag and 0 or 4
        local Number6
        local Number5 = Number3 + Number4Inner
        Number6 = not Value3.swing and 0 or 8
        local Number8
        local Number7 = Number5 + Number6
        Number8 = ( not Value3.climb or not ( Value3.climb.dir < 0 ) ) and 0 or 16
        local Position2
        local Number9 = Number7 + Number8

        if Flag then
            local Position = Value3.e.root.Position - Vector3.new( 0, Value3.e.hip or 0, 0 )

            if Position then
                Position2 = Position
            else
                Position2 = Value3.pos
            end
        else
            Position2 = Value3.pos
        end

        buffer.writeu16( Create, Total, Value3.id % 65536 )
        local Total2 = Total + 2
        buffer.writeu8( Create, Total2, ( tonumber( Value3.e.tpl ) or 1 ) % 256 )
        local Total3 = Total + 3
        buffer.writef32( Create, Total3, Position2.X )
        local Total4 = Total + 7
        buffer.writef32( Create, Total4, Position2.Y )
        local Total5 = Total + 11
        buffer.writef32( Create, Total5, Position2.Z )
        local Total6 = Total + 15
        buffer.writeu8( Create, Total6, math.floor( Value3.yaw % 6.283185307179586 / 6.283185307179586 * 255 + 0.5 ) % 256 )
        buffer.writeu8( Create, Total + 16, Number9 )
        local Total7 = Total + 17
        buffer.writeu8( Create, Total7, Table13[ Value3.e.weaponKey or "Knife" ] or 0 )
    end

    Value6:FireServer( Create, workspace:GetServerTimeNow( ) )
end

local SetStance = Table14.setStance
local STANCE2 = Table14.STANCE
local ShotParams = Table14.shotParams

local function Gauss()
    return math.sqrt( math.log( ( math.max( math.random( ), 1e-06 ) ) ) * -2 ) * math.cos( 6.283185307179586 * math.random( ) )
end

local function BodyHit( WorldPosition, LookVector, Distance, Argument4 )
    local Clamp2
    local Total = Argument4 + Vector3.new( 0, 0.6000000238418579, 0 )
    local Total2 = WorldPosition - Total
    local Dot = LookVector:Dot( Vector3.new( 0, 4.800000190734863, 0 ) )
    local Dot2 = Vector3.new( 0, 4.800000190734863, 0 ):Dot( Vector3.new( 0, 4.800000190734863, 0 ) )
    local Dot3 = LookVector:Dot( Total2 )
    local Dot4 = Vector3.new( 0, 4.800000190734863, 0 ):Dot( Total2 )
    local Dot5 = Dot2 - Dot * Dot

    if Dot5 > 1e-06 then
        local Clamp = math.clamp( ( Dot4 - Dot * Dot3 ) / Dot5, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = math.clamp( Dot4 / Dot2, 0, 1 )
        end
    else
        Clamp2 = math.clamp( Dot4 / Dot2, 0, 1 )
    end

    local Clamp3 = math.clamp( Dot * Clamp2 - Dot3, 0, Distance )
    local Magnitude = ( WorldPosition + LookVector * Clamp3 - ( Total + Vector3.new( 0, 4.800000190734863, 0 ) * Clamp2 ) ).Magnitude

    if Magnitude > 1.1 then
        return nil
    end
    local Max = math.max( 0, Clamp3 - math.sqrt( 1.2100000000000002 - Magnitude * Magnitude ) )
    return Max, WorldPosition + LookVector * Max
end

local function GunFire( Attacker, Argument2, Argument3, Argument4 )
    local Muzzle
    local Tool = Argument2.tool
    local Handle = Tool:FindFirstChild( "Handle" )

    if Handle then
        Muzzle = Handle:FindFirstChild( "Muzzle" )
    else
        Muzzle = Handle
    end

    local WorldPosition
    local Pos = Attacker.pos + Vector3.new( 0, 5, 0 )
    WorldPosition = Muzzle and ( Muzzle.WorldPosition - Pos ).Magnitude < 6 and Muzzle.WorldPosition or Pos

    if ( Argument3 - WorldPosition ).Magnitude < 0.5 then
        return
    end

    local Number
    local Base = Argument2.base + math.min( Argument2.burst * 0.22, 4.5 )
    Number = Argument4 ~= true and 1.5 or 1
    local Pos2
    local Rad = math.rad( Base * Number )
    local Rad2 = math.rad( ( math.min( Argument2.burst * 0.12, 2.5 ) ) )
    local LookAt = CFrame.lookAt( WorldPosition, Argument3 )
    local Rad3 = Rad2 + math.sqrt( math.log( ( math.max( math.random( ), 1e-06 ) ) ) * -2 ) * math.cos( 6.283185307179586 * math.random( ) ) * Rad * 0.6
    local LookVector = ( LookAt * CFrame.Angles( Rad3, math.sqrt( math.log( ( math.max( math.random( ), 1e-06 ) ) ) * -2 ) * math.cos( 6.283185307179586 * math.random( ) ) * Rad, 0 ) ).LookVector
    local Range = Argument2.range
    local Raycast = workspace:Raycast( WorldPosition, LookVector * Range, ShotParams )
    local Character = LocalPlayer.Character
    Argument2.repShots = Argument2.repShots + 1

    if Argument4 == true then
        local HumanoidRootPart

        if Character then
            HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end

        local Character2 = if HumanoidRootPart then HumanoidRootPart.Position - Vector3.new( 0, 3, 0 ) else HumanoidRootPart
        Pos2 = Character2
    elseif Argument4 then
        Pos2 = Argument4.pos

        if Argument4.gun then
            local Gun = Argument4.gun
            local Gun2 = Argument4.gun
            local AttackedAt = os.clock( )
            Gun.attacker = Attacker
            Gun2.attackedAt = AttackedAt
        end
    else
        Pos2 = nil
    end

    local Value1, Value2

    if Pos2 then
        local Distance = Raycast and Raycast.Distance or Range
        Value1, Value2 = BodyHit( WorldPosition, LookVector, Distance, Pos2 )
    else
        Value1 = nil
        Value2 = nil
    end
    if Value1 then
        if Argument4 == true then
            Argument2.repHits = Argument2.repHits + 1
        else
            Argument2.repBotHits = Argument2.repBotHits + 1
        end
    end

    local Effects = Table14.Effects
    pcall( function()
        if Value1 then
            local Captured
            Effects.Shot( Tool, WorldPosition, Value2, nil, true, nil, nil, false )
            local Blood = Effects.Blood
            Captured = Argument4 == true and Character or Argument4.e.model
            Blood( Captured, Value2, LookVector )
            return
        end
        if Raycast then
            local Shot = Effects.Shot
            local Position = Raycast.Position
            local Normal = Raycast.Normal
            Shot( Tool, WorldPosition, Position, Normal, true, nil, Raycast.Instance, false )
            return
        end
        local Shot2 = Effects.Shot
        Shot2( Tool, WorldPosition, WorldPosition + LookVector * Range, nil, true, nil, nil, false )
        return
    end )
end

local function SendPitch( Argument1, Argument2, PitchSent )
    if math.abs( PitchSent - Argument2.pitchSent ) > 0.5 then
        Argument2.pitchSent = PitchSent
        local Model = Argument1.model
        Model:SetAttribute( "GunPitch", math.floor( PitchSent * 10 + 0.5 ) / 10 )
    end
end

local function FlushGun( Argument1, Argument2, Amount )
    if Argument2.repShots > 0 then
        local Id3
        local Id = Argument1.id
        local RepShots = Argument2.repShots
        local RepHits = Argument2.repHits
        local Pos = Argument1.pos

        if Argument2.repBot then
            local Id2 = Argument2.repBot.id

            if Id2 then
                Id3 = Id2
            else
                Id3 = nil
            end
        else
            Id3 = nil
        end

        Remote:FireServer( "gun", Id, RepShots, RepHits, Pos, Id3, Argument2.repBotHits )
    end

    Argument2.repShots = 0
    Argument2.repHits = 0
    Argument2.repBotHits = 0
    Argument2.repAt = Amount + 0.25
end

local function Step( p1, p2, p3, p4, p5, Dist )
    -- Could not structure function #92
end

local function PhysOn( Argument1 )
    local Hum2
    local E = Argument1.e
    local Parent = E.root
    local Hum = E.hum
    Hum2 = if Hum then Hum else E.model:FindFirstChildOfClass( "Humanoid" )
    E.hum = Hum2

    if not E.align then
        local Attachment0 = Instance.new( "Attachment" )
        Attachment0.Name = "GunAlign"
        Attachment0.Parent = Parent
        local Align = Instance.new( "AlignOrientation" )
        Align.Name = "GunAlign"
        Align.Mode = Enum.OrientationAlignmentMode.OneAttachment
        Align.Attachment0 = Attachment0
        Align.RigidityEnabled = true
        Align.Enabled = false
        Align.Parent = Parent
        E.align = Align
    end
    if E.rootGroup == nil then
        local RootGroup = Parent.CollisionGroup
        local RootCollide = Parent.CanCollide
        local EvalSM = E.hum.EvaluateStateMachine
        E.rootGroup = RootGroup
        E.rootCollide = RootCollide
        E.evalSM = EvalSM
    end

    local CollisionGroup
    E.model:PivotTo( CFrame.new( Argument1.pos + Vector3.new( 0, E.hip, 0 ) ) * CFrame.Angles( 0, Argument1.yaw, 0 ) )
    local Success, Result = pcall( PhysicsService.IsCollisionGroupRegistered, PhysicsService, "Ragdoll" )
    CollisionGroup = ( not Success or not Result ) and "Default" or "Ragdoll"
    Parent.CollisionGroup = CollisionGroup
    Parent.CanCollide = true
    local Align2 = E.align
    Align2.CFrame = CFrame.Angles( 0, Argument1.yaw, 0 )
    E.align.Enabled = true
    E.hum.AutoRotate = false
    E.hum.PlatformStand = false
    local Hum3 = E.hum
    Hum3.WalkSpeed = Table14.WALK
    E.hum.EvaluateStateMachine = true
    Parent.AssemblyLinearVelocity = Vector3.new( 0, 0, 0 )
    Parent.Anchored = false
    E.hum:ChangeState( Enum.HumanoidStateType.Running )
    E.phys = true
end

local function PhysOff( Argument1, Argument2 )
    if not Argument1.phys then
        return
    end
    if Argument1.align then
        Argument1.align.Enabled = false
    end
    if Argument1.tracks.Run and Argument1.tracks.Run.IsPlaying then
        Argument1.tracks.Run:Stop( 0.15 )
    end

    Argument1.hum:Move( Vector3.new( 0, 0, 0 ) )
    local Hum = Argument1.hum
    Hum.EvaluateStateMachine = Argument1.evalSM

    if Argument2 then
        return
    end
    Argument1.phys = nil
    Argument1.hum.PlatformStand = false
    Argument1.hum.AutoRotate = true
    local Root = Argument1.root
    Root.CanCollide = Argument1.rootCollide
    local Root2 = Argument1.root
    Root2.CollisionGroup = Argument1.rootGroup
    return
end

local Success, Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "Tutorial" ):WaitForChild( "Config" ) )
end )
Tuto = Success and type( Result ) == "table" and Result or nil
Table14.Tuto = Tuto

local function GunSpot( p1, p2, p3, p4 )
    -- Could not structure function #96
end

local function Fence( Argument1, WantMove )
    local Tuto2
    local Tuto = Table14.Tuto
    Tuto2 = if Tuto then Tuto.BotBox else Tuto

    if not Tuto2 then
        return WantMove
    end

    local Position
    local ShopExitPos = Tuto.ShopExitPos

    if ShopExitPos then
        local X = Argument1.pos.X - ShopExitPos.X
        local Vector32 = Vector3.new( X, 0, Argument1.pos.Z - ShopExitPos.Z )

        if not ( Vector32.Magnitude < 18 ) or not ( Vector32.Magnitude > 0.05 ) then
            Position = Vector3.new( 0, 0, 0 )
        else
            Position = Vector3.new( 0, 0, 0 ) + Vector32.Unit
        end
        if Tuto.BotMaxDist and Tuto.BotMaxDist + 8 < Vector32.Magnitude then
            Position = Position - Vector32.Unit
        end
    else
        Position = Vector3.new( 0, 0, 0 )
    end

    local Number
    local PointToObjectSpace = Tuto2.CFrame:PointToObjectSpace( Argument1.pos )
    local Size = Tuto2.Size / 2
    local X2 = PointToObjectSpace.X

    if Size.X + 6 < X2 then
        Number = -1
    elseif PointToObjectSpace.X < -Size.X - 6 then
        Number = 1
    else
        Number = 0
    end

    local Number2
    local Z = PointToObjectSpace.Z

    if Size.Z + 6 < Z then
        Number2 = -1
    elseif PointToObjectSpace.Z < -Size.Z - 6 then
        Number2 = 1
    else
        Number2 = 0
    end
    if Number ~= 0 or Number2 ~= 0 then
        Position = Position + Tuto2.CFrame:VectorToWorldSpace( ( Vector3.new( Number, 0, Number2 ) ) ).Unit
    end
    if Position.Magnitude < 0.05 then
        return WantMove
    end

    local Unit2
    local Unit = Position.Unit
    local Dot = WantMove:Dot( Unit )
    Unit2 = if Dot < 0 then WantMove - Unit * Dot else WantMove
    local Unit4
    local Unit3 = Unit2 + Unit * 0.6
    Unit4 = Unit3.Magnitude > 1 and Unit3.Unit or Unit3
    return Unit4
end

local function Move( Argument1, Argument2, Amount3, Argument4, Argument5, Argument6 )
    local E = Argument1.e
    local Hum = E.hum
    local Root = E.root
    Argument1.pos = Root.Position - Vector3.new( 0, E.hip, 0 )

    if Root.Position.Y < -300 then
        Remote:FireServer( "gone", Argument1.id )
        Callback3( Argument1 )
        return
    end
    if Argument6 then
        local X = Argument6.X - Argument1.pos.X
        local Dist = Vector3.new( X, 0, Argument6.Z - Argument1.pos.Z ).Magnitude

        if Config.DespawnDist < Dist then
            Remote:FireServer( "gone", Argument1.id )
            Callback3( Argument1 )
            return
        end

        local WantMove
        local Step2 = Step( Argument1, Argument2, Amount3, Argument4, Argument5, Dist )
        local WalkSpeed = Table14.WALK

        if Step2 then
            WantMove = Argument2.wantMove
            WalkSpeed = Argument2.aimWalk
            Argument1.stuckFrom = nil
            Argument1.stuckFor = 0
        elseif Argument5 then
            local GunSpot2 = GunSpot( Argument1, Argument2, Amount3, Argument6 )

            if ( Argument1.nextLos or 0 ) <= Amount3 then
                Argument1.nextLos = Amount3 + 0.3
                Argument1.losBlocked = not ClearLine( Argument1.pos, GunSpot2 )
            end
            if Argument1.losBlocked or Amount3 < ( Argument1.forcePath or 0 ) then
                if not Argument1.path or Argument1.pathUntil < Amount3 or ( GunSpot2 - Argument1.pathGoal ).Magnitude > 8 then
                    RequestPath( Argument1, GunSpot2, Amount3 )
                end
            else
                Argument1.path = nil
            end

            local Entry2

            if Argument1.path then
                local Entry = Argument1.path[ Argument1.wp ]

                while Entry do
                    local X2 = Entry.X - Argument1.pos.X

                    if not ( Vector3.new( X2, 0, Entry.Z - Argument1.pos.Z ).Magnitude < 2 ) then
                        break
                    end

                    Argument1.wp = Argument1.wp + 1
                    Entry = Argument1.path[ Argument1.wp ]
                end
                if Entry then
                    Entry2 = Entry
                else
                    Argument1.path = nil
                    Entry2 = GunSpot2
                end
            else
                Entry2 = GunSpot2
            end

            local Number
            local X3 = Entry2.X - Argument1.pos.X
            local Vector32 = Vector3.new( X3, 0, Entry2.Z - Argument1.pos.Z )
            local Magnitude = Vector32.Magnitude
            Number = not Argument1.path and 3 or 0.5

            if Number < Magnitude then
                WantMove = Vector32.Unit
            else
                WantMove = Vector3.new( 0, 0, 0 )
            end
            if WantMove.Magnitude > 0 and ( Argument1.stuckCheck or 0 ) <= Amount3 then
                if Argument1.stuckFrom then
                    local X4 = Argument1.pos.X - Argument1.stuckFrom.X

                    if Vector3.new( X4, 0, Argument1.pos.Z - Argument1.stuckFrom.Z ).Magnitude < 1.5 then
                        Argument1.stuckFor = ( Argument1.stuckFor or 0 ) + 1.5
                        Argument1.path = nil
                        Argument1.nextPathAt = 0

                        if not Table14.Tuto or not Table14.Tuto.BotBox then
                            Argument1.forcePath = Amount3 + 4
                            RequestPath( Argument1, GunSpot2, Amount3 )
                            Hum.Jump = true
                        else
                            Argument2.roam = nil
                        end
                    else
                        Argument1.stuckFor = 0
                    end
                else
                    Argument1.stuckFor = 0
                end

                local StuckFrom = Argument1.pos
                local StuckCheck = Amount3 + 1.5
                Argument1.stuckFrom = StuckFrom
                Argument1.stuckCheck = StuckCheck

                if Argument1.stuckFor >= 9 then
                    Remote:FireServer( "gone", Argument1.id )
                    Callback3( Argument1 )
                    return
                end
            end
        else
            WantMove = Vector3.new( 0, 0, 0 )
        end

        local Value3, Position
        Value3 = nil
        Position = Vector3.new( 0, 0, 0 )

        for Key, Value in Table11, nil, nil do
            if Value ~= Argument1 and Value.gun and Value.state ~= "dead" then
                local X6 = Argument1.pos.X - Value.pos.X
                local Vector33 = Vector3.new( X6, 0, Argument1.pos.Z - Value.pos.Z )
                local Magnitude3 = Vector33.Magnitude

                if Magnitude3 < 6 and Magnitude3 > 0.05 then
                    Position = Position + Vector33.Unit * ( 6 - Magnitude3 ) / 6
                end
            end
        end
        if Position.Magnitude > 0.05 then
            local WantMove2 = WantMove + Position * 1.5

            if WantMove2.Magnitude > 1 then
                WantMove = WantMove2.Unit
            else
                WantMove = WantMove2
            end
        end

        local Fence2 = Fence( Argument1, WantMove )

        if Hum.WalkSpeed ~= WalkSpeed then
            Hum.WalkSpeed = WalkSpeed
        end

        Hum:Move( Fence2, false )
        local AssemblyLinearVelocity = Root.AssemblyLinearVelocity
        local X5 = AssemblyLinearVelocity.X
        local Magnitude2 = Vector3.new( X5, 0, AssemblyLinearVelocity.Z ).Magnitude

        if not Step2 and Magnitude2 > 1 then
            local Yaw = Argument1.yaw
            local Amount2 = -AssemblyLinearVelocity.X
            local Atan2 = math.atan2( Amount2, -AssemblyLinearVelocity.Z )
            local TURN = Argument4 * Table14.TURN
            Argument1.yaw = Yaw + ( ( Atan2 - Yaw + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * math.min( 1, TURN )
        end

        local Moving
        local Align = E.align
        Align.CFrame = CFrame.Angles( 0, Argument1.yaw, 0 )

        if Magnitude2 > 0.75 then
            if Fence2.Magnitude > 0 then
                Moving = true
            else
                Moving = false
            end
        else
            Moving = false
        end

        local Walk = E.tracks.Walk
        local Run = E.tracks.Run

        if not Moving or not Walk then
            local Anim3 = if false or not Argument1.zombie then "Idle" else nil

            if Argument1.anim ~= Anim3 then
                local Tracks3 = Argument1.e.tracks

                if Argument1.anim then
                    Tracks3[ Argument1.anim ]:Stop( 0.15 )
                end

                Argument1.anim = Anim3

                if Anim3 then
                    Tracks3[ Anim3 ]:Play( 0.15 )
                end
            end
            if Run and Run.IsPlaying then
                Run:Stop( 0.15 )
            end
        else
            if Argument1.anim ~= "Walk" then
                local Anim2 = if true or not Argument1.zombie then "Walk" else nil

                if Argument1.anim ~= Anim2 then
                    local Tracks2 = Argument1.e.tracks

                    if Argument1.anim then
                        Tracks2[ Argument1.anim ]:Stop( 0.15 )
                    end

                    Argument1.anim = Anim2

                    if Anim2 then
                        Tracks2[ Anim2 ]:Play( 0.15 )
                    end
                end
            end

            local Clamp2

            if Run then
                local Clamp = math.clamp( ( Magnitude2 / 16 - 0.5 ) / 0.5, 0, 1 )

                if Clamp then
                    Clamp2 = Clamp
                else
                    Clamp2 = 0
                end
            else
                Clamp2 = 0
            end

            Walk:AdjustWeight( ( math.max( 1 - Clamp2, 0.001 ) ) )
            Walk:AdjustSpeed( 0.85 )

            if Run then
                if not Run.IsPlaying then
                    Run:Play( 0.15 )
                end

                Run:AdjustWeight( ( math.max( Clamp2, 0.001 ) ) )
                Run:AdjustSpeed( 0.85 )
            end
        end

        local HasTarget = Argument5 ~= nil and true or false
        Argument1.moving = Moving
        Argument1.moved = Moving
        Argument1.dist = Dist
        Argument1.hasTarget = HasTarget
        return
    end
    local Anim
    Hum:Move( Vector3.new( 0, 0, 0 ) )
    Anim = if false or not Argument1.zombie then "Idle" else nil

    if Argument1.anim ~= Anim then
        local Tracks = Argument1.e.tracks

        if Argument1.anim then
            Tracks[ Argument1.anim ]:Stop( 0.15 )
        end

        Argument1.anim = Anim

        if Anim then
            Tracks[ Anim ]:Play( 0.15 )
        end
    end

    Argument1.moving = false
    Argument1.dist = math.huge
    return
end

Table14.step = Step
Table14.move = Move
Table14.physOn = PhysOn
Table14.physOff = PhysOff
local Value7 = nil
local Value8 = nil
local Table20 = { }
local Table21 = { }
RunService.Heartbeat:Connect( function( p1 )
    -- Could not structure function #99
end )
Storage.Table22 = { }
local I3 = 1

for I3 = 1, 60 do
    Storage.SampleFastRun = RunGait.SampleFastRun
    Storage.Table22[ I3 ] = Storage.SampleFastRun( ( I3 - 1 ) / 60, true )
end

Storage.CurrentCamera = workspace.CurrentCamera
Storage.Number5 = 0
Storage.Table23 = { }
Storage.BindableEvent = Instance.new( "BindableEvent" )
Storage.BindableEvent.Name = "GhostFeed"
Storage.BindableEvent.Parent = Parent

Storage.GhostRelease = function( Argument1 )
    local Anim
    local E = Argument1.e
    E.npc = nil
    Callback2( E )
    Anim = if true or not Argument1.zombie then nil else nil

    if Argument1.anim ~= Anim then
        local Tracks = Argument1.e.tracks

        if Argument1.anim then
            Tracks[ Argument1.anim ]:Stop( 0.15 )
        end

        Argument1.anim = Anim

        if Anim then
            Tracks[ Anim ]:Play( 0.15 )
        end
    end

    local Value1
    local Cyc = E.cyc
    Value1 = nil

    for Key, Value in Cyc, nil, nil do
        Value.Transform = CFrame.identity
    end

    table.clear( E.wr )
    table.clear( E.anim )

    if E.grip and E.gripHold then
        local Grip = E.grip
        Grip.C0 = E.gripHold
    end
    if E.wgrip and E.gl then
        local Wgrip = E.wgrip
        Wgrip.C0 = E.gl
    end

    local Value2
    E.gripNow = nil
    local Parts = E.parts
    Value2 = nil

    for Key2, Value3 in Parts, nil, nil do
        Value3.CanQuery = true
    end

    local Entry2
    E.root.CFrame = CFrame2
    local Tpl = E.tpl
    local Entry = Table9[ E.tpl ]
    Entry2 = if Entry then Entry else { }
    Table9[ Tpl ] = Entry2
    table.insert( Table9[ E.tpl ], E )
end

Storage.BindableEvent.Event:Connect( function( Argument1, Argument2 )
    if Argument1 == nil then
        local Value1 = nil

        for Key, Value in Storage.Table23, nil, nil do
            Storage.GhostRelease( Value )
            Storage.Table23[ Key ] = nil
        end

        return
    end
    if typeof( Argument2 ) ~= "buffer" or buffer.len( Argument2 ) < 1 then
        return
    end

    local Readu8 = buffer.readu8( Argument2, 0 )

    if buffer.len( Argument2 ) < Readu8 * 18 + 1 then
        return
    end

    local Seen = os.clock( )
    local I = 1

    for I = 1, Readu8 do
        local Total = ( I - 1 ) * 18 + 1
        local Readu82 = buffer.readu8( Argument2, Total + 2 )
        local Readf32 = buffer.readf32( Argument2, Total + 3 )
        local Readf322 = buffer.readf32( Argument2, Total + 7 )
        local Tgt = Vector3.new( Readf32, Readf322, ( buffer.readf32( Argument2, Total + 11 ) ) )

        if Tgt == Tgt and Tgt.Magnitude < 100000 and Children[ Readu82 ] then
            local Entry3
            local Text = tostring( Argument1 )
            local Text2 = Text .. ":" .. buffer.readu16( Argument2, Total )
            local Entry = Storage.Table23[ Text2 ]

            if Entry then
                Entry3 = Entry
            else
                local Flag

                if ReplicatedStorage:GetAttribute( "HalloweenEvent" ) == true then
                    if typeof( Tgt ) == "Vector3" then
                        if FarmZone.Contains( Tgt ) == true then
                            Flag = true
                        else
                            Flag = false
                        end
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end

                local Remove2
                local TplFor2 = TplFor( Readu82, Flag )
                local Entry2 = Table9[ TplFor2 ]

                if Entry2 then
                    local Remove = table.remove( Entry2 )

                    if Remove then
                        Remove2 = Remove
                    else
                        Remove2 = Build( TplFor2 )
                    end
                else
                    Remove2 = Build( TplFor2 )
                end

                local Zombie
                EquipWeapon( Remove2, Table12[ buffer.readu8( Argument2, Total + 17 ) ] )
                local Table = {
                    ghost = true,
                    id = Text2,
                    e = Remove2,
                    pos = Tgt,
                    yaw = 0,
                    runW = 0,
                    phase = math.random( ),
                    aim = 0,
                    state = "chase",
                    hasTarget = true,
                    dist = 10
                }

                if ReplicatedStorage:GetAttribute( "HalloweenEvent" ) == true then
                    if typeof( Tgt ) == "Vector3" then
                        if FarmZone.Contains( Tgt ) == true then
                            Zombie = true
                        else
                            Zombie = false
                        end
                    else
                        Zombie = false
                    end
                else
                    Zombie = false
                end

                local Value3
                Table.zombie = Zombie
                local Parts = Remove2.parts
                Value3 = nil

                for Key2, Value4 in Parts, nil, nil do
                    Value4.CanQuery = false
                end

                Storage.Table23[ Text2 ] = Table
                Entry3 = Table
            end

            local Tyaw = buffer.readu8( Argument2, Total + 15 ) / 255 * 2 * 3.141592653589793
            local Flags = buffer.readu8( Argument2, Total + 16 )
            Entry3.tgt = Tgt
            Entry3.tyaw = Tyaw
            Entry3.flags = Flags
            Entry3.seen = Seen
        end
    end

    return
end )

Storage.GhostStep = function( Amount )
    if not next( Storage.Table23 ) then
        return
    end

    local Value1
    local Swing = os.clock( )
    local Table = { }
    local Table2 = { }
    Value1 = nil

    for Key, Value in Storage.Table23, nil, nil do
        local E = Value.e

        if Swing - Value.seen > 1.2 then
            Storage.GhostRelease( Value )
            Storage.Table23[ Key ] = nil
        elseif bit32.band( Value.flags, 4 ) == 0 then
            local Moving
            local Exp = 1 - math.exp( -14 * Amount )
            local Pos = Value.pos
            Value.pos = Pos:Lerp( Value.tgt, Exp )
            local Yaw = Value.yaw
            Value.yaw = Yaw + ( ( Value.tyaw - Yaw + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793 ) * math.min( 1, Exp )
            local Flags = Value.flags
            Moving = bit32.band( Flags, 1 ) ~= 0 and true or false
            Value.moving = Moving

            if bit32.band( Flags, 2 ) == 0 or not E.tracks.Climb then
                if Value.moving then
                    local Anim3 = if true or not Value.zombie then nil else nil

                    if Value.anim ~= Anim3 then
                        local Tracks3 = Value.e.tracks

                        if Value.anim then
                            Tracks3[ Value.anim ]:Stop( 0.15 )
                        end

                        Value.anim = Anim3

                        if Anim3 then
                            Tracks3[ Anim3 ]:Play( 0.15 )
                        end
                    end
                else
                    local Anim4 = if false or not Value.zombie then "Idle" else nil

                    if Value.anim ~= Anim4 then
                        local Tracks4 = Value.e.tracks

                        if Value.anim then
                            Tracks4[ Value.anim ]:Stop( 0.15 )
                        end

                        Value.anim = Anim4

                        if Anim4 then
                            Tracks4[ Anim4 ]:Play( 0.15 )
                        end
                    end
                end
            else
                if Value.anim ~= "Climb" then
                    local Anim2 = if true or not Value.zombie then "Climb" else nil

                    if Value.anim ~= Anim2 then
                        local Tracks2 = Value.e.tracks

                        if Value.anim then
                            Tracks2[ Value.anim ]:Stop( 0.15 )
                        end

                        Value.anim = Anim2

                        if Anim2 then
                            Tracks2[ Anim2 ]:Play( 0.15 )
                        end
                    end
                end

                local Number
                local Climb = E.tracks.Climb
                Number = bit32.band( Flags, 16 ) == 0 and 1 or -1
                Climb:AdjustSpeed( Number * 9 / 5 )
                Value.moving = false
            end

            local WasSwing = bit32.band( Flags, 8 ) ~= 0 and true or false

            if WasSwing and not Value.wasSwing then
                Value.swing = Swing
            end

            Value.wasSwing = WasSwing
            table.insert( Table, E.root )
            table.insert( Table2, CFrame.new( Value.pos + Vector3.new( 0, E.hip, 0 ) ) * CFrame.Angles( 0, Value.yaw, 0 ) )
        elseif Value.state == "dead" then
            if Value.rag == 1 then
                Value.rag = 2
                RagdollGo( Value )
            elseif Value.rag == 2 then
                if Value.track then
                    local Step = AntiTunnel.Step
                    pcall( Step, Value.track, Amount, true )
                end

                local Flag
                local Clock = Swing - Value.deadAt

                if Clock > 12 then
                    Flag = true
                elseif Clock > 4 then
                    if E.torso.AssemblyLinearVelocity.Magnitude < 2 then
                        Flag = true
                    else
                        Flag = false
                    end
                else
                    Flag = false
                end
                if Flag then
                    local Value4
                    local Parts2 = E.parts
                    Value4 = nil

                    for Key3, Value5 in Parts2, nil, nil do
                        Value5.Anchored = true
                        Value5.CanCollide = false
                    end

                    E.root.Anchored = true
                    Value.rag = 3
                    Value.track = nil
                end
            end
        else
            local Anim
            Value.state = "dead"
            Value.deadAt = Swing
            Value.swing = nil
            Anim = if true or not Value.zombie then nil else nil

            if Value.anim ~= Anim then
                local Tracks = Value.e.tracks

                if Value.anim then
                    Tracks[ Value.anim ]:Stop( 0.15 )
                end

                Value.anim = Anim

                if Anim then
                    Tracks[ Anim ]:Play( 0.15 )
                end
            end

            local Value2
            Value.pos = Value.tgt
            local Root = E.root
            Root.CFrame = CFrame.new( Value.pos + Vector3.new( 0, E.hip, 0 ) ) * CFrame.Angles( 0, Value.yaw, 0 )
            local Parts = E.parts
            Value2 = nil

            for Key2, Value3 in Parts, nil, nil do
                Value3.Massless = false
            end

            Value.rag = 1
            E.root.Anchored = false
        end
    end
    if #Table > 0 then
        workspace:BulkMoveTo( Table, Table2, Enum.BulkMoveMode.FireCFrameChanged )
    end
end

RunService.Heartbeat:Connect( Storage.GhostStep )
Storage.Table24 = { }

Storage.PoseList = function()
    if not next( Storage.Table23 ) then
        return Table11
    end

    local Value1
    table.clear( Storage.Table24 )
    Value1 = nil

    for Key, Value in Table11, nil, nil do
        table.insert( Storage.Table24, Value )
    end

    local Value2 = nil

    for Key2, Value3 in Storage.Table23, nil, nil do
        table.insert( Storage.Table24, Value3 )
    end

    return Storage.Table24
end

function ClientState.HoodBodies( List )
    local Value1 = nil

    for Key, Value in Table11, nil, nil do
        if Value.state ~= "dead" and not Value.climb then
            table.insert( List, { id = Value.e.model, pos = Value.e.root.Position } )
        end
    end

    local Value2 = nil

    for Key2, Value3 in Storage.Table23, nil, nil do
        if Value3.state ~= "dead" then
            table.insert( List, { id = Value3.e.model, pos = Value3.e.root.Position } )
        end
    end
end
RunService.PreSimulation:Connect( function( Amount )
    if not next( Table11 ) and not next( Storage.Table23 ) then
        return
    end

    Storage.Number5 = Storage.Number5 + 1
    local Clock = os.clock( )
    Storage.CurrentCamera = workspace.CurrentCamera
    local ViewportSize = Storage.CurrentCamera.ViewportSize
    local Clamp = math.clamp( Amount * 8, 0, 1 )
    local Clamp2 = math.clamp( Amount * 12, 0, 1 )

    for Key, Value in Storage.PoseList( ) do
        if Value.state ~= "dead" and not Value.gun then
            local E = Value.e

            if Value.zombie and ZombieSounds2 then
                if Value.growlAt then
                    if Value.growlAt <= Clock then
                        Value.growlAt = Clock + 5 + math.random( ) * 7
                        ZombieGrowl( Value )
                    end
                else
                    Value.growlAt = Clock + math.random( ) * 12
                end
            end

            local Kind2
            local Kind = E.kind
            Kind2 = if Kind then Kind else Table2.Knife
            local Number
            local RunW = Value.runW
            Number = not Value.moving and 0 or 1
            Value.runW = RunW + ( Number - Value.runW ) * ( 1 - math.exp( -10 * Amount ) )

            if Value.moving then
                local Number2
                local Phase = Value.phase
                local Speed = Config.Speed
                Number2 = if Value.zombie then 10.5 else CycleLength
                Value.phase = ( Phase + Speed / Number2 * Amount ) % 1
            end

            local Flag4

            if Value.zombie == true then
                local Climb2
                local Climb = Value.climb

                if Climb then
                    Climb2 = Climb
                elseif Value.anim == "Climb" then
                    Climb2 = true
                else
                    Climb2 = false
                end

                Flag4 = not Climb2
            else
                Flag4 = false
            end

            local Swing2
            local Swing = Value.swing
            Swing2 = if Swing then Clock - Value.swing else Swing
            local Flag

            if Swing2 == nil then
                Flag = false
            elseif Swing2 < Kind2.cut + Kind2.swingOut then
                Flag = true
            else
                Flag = false
            end

            local Fist2

            if Kind2.fists then
                local Fist = Value.fist

                if Fist then
                    Fist2 = Fist
                else
                    local RigState = FistAnim.RigState( )

                    if RigState then
                        Fist2 = RigState
                    else
                        Fist2 = nil
                    end
                end
            else
                Fist2 = nil
            end
            if Fist2 then
                Value.fist = Fist2

                if Value.swing and Value.swing ~= Value.fistAt then
                    local FistSide
                    Value.fistAt = Value.swing
                    FistSide = Value.fistSide ~= "Right" and "Right" or "Left"
                    Value.fistSide = FistSide
                    local RigPunch = FistAnim.RigPunch
                    RigPunch( Fist2, Value.fistSide, Value.swing )
                end
            end
            if not Flag then
                Value.swing = nil
            end

            local Flag2

            if Kind2.hold == nil then
                Flag2 = false
            else
                local Climb4
                local Climb3 = Value.climb

                if Climb3 then
                    Climb4 = Climb3
                elseif Value.anim == "Climb" then
                    Climb4 = true
                else
                    Climb4 = false
                end

                Flag2 = not Climb4
            end

            local HoldW2
            local HoldW = Value.holdW

            if HoldW then
                HoldW2 = HoldW
            elseif Flag2 then
                HoldW2 = 1
            else
                HoldW2 = 0
            end

            local Number3
            Value.holdW = HoldW2
            local HoldW3 = Value.holdW
            Number3 = not Flag2 and 0 or 1
            local Flag3
            Value.holdW = HoldW3 + ( Number3 - Value.holdW ) * Clamp

            if Flag then
                if Kind2.aimT == nil then
                    Flag3 = false
                else
                    local NotFreeHold = not Kind2.freeHold

                    if NotFreeHold then
                        if Swing2 < Kind2.cut then
                            Flag3 = true
                        else
                            Flag3 = false
                        end
                    else
                        Flag3 = NotFreeHold
                    end
                end
            else
                Flag3 = Flag
            end

            local Number4
            local Aim = Value.aim or 0
            Number4 = not Flag3 and 0 or 1
            local Flag5
            Value.aim = Aim + ( Number4 - ( Value.aim or 0 ) ) * Clamp2

            if Fist2 == nil then
                Flag5 = false
            else
                local Guard = Value.guard

                if Guard then
                    Flag5 = Guard
                elseif Fist2.w > 0.001 then
                    Flag5 = true
                elseif Clock - Fist2.lastPunch < 0.6 then
                    Flag5 = true
                else
                    Flag5 = false
                end
            end
            if Flag4 or not ( Value.runW < 0.001 ) or Flag or not ( Value.holdW < 0.001 ) or not ( Value.aim < 0.001 ) or Flag5 then
                local WorldToViewportPoint = Storage.CurrentCamera:WorldToViewportPoint( E.root.Position )

                if not ( WorldToViewportPoint.Z < -4 ) and not ( WorldToViewportPoint.X < -ViewportSize.X * 0.25 ) and not ( ViewportSize.X * 1.25 < WorldToViewportPoint.X ) and not ( WorldToViewportPoint.Y < -ViewportSize.Y * 0.25 ) and not ( ViewportSize.Y * 1.25 < WorldToViewportPoint.Y ) then
                    local Flag7
                    local Wr = E.wr
                    local Anim = E.anim
                    local Base = E.base
                    Flag7 = Value.runW >= 0.999 and true or false
                    local Entry3

                    if Value.runW > 0.001 then
                        local Entry2

                        if Flag4 then
                            local Entry = Table3[ math.floor( Value.phase * 60 ) % 60 + 1 ]

                            if Entry then
                                Entry2 = Entry
                            else
                                Entry2 = Storage.Table22[ math.floor( Value.phase * 60 ) % 60 + 1 ]
                            end
                        else
                            Entry2 = Storage.Table22[ math.floor( Value.phase * 60 ) % 60 + 1 ]
                        end

                        Entry3 = Entry2
                    else
                        Entry3 = nil
                    end

                    local Cyc3

                    if Entry3 or Flag4 then
                        local Cyc = E.cyc

                        if Cyc then
                            Cyc3 = Cyc
                        else
                            Cyc3 = E.upper
                        end
                    else
                        Cyc3 = E.upper
                    end
                    if not Entry3 and not Flag4 and next( Wr ) then
                        local Value2
                        local Cyc2 = E.cyc
                        Value2 = nil

                        for Value3 in Cyc2, nil, nil do
                            if not E.upper[ Value3 ] then
                                Wr[ Value3 ] = nil
                            end
                        end
                    end

                    local Entry19

                    if Flag4 then
                        local ZOff2
                        local ZOff = Value.zOff
                        ZOff2 = if ZOff then ZOff else math.random( ) * 100
                        Value.zOff = ZOff2
                        Entry19 = Table4[ math.floor( ( Clock + Value.zOff ) * 30 ) % Max + 1 ]
                    else
                        Entry19 = nil
                    end

                    local Value4 = nil

                    for Key2, Value5 in Cyc3, nil, nil do
                        if Entry19 then
                            local Entry14
                            local Entry13 = Entry19[ Key2 ]

                            if Entry13 then
                                Entry14 = Entry13
                            else
                                Entry14 = CFrame.identity
                            end
                            if Entry3 and Entry3[ Key2 ] then
                                local Lerp2

                                if not Flag7 or not Entry3[ Key2 ] then
                                    Lerp2 = Entry14:Lerp( Entry3[ Key2 ], Value.runW )
                                else
                                    Lerp2 = Entry3[ Key2 ]
                                end

                                Entry14 = Lerp2
                            end

                            Base[ Key2 ] = Entry14
                        else
                            local Entry15

                            if not Flag7 or not Entry3[ Key2 ] then
                                local Transform2 = Value5.Transform
                                local Entry16 = Wr[ Key2 ]

                                if not Entry16 or Transform2 ~= Entry16 then
                                    Anim[ Key2 ] = Transform2
                                    Entry15 = Transform2
                                else
                                    local Entry18
                                    local Entry17 = Anim[ Key2 ]
                                    Entry18 = if Entry17 then Entry17 else CFrame.identity
                                    Entry15 = Entry18
                                end
                                if Entry3 and Entry3[ Key2 ] then
                                    Entry15 = Entry15:Lerp( Entry3[ Key2 ], Value.runW )
                                end
                            else
                                Entry15 = Entry3[ Key2 ]
                            end

                            Base[ Key2 ] = Entry15
                        end
                    end

                    local Entry8, Number5, Number6

                    if not Flag or not Kind2.swingT then
                        Entry8 = nil
                        Number5 = 0
                        Number6 = 0
                    else
                        local Entry5
                        local Floor = math.floor( math.min( Swing2, Kind2.cut ) * 120 )
                        local Entry4 = Kind2.swingT[ Floor ]
                        Entry5 = if Entry4 then Entry4 else Kind2.swingT[ 0 ]
                        local Clamp3 = math.clamp( Swing2 / Kind2.swingIn, 0, 1 )

                        if Kind2.cut < Swing2 then
                            Entry8 = Entry5
                            Number5 = Clamp3 * ( 1 - math.clamp( ( Swing2 - Kind2.cut ) / Kind2.swingOut, 0, 1 ) )
                            Number6 = Floor
                        else
                            Entry8 = Entry5
                            Number5 = Clamp3
                            Number6 = Floor
                        end
                    end

                    local Entry7

                    if not ( Value.aim > 0.001 ) or not Kind2.aimT then
                        Entry7 = nil
                    else
                        local Floor3
                        local AimT = Kind2.aimT

                        if Kind2.aimN > 0 then
                            local Floor2 = math.floor( Clock * 30 ) % Kind2.aimN

                            if Floor2 then
                                Floor3 = Floor2
                            else
                                Floor3 = 0
                            end
                        else
                            Floor3 = 0
                        end

                        local Entry6 = AimT[ Floor3 ]

                        if Entry6 then
                            Entry7 = Entry6
                        else
                            Entry7 = nil
                        end
                    end

                    local Hold = Value.holdW > 0.001 and Kind2.hold or nil

                    if Hold or Entry7 or Entry8 then
                        local Value6 = nil

                        for Key3, Value7 in Table, nil, nil do
                            local Entry10 = Base[ Value7 ]

                            if Entry10 then
                                if not Kind2.parts or Kind2.parts[ Key3 ] then
                                    local Hold2 = if Hold then Hold[ Key3 ] else Hold
                                    local Lerp

                                    if Hold2 then
                                        Lerp = Entry10:Lerp( Hold2, Value.holdW )
                                    else
                                        Lerp = Entry10
                                    end

                                    local Entry11 = if Entry7 then Entry7[ Key3 ] else Entry7

                                    if Entry11 then
                                        Lerp = Lerp:Lerp( Entry11, Value.aim )
                                    end

                                    local Entry12 = if Entry8 then Entry8[ Key3 ] else Entry8

                                    if Entry12 then
                                        Lerp = Lerp:Lerp( Entry12, Number5 )
                                    end

                                    Base[ Value7 ] = Lerp
                                end
                            end
                        end
                    end

                    local Value8 = nil

                    for Key4, Value9 in Cyc3, nil, nil do
                        local Transform = Base[ Key4 ]
                        Value9.Transform = Transform
                        Wr[ Key4 ] = Transform
                    end
                    if Fist2 then
                        local Flag6
                        local PoseRig = FistAnim.PoseRig
                        local Model = E.model
                        Flag6 = Value.guard == true and true or false

                        if PoseRig( Model, Fist2, Flag6, not Value.moving, Clock, Amount ) then
                            local Value10 = nil

                            for Key5, Value11 in Cyc3, nil, nil do
                                Wr[ Key5 ] = Value11.Transform
                            end
                        end
                    end
                    if E.wgrip and E.gl then
                        local C0
                        local Gl = E.gl

                        if not E.ga or not ( Value.aim > 0.001 ) then
                            C0 = Gl
                        else
                            C0 = Gl:Lerp( E.ga, Value.aim )
                        end
                        if Number5 > 0 then
                            local Gs2
                            local Gs = E.gs

                            if Gs then
                                Gs2 = Gs
                            else
                                local Entry9 = Kind2.gripT[ Number6 ]

                                if Entry9 then
                                    Gs2 = Entry9
                                else
                                    Gs2 = Kind2.gripT[ 0 ]
                                end
                            end
                            if Gs2 then
                                C0 = C0:Lerp( Gs2, Number5 )
                            end
                        end
                        if C0 ~= E.gripNow then
                            E.wgrip.C0 = C0
                            E.gripNow = C0
                        end
                    end
                end
            else
                if next( E.wr ) then
                    table.clear( E.wr )
                end
                if E.wgrip and E.gl and E.gripNow ~= E.gl then
                    local Wgrip = E.wgrip
                    Wgrip.C0 = E.gl
                    E.gripNow = E.gl
                end
            end
        end
    end
end )

Storage.WatchPlayer = function( Argument1 )
    Argument1.CharacterAdded:Connect( function()
        Number3 = 0
    end )
end

Players.PlayerAdded:Connect( Storage.WatchPlayer )

for Key4, Value9 in Players:GetPlayers( ) do
    Storage.WatchPlayer( Value9 )
end

task.spawn( function()
    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait( )
    end

    local Captured
    local PoolSize = Config.PoolSize or 12
    local Table = { }

    if ReplicatedStorage:GetAttribute( "HalloweenEvent" ) ~= true or not ( #Table6 > 0 ) then
        local I = 1
        Captured = Table

        for I = 1, Count do
            Table[ I ] = I
            Captured = Table
        end
    else
        Captured = Table6
    end

    local I2 = 1

    for I2 = 1, PoolSize do
        local Entry3
        task.wait( 0.4 )
        local Entry = Captured[ ( I2 - 1 ) % #Captured + 1 ]
        local Entry2 = Table9[ Entry ]
        Entry3 = if Entry2 then Entry2 else { }
        local Value1, Number
        Table9[ Entry ] = Entry3
        Value1 = nil
        Number = 0

        for Key, Value in Table11, nil, nil do
            if Value.e.tpl == Entry then
                Number = Number + 1
            end
        end
        if #Table9[ Entry ] + Number < math.ceil( PoolSize / #Captured ) then
            local Entry4 = Table9[ Entry ]
            table.insert( Entry4, ( Build( Entry ) ) )
        end
    end
end )
