-- ReplicatedStorage.AntiTunnel
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table2 = {
    HumanoidRootPart = true,
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    Head = true
}
local Table3 = { "Cars", "FX", "ClientHitboxes", "TrainsLocaux", "Dummies" }
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local Value1 = nil
local Number = -math.huge
local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )

local function Track( Key, Argument2 )
    local Table = { model = Key, root = Argument2, parts = { }, gen = Class2[ Key ] or 0 }

    for Key2, Value in Key:GetChildren( ) do
        if Value:IsA( "BasePart" ) then
            local Parts = Table.parts
            Parts[ Value ] = {
                last = Value.Position,
                speed = Value.AssemblyLinearVelocity.Magnitude
            }
        end
    end

    return Table
end

local function Step( Argument1, Argument2, Argument3 )
    local Value1Inner
    local Model = Argument1.model
    local Root = Argument1.root
    local Parts = Argument1.parts
    Value1Inner = nil

    for Value in Parts, nil, nil do
        if Value.Parent ~= Model then
            Argument1.parts[ Value ] = nil
        end
    end
    for Key, Value2 in Model:GetChildren( ) do
        if not Argument1.parts[ Value2 ] and not Class[ Value2 ] then
            if Value2:IsA( "BasePart" ) then
                local Parts5 = Argument1.parts
                Parts5[ Value2 ] = {
                    last = Value2.Position,
                    speed = Value2.AssemblyLinearVelocity.Magnitude
                }
            else
                Class[ Value2 ] = true
            end
        end
    end

    local Gen = Class2[ Model ] or 0

    if Argument1.gen ~= Gen then
        local Value3
        Argument1.gen = Gen
        local Parts2 = Argument1.parts
        Value3 = nil

        for Key2, Value4 in Parts2, nil, nil do
            local Last = Key2.Position
            local Speed = Key2.AssemblyLinearVelocity.Magnitude
            Value4.last = Last
            Value4.speed = Speed
        end
    end

    local Value5, Raycast, Value7, Flag
    local Parts3 = Argument1.parts
    Value5 = nil
    Raycast = nil
    Value7 = nil
    Flag = nil

    for Key3, Value6 in Parts3, nil, nil do
        local Last3 = Key3.Position
        local Last4 = Value6.last
        local Speed3 = Value6.speed
        local Speed4 = Key3.AssemblyLinearVelocity.Magnitude
        local Position = Last3 - Last4
        local Magnitude = Position.Magnitude
        Value6.speed = Speed4

        if Magnitude >= 0.05 then
            Value6.last = Last3
        end
        if not Raycast and Magnitude >= 0.05 and Key3.Parent then
            if Key3 ~= Root then
                if not Argument3 or not Key3.CanCollide then
                    continue
                end
            end
            if Argument3 or Magnitude <= math.max( Speed3, Speed4 ) * Argument2 * 1.5 + 1 then
                if not Flag then
                    if Value1 ~= Model or os.clock( ) - Number > 1 then
                        local Value13
                        local Clock = os.clock( )
                        Value1 = Model
                        Number = Clock
                        local FilterDescendantsInstances = { Model, workspace.CurrentCamera }
                        Value13 = nil

                        for Key7, Value14 in Table3, nil, nil do
                            local FoundChild = workspace:FindFirstChild( Value14 )

                            if FoundChild then
                                table.insert( FilterDescendantsInstances, FoundChild )
                            end
                        end

                        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
                        Flag = true
                    else
                        Flag = true
                    end
                end

                local NumberInner
                RaycastParams2.CollisionGroup = Key3.CollisionGroup
                NumberInner = ( Key3 == Root or Table2[ Key3.Name ] ) and 0.2 or 0
                local Position3

                if NumberInner > 0 then
                    local Position2 = Position * ( ( Magnitude + NumberInner ) / Magnitude )

                    if Position2 then
                        Position3 = Position2
                    else
                        Position3 = Position
                    end
                else
                    Position3 = Position
                end

                local Raycast3
                local Raycast2 = workspace:Raycast( Last4, Position3, RaycastParams2 )
                Raycast3 = if Raycast2 then Raycast2.Normal.Y else Raycast2

                if Raycast2 and Raycast2.Instance.Anchored and Raycast3 >= -0.3 then
                    if not ( Magnitude < Raycast2.Distance ) or not ( Raycast3 <= 0.3 ) then
                        if not ( Raycast2.Distance <= Magnitude ) then
                            continue
                        end
                        if not ( Raycast3 > 0.3 ) and not ( Raycast2.Distance >= 0.25 ) then
                            continue
                        end
                    end

                    local Model2 = Raycast2.Instance:FindFirstAncestorOfClass( "Model" )

                    if not Model2 or not Model2:FindFirstChildOfClass( "Humanoid" ) then
                        Raycast = Raycast2
                        Value7 = Key3
                    end
                end
            end
        end
    end
    if not Raycast then
        return false
    end

    local Dot2
    local Normal = Raycast.Normal
    local Dot = 1 - ( Value7.Position - Raycast.Position ):Dot( Normal )
    local Table = { }
    Dot2 = Dot

    for Key4, Value8 in Model:GetDescendants( ) do
        if Value8:IsA( "BasePart" ) and not Value8.Anchored then
            table.insert( Table, Value8 )

            if Argument3 or math.abs( Normal.Y ) > 0.3 then
                if Value8.CanCollide or Value8 == Root then
                    Dot2 = math.max( Dot2, 1 - ( Value8.Position - Raycast.Position ):Dot( Normal ) )
                end
            end
        end
    end

    local Value9
    Model:PivotTo( Model:GetPivot( ) + Normal * math.min( Dot2, ( math.max( 6, Dot ) ) ) )
    Value9 = nil

    for Key5, Value10 in Table, nil, nil do
        local AssemblyLinearVelocity = Value10.AssemblyLinearVelocity
        local Dot3 = AssemblyLinearVelocity:Dot( Normal )

        if Dot3 < 0 then
            Value10.AssemblyLinearVelocity = AssemblyLinearVelocity - Normal * Dot3
        end
    end

    local Value11
    local Parts4 = Argument1.parts
    Value11 = nil

    for Key6, Value12 in Parts4, nil, nil do
        local Last2 = Key6.Position
        local Speed2 = Key6.AssemblyLinearVelocity.Magnitude
        Value12.last = Last2
        Value12.speed = Speed2
    end

    return true
