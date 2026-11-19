-- Players.perkbrokeyou.PlayerScripts.ReaperFXClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local CostumeFX = ReplicatedStorage:WaitForChild( "CostumeFX" )
local LocalPlayer = Players.LocalPlayer
local Table = { }

local function FindAnchor( Model, Text )
    local FoundChild = Model

    for Value in string.gmatch( Text, "[^%.]+" ) do
        local FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Value ) else FoundChild
        FoundChild = FoundChild2
    end
    if FoundChild and FoundChild:IsA( "Model" ) then
        FoundChild = FoundChild.PrimaryPart
    end

    return FoundChild
end

local Table2 = {
    "Head",
    "UpperTorso",
    "LowerTorso",
    "LeftUpperArm",
    "LeftLowerArm",
    "LeftHand",
    "RightUpperArm",
    "RightLowerArm",
    "RightHand",
    "LeftUpperLeg",
    "LeftLowerLeg",
    "LeftFoot",
    "RightUpperLeg",
    "RightLowerLeg",
    "RightFoot"
}

local function Area( Argument1 )
    return Argument1.X * Argument1.Y + Argument1.Y * Argument1.Z + Argument1.X * Argument1.Z
end

local function BuildPerPart( Self, Name, FoundChild, Parent )
    local Value1
    local Parent2 = Instance.new( "Folder" )
    Parent2.Name = "CostumeFX_" .. Name
    local Table = { }
    local Table2Inner = { }
    local Size = FoundChild.Size
    local Max = math.max( Size.X * Size.Y + Size.Y * Size.Z + Size.X * Size.Z, 0.001 )
    local Number = tonumber( FoundChild:GetAttribute( "PartScale" ) ) or 1.1
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Part0 = Self:FindFirstChild( Value )

        if Part0 and Part0:IsA( "BasePart" ) then
            local Part1 = FoundChild:Clone( )
            Part1.Name = Value

            for Value2 in Part1:GetAttributes( ) do
                Part1:SetAttribute( Value2, nil )
            end

            Part1.Size = Part0.Size * Number
            Part1.Anchored = false
            Part1.CanCollide = false
            Part1.CanQuery = false
            Part1.CanTouch = false
            Part1.Massless = true
            Part1.CastShadow = false
            Part1.Transparency = 1
            Part1.CFrame = Part0.CFrame
            local Weld = Instance.new( "Weld" )
            Weld.Part0 = Part0
            Weld.Part1 = Part1
            Weld.Parent = Part1
            local Size2 = Part1.Size
            local X = ( Size2.X * Size2.Y + Size2.Y * Size2.Z + Size2.X * Size2.Z ) / Max

            for Key2, Value3 in Part1:GetDescendants( ) do
                if Value3:IsA( "ParticleEmitter" ) then
                    local BaseRate2
                    local Table3 = { }
                    local BaseRate = Value3:GetAttribute( "BaseRate" )
                    BaseRate2 = if BaseRate then BaseRate else Value3.Rate
                    Table3[ 1 ] = Value3
                    Table3[ 2 ] = BaseRate2 * X
                    table.insert( Table, Table3 )
                end
            end

            Part1.Parent = Parent2
            table.insert( Table2Inner, Part0 )
        end
    end
    if #Table2Inner == 0 then
        Parent2:Destroy( )
        return nil
    end
    Parent2.Parent = Parent
    return {
        obj = Parent2,
        head = Self:FindFirstChild( "HumanoidRootPart" ),
        anchorName = "HumanoidRootPart",
        kind = Name,
        emitters = Table,
        watch = Table2Inner,
        k = -1
    }
end