end

local RaycastParams3 = RaycastParams.new( )
RaycastParams3.IgnoreWater = true
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.RespectCanCollide = true

local function JointFrames( Self )
    if Self:IsA( "Motor6D" ) then
        return Self.Part0, Self.Part1, Self.C0, Self.C1
    end

    local Attachment0 = Self.Attachment0
    local Attachment1 = Self.Attachment1

    if not Attachment0 or not Attachment1 then
        return
    end
    return Attachment0.Parent, Attachment1.Parent, Attachment0.CFrame, Attachment1.CFrame
end

local function Blocked( Argument1, Argument2 )
    local Raycast2
    local Raycast = workspace:Raycast( Argument1, Argument2 - Argument1, RaycastParams3 )
    Raycast2 = Raycast and Raycast.Instance.Anchored and Raycast or nil
    return Raycast2
end

local Table = {
    Track = Track,
    Step = Step,
    Unclip = function( Key )
        local HumanoidRootPart = Key:FindFirstChild( "HumanoidRootPart" )

        if not HumanoidRootPart then
            return 0
        end

        local Table = { }

        for Key2, Value in Key:GetDescendants( ) do
            if Value:IsA( "Motor6D" ) or Value:IsA( "AnimationConstraint" ) then
                local Part0, Part1, C0, C1

                if Value:IsA( "Motor6D" ) then
                    Part0 = Value.Part0
                    Part1 = Value.Part1
                    C0 = Value.C0
                    C1 = Value.C1
                else
                    local Attachment0 = Value.Attachment0
                    local Attachment1 = Value.Attachment1

                    if not Attachment0 or not Attachment1 then
                        Part0 = nil
                        Part1 = nil
                        C0 = nil
                        C1 = nil
                    else
                        Part0 = Attachment0.Parent
                        Part1 = Attachment1.Parent
                        C0 = Attachment0.CFrame
                        C1 = Attachment1.CFrame
                    end
                end
                if Part0 and Part1 and Part1.Parent == Key and Part0:IsA( "BasePart" ) and Part1:IsA( "BasePart" ) then
                    local Entry5
                    local Entry4 = Table[ Part0 ]
                    Entry5 = if Entry4 then Entry4 else { }
                    Table[ Part0 ] = Entry5
                    table.insert( Table[ Part0 ], { Part1, Value, C0, C1 } )
                end
            end
        end

        local Value1
        local FilterDescendantsInstances = { Key, workspace.CurrentCamera }
        Value1 = nil

        for Key3, Value2 in Table3, nil, nil do
            local FoundChild = workspace:FindFirstChild( Value2 )

            if FoundChild then
                table.insert( FilterDescendantsInstances, FoundChild )
            end
        end

        local Number, Number2
        RaycastParams3.FilterDescendantsInstances = FilterDescendantsInstances
        local Table2 = { HumanoidRootPart }
        local Table3Inner = { [ HumanoidRootPart ] = true }
        Number = 1
        Number2 = 0

        while Table2[ Number ] do
            local Entry3
            local Entry = Table2[ Number ]
            Number = Number + 1
            local Entry2 = Table[ Entry ]
            Entry3 = if Entry2 then Entry2 else { }
            local Value3 = nil

            for Key4, Value4 in Entry3, nil, nil do
                local Item = Value4[ 1 ]
                local Item2 = Value4[ 2 ]
                local Item3 = Value4[ 3 ]
                local Item4 = Value4[ 4 ]

                if not Table3Inner[ Item ] then
                    local NotEnabled2
                    Table3Inner[ Item ] = true
                    table.insert( Table2, Item )
                    local NotEnabled = not Item2.Enabled

                    if NotEnabled then
                        NotEnabled2 = NotEnabled
                    else
                        local IsA = Item2:IsA( "AnimationConstraint" )

                        if IsA then
                            local NotIsKinematic = not Item2.IsKinematic

                            if NotIsKinematic then
                                if Item2.MaxTorque == 0 then
                                    NotEnabled2 = true
                                else
                                    NotEnabled2 = false
                                end
                            else
                                NotEnabled2 = NotIsKinematic
                            end
                        else
                            NotEnabled2 = IsA
                        end
                    end
                    if NotEnabled2 and Item.CanCollide and not Item.Anchored then
                        local Raycast2
                        RaycastParams3.CollisionGroup = Item.CollisionGroup
                        local Position = Entry.Position
                        local Raycast = workspace:Raycast( Position, Item.Position - Position, RaycastParams3 )
                        Raycast2 = Raycast and Raycast.Instance.Anchored and Raycast or nil

                        if Raycast2 then
                            local Raycast4
                            Item.CFrame = Entry.CFrame * Item3 * Item4:Inverse( )
                            local Position2 = Entry.Position
                            local Raycast3 = workspace:Raycast( Position2, Item.Position - Position2, RaycastParams3 )
                            Raycast4 = Raycast3 and Raycast3.Instance.Anchored and Raycast3 or nil

                            if Raycast4 then
                                Item.CFrame = Item.CFrame + Raycast4.Normal * ( ( Raycast4.Position - Item.Position ):Dot( Raycast4.Normal ) + 0.4 )
                            end

                            Item.AssemblyLinearVelocity = Entry.AssemblyLinearVelocity
                            Number2 = Number2 + 1
                        end
                    end
                end
            end
        end
        if Number2 > 0 then
            Class2[ Key ] = ( Class2[ Key ] or 0 ) + 1
        end

        return Number2
    end,
    Moved = function( Key )
        Class2[ Key ] = ( Class2[ Key ] or 0 ) + 1
    end
}
return Table