local function Build( Self, Name, Parent )
    local FoundChild = CostumeFX:FindFirstChild( Name )

    if FoundChild and FoundChild:IsA( "BasePart" ) and FoundChild:GetAttribute( "PerPart" ) == true then
        local FX

        if Parent then
            FX = Parent
        else
            FX = workspace:FindFirstChild( "FX" )
        end

        local Value2

        if FX then
            local PerPart = BuildPerPart( Self, Name, FoundChild, FX )

            if PerPart then
                Value2 = PerPart
            else
                Value2 = nil
            end
        else
            Value2 = nil
        end

        return Value2
    end
    if not FoundChild or not FoundChild:IsA( "BasePart" ) then
        local Parent3 = Self:FindFirstChild( "Head" )

        if not Parent3 or not FoundChild then
            return nil
        end

        local Clone = FoundChild:Clone( )
        Clone.Name = "CostumeFX"
        local Table3 = { }

        for Key3, Value5 in Clone:GetDescendants( ) do
            if Value5:IsA( "ParticleEmitter" ) then
                local BaseRate4
                local Table4 = { }
                local BaseRate3 = Value5:GetAttribute( "BaseRate" )
                BaseRate4 = if BaseRate3 then BaseRate3 else Value5.Rate
                Table4[ 1 ] = Value5
                Table4[ 2 ] = BaseRate4
                table.insert( Table3, Table4 )
            end
        end

        Clone.Parent = Parent3
        return {
            obj = Clone,
            head = Parent3,
            anchorName = "Head",
            kind = Name,
            emitters = Table3,
            k = -1
        }
    end
    local Parent2
    local Anchor = FoundChild:GetAttribute( "Anchor" ) or "HumanoidRootPart"
    local Part0 = FindAnchor( Self, Anchor )

    if Parent then
        Parent2 = Parent
    else
        Parent2 = workspace:FindFirstChild( "FX" )
    end
    if not Part0 or not Part0:IsA( "BasePart" ) or not Parent2 then
        return nil
    end

    local Size2
    local RefSize = FoundChild:GetAttribute( "RefSize" )

    if typeof( RefSize ) == "Vector3" then
        local Size = Part0.Size / RefSize

        if Size then
            Size2 = Size
        else
            Size2 = Vector3.new( 1, 1, 1 )
        end
    else
        Size2 = Vector3.new( 1, 1, 1 )
    end

    local Offset2
    local Offset = FoundChild:GetAttribute( "Offset" )
    Offset2 = typeof( Offset ) == "CFrame" and Offset or CFrame.identity
    local C0 = Offset2.Rotation + Offset2.Position * Size2
    local Part1 = FoundChild:Clone( )
    Part1.Name = "CostumeFX_" .. Name

    for Value in Part1:GetAttributes( ) do
        Part1:SetAttribute( Value, nil )
    end

    Part1.Size = FoundChild.Size * Size2

    if Size2 ~= Vector3.new( 1, 1, 1 ) then
        for Key, Value3 in Part1:GetChildren( ) do
            if Value3:IsA( "Attachment" ) then
                Value3.Position = C0:PointToObjectSpace( Offset2:PointToWorldSpace( Value3.Position ) * Size2 )
            end
        end
    end

    Part1.Anchored = false
    Part1.CanCollide = false
    Part1.CanQuery = false
    Part1.CanTouch = false
    Part1.Massless = true
    Part1.CastShadow = false
    Part1.Transparency = 1
    Part1.CFrame = Part0.CFrame * C0
    local Weld = Instance.new( "Weld" )
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.C0 = C0
    Weld.Parent = Part1
    local Table = { }

    for Key2, Value4 in Part1:GetDescendants( ) do
        if Value4:IsA( "ParticleEmitter" ) then
            local BaseRate2
            local Table2 = { }
            local BaseRate = Value4:GetAttribute( "BaseRate" )
            BaseRate2 = if BaseRate then BaseRate else Value4.Rate
            Table2[ 1 ] = Value4
            Table2[ 2 ] = BaseRate2
            table.insert( Table, Table2 )
        end
    end

    Part1.Parent = Parent2
    return {
        obj = Part1,
        head = Part0,
        anchorName = Anchor,
        kind = Name,
        emitters = Table,
        k = -1
    }
end

local function Destroy( Key )
    local Entry = Table[ Key ]

    if Entry then
        Entry.obj:Destroy( )
        Table[ Key ] = nil
    end
end

local Number = 0
local Table3 = { }
RunService.Heartbeat:Connect( function( Argument1 )
    Number = Number + Argument1

    if Number < 0.06666666666666667 then
        return
    end

    local K2
    Number = 0
    local Position = workspace.CurrentCamera.CFrame.Position
    local Value = UserGameSettings.SavedQualityLevel.Value

    if Value == 0 or Value >= 6 then
        K2 = 1
    elseif Value >= 3 then
        K2 = 0.6
    else
        K2 = 0.35
    end

    local Flag
    table.clear( Table3 )

    if ClientState.FixedCamera == nil then
        if ClientState.RobloxCamera == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    local Flag2

    if ClientState.WardrobeOpen == true then
        Flag2 = true
    elseif LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        Flag2 = true
    elseif LocalPlayer:GetAttribute( "Onboarding" ) == true then
        Flag2 = true
    else
        Flag2 = false
    end

    local Flag4 = if Flag then not Flag2 else Flag
    local Flag5 = if Flag or Flag2 then not ClientState.Spectating else Flag2

    for Key, Value2 in Players:GetPlayers( ) do
        local CostumeFX2
        local Character = Value2.Character

        if Character then
            CostumeFX2 = Character:GetAttribute( "CostumeFX" )
        else
            CostumeFX2 = Character
        end
        if CostumeFX2 then
            local Head = Character:FindFirstChild( "Head" )
            local Humanoid = Character:FindFirstChildOfClass( "Humanoid" )

            if Head and Humanoid and Humanoid.Health > 0 then
                local Magnitude = ( Head.Position - Position ).Magnitude

                if Magnitude < 280 then
                    local Entry7
                    Table3[ Character ] = true
                    local Entry5 = Table[ Character ]

                    if Entry5 then
                        if Entry5.kind ~= CostumeFX2 or Entry5.head ~= FindAnchor( Character, Entry5.anchorName ) or not Entry5.obj.Parent then
                            local Entry6 = Table[ Character ]

                            if Entry6 then
                                Entry6.obj:Destroy( )
                                Table[ Character ] = nil
                            end

                            Entry7 = nil
                        else
                            Entry7 = Entry5
                        end
                    else
                        Entry7 = Entry5
                    end
                    if Entry7 and Entry7.watch then
                        local Value8
                        local Watch = Entry7.watch
                        Value8 = nil

                        for Key4, Value9 in Watch, nil, nil do
                            if Value9.Parent ~= Character then
                                local Entry8 = Table[ Character ]

                                if Entry8 then
                                    Entry8.obj:Destroy( )
                                    Table[ Character ] = nil
                                end

                                Entry7 = nil
                                break
                            end
                        end
                    end
                    if not Entry7 then
                        local Build3 = Build( Character, CostumeFX2 )
                        Table[ Character ] = Build3
                        Entry7 = Build3
                    end
                    if Entry7 then
                        local NumberInner = K2 * math.clamp( 1.15 - Magnitude / 140, 0.25, 1 )

                        if Magnitude >= 140 then
                            NumberInner = 0
                        end
                        if Value2 == LocalPlayer then
                            if ClientState.Aiming or ClientState.Scoped then
                                NumberInner = 0
                            end
                        end

                        local Flag3

                        if Value2 ~= LocalPlayer or not Flag4 then
                            if Value2 == LocalPlayer then
                                Flag3 = false
                            else
                                Flag3 = Flag5
                            end
                        else
                            Flag3 = Flag4
                        end
                        if Flag3 then
                            NumberInner = 0
                        end
                        if not Flag3 or Entry7.cleared then
                            if not Flag3 then
                                Entry7.cleared = nil
                            end
                        else
                            local Value11
                            Entry7.cleared = true
                            local Emitters2 = Entry7.emitters
                            Value11 = nil

                            for Key5, Value12 in Emitters2, nil, nil do
                                if Value12[ 1 ]:IsA( "ParticleEmitter" ) then
                                    Value12[ 1 ]:Clear( )
                                end
                            end
                        end

                        local K = math.round( NumberInner * 20 ) / 20

                        if K ~= Entry7.k then
                            local Value13
                            Entry7.k = K
                            local Emitters3 = Entry7.emitters
                            Value13 = nil

                            for Key6, Value14 in Emitters3, nil, nil do
                                local Item2 = Value14[ 1 ]
                                Item2.Rate = Value14[ 2 ] * K
                            end
                        end
                    end
                end
            end
        end
    end
    for Key2, Value3 in CollectionService:GetTagged( "SceneCostume" ) do
        local CostumeFX
        local IsDescendantOf = Value3:IsDescendantOf( workspace )

        if IsDescendantOf then
            CostumeFX = Value3:GetAttribute( "CostumeFX" )
        else
            CostumeFX = IsDescendantOf
        end
        if CostumeFX then
            local Entry4
            Table3[ Value3 ] = true
            local Entry2 = Table[ Value3 ]

            if Entry2 then
                if Entry2.kind ~= CostumeFX or not Entry2.obj.Parent then
                    local Entry3 = Table[ Value3 ]

                    if Entry3 then
                        Entry3.obj:Destroy( )
                        Table[ Value3 ] = nil
                    end

                    Entry4 = nil
                else
                    Entry4 = Entry2
                end
            else
                Entry4 = Entry2
            end
            if not Entry4 then
                local Build2 = Build( Value3, CostumeFX, Value3 )
                Table[ Value3 ] = Build2
                Entry4 = Build2
            end
            if Entry4 and Entry4.k ~= K2 then
                local Value6
                Entry4.k = K2
                local Emitters = Entry4.emitters
                Value6 = nil

                for Key3, Value7 in Emitters, nil, nil do
                    local Item = Value7[ 1 ]
                    Item.Rate = Value7[ 2 ] * K2
                end
            end
        end
    end

    local Value1 = nil

    for Value4 in Table, nil, nil do
        if not Table3[ Value4 ] then
            local Entry = Table[ Value4 ]

            if Entry then
                Entry.obj:Destroy( )
                Table[ Value4 ] = nil
            end
        end
    end
end )
Players.PlayerRemoving:Connect( function( Argument1 )
    if Argument1.Character then
        local Character = Argument1.Character
        local Entry = Table[ Character ]

        if Entry then
            Entry.obj:Destroy( )
            Table[ Character ] = nil
        end
    end
end )
