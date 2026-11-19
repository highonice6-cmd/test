-- StarterPlayer.StarterPlayerScripts.LootClient
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
local LootShared = require( ReplicatedStorage:WaitForChild( "LootShared" ) )
local HitAudio = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "HitAudio" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local WeaponVisuals = ReplicatedStorage:WaitForChild( "WeaponVisuals" )
local Loot = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Loot" )
local LocalPlayer = Players.LocalPlayer
local MoneyFormat = require( ReplicatedStorage:WaitForChild( "MoneyFormat" ) )
local Value1 = nil

local function CashLabel( Adornee, LabelName )
    local CASH_BAGS2
    local CASH_BAGS = LootShared.CASH_BAGS
    CASH_BAGS2 = if CASH_BAGS then LootShared.CASH_BAGS[ LabelName ] else CASH_BAGS

    if not CASH_BAGS2 then
        return nil
    end
    if not Value1 or not Value1.Parent then
        local PlayerGui2
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )
        PlayerGui2 = if PlayerGui then PlayerGui:FindFirstChild( "CashBagLabel" ) else PlayerGui
        Value1 = PlayerGui2
    end
    if not Value1 then
        return nil
    end

    local Clone = Value1:Clone( )
    Clone.Enabled = true
    Clone.Adornee = Adornee
    local Amount = Clone:FindFirstChild( "Amount" )

    if Amount and Amount:IsA( "TextLabel" ) then
        Amount.Text = MoneyFormat( CASH_BAGS2 )
    end

    Clone.Parent = Adornee
    return Clone
end

local Folder = Instance.new( "Folder" )
Folder.Name = "LootLocal"
Folder.Parent = workspace
local Table = {
    "LuaSourceContainer",
    "Sound",
    "ParticleEmitter",
    "Light",
    "Beam",
    "Trail",
    "JointInstance",
    "WeldConstraint",
    "ProximityPrompt",
    "BillboardGui",
    "SurfaceGui",
    "TouchTransmitter"
}

local function Strip( Parent )
    for Key, Value in Parent:GetDescendants( ) do
        local Value1, Flag
        Value1 = nil

        for Key2, Value2 in Table, nil, nil do
            if Value:IsA( Value2 ) then
                Value:Destroy( )
                Flag = true
                break
            end

            Flag = false
        end
        if not Flag and Value:IsA( "BasePart" ) then
            Value.CanCollide = false
            Value.CanQuery = false
            Value.CanTouch = false
            Value.CastShadow = false
            Value.Massless = true
        end
    end
end

local function VisibleBox( Parent, Argument2 )
    local Result = Vector3.new( 1, 1, 1 ) * math.huge
    local Result2 = Vector3.new( -1, -1, -1 ) * math.huge

    for Key, Value in Parent:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Transparency < 0.9 then
            local Value1
            local Size = Value.Size / 2
            local Table = { -1, 1 }
            Value1 = nil

            for Key2, Value2 in Table, nil, nil do
                local Value3
                local Table2 = { -1, 1 }
                Value3 = nil

                for Key3, Value4 in Table2, nil, nil do
                    local Value5
                    local Table3 = { -1, 1 }
                    Value5 = nil

                    for Key4, Value6 in Table3, nil, nil do
                        local PointToObjectSpace = Argument2:PointToObjectSpace( Value.CFrame:PointToWorldSpace( Size * Vector3.new( Value2, Value4, Value6 ) ) )
                        Result = Result:Min( PointToObjectSpace )
                        Result2 = Result2:Max( PointToObjectSpace )
                    end
                end
            end
        end
    end
    if Result.X == math.huge then
        return Vector3.new( 0, 0, 0 ), Vector3.new( 1, 1, 1 )
    end
    return ( Result + Result2 ) / 2, Result2 - Result
end

local function FlatAxis( Parent, Argument2, Argument3 )
    local Table = { }

    for Key, Value in Parent:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Transparency < 0.9 then
            local Value3
            local Size = Value.Size / 2
            local Table3 = { -1, 1 }
            Value3 = nil

            for Key3, Value4 in Table3, nil, nil do
                local Value5
                local Table4 = { -1, 1 }
                Value5 = nil

                for Key4, Value6 in Table4, nil, nil do
                    local Value7
                    local Table5 = { -1, 1 }
                    Value7 = nil

                    for Key5, Value8 in Table5, nil, nil do
                        table.insert( Table, Argument2:PointToObjectSpace( Value.CFrame:PointToWorldSpace( Size * Vector3.new( Value4, Value6, Value8 ) ) ) )
                    end
                end
            end
        end
    end
    if #Table == 0 then
        return 1, CFrame.identity
    end

    local Table2
    local I = 0
    Table2 = nil

    for I = 0, 179 do
        local Value1, Number, Number2, Number3, Number4
        local Cos = math.cos( ( math.rad( I ) ) )
        local Sin = math.sin( ( math.rad( I ) ) )
        Value1 = nil
        Number = -math.huge
        Number2 = math.huge
        Number3 = -math.huge
        Number4 = math.huge

        for Key2, Value2 in Table, nil, nil do
            local X = Value2.X * Cos + Value2.Z * Sin
            local Z = Value2.Z * Cos - Value2.X * Sin

            if X < Number4 then
                Number4 = X
            end
            if Number3 < X then
                Number3 = X
            end
            if Z < Number2 then
                Number2 = Z
            end
            if Number < Z then
                Number = Z
            end
        end
        if not Table2 or Number - Number2 < Table2.w - 0.0001 then
            Table2 = {
                ux = Cos,
                uz = Sin,
                w = Number - Number2,
                len = Number3 - Number4,
                ca = ( Number4 + Number3 ) / 2,
                cb = ( Number2 + Number ) / 2
            }
        end
    end

    local Ux = Table2.ux
    local Vector32 = Vector3.new( Ux, 0, Table2.uz )
    local Amount = -Table2.uz
    local Vector33 = Vector3.new( Amount, 0, Table2.ux )
    local Vector34 = Vector32 * Table2.ca + Vector33 * Table2.cb
    local Len = Table2.len
    local X2 = Argument3.X
    return Len, CFrame.new( Vector34 - Vector3.new( X2, 0, Argument3.Z ) ) * CFrame.lookAt( Vector3.new( 0, 0, 0 ), Vector32 )
end

local Color32 = Color3.new( 1, 1, 1 )
local Table2 = { }

local function NewRig()
    local Parent = Instance.new( "Part" )
    Parent.Name = "Underglow"
    Parent.Anchored = true
    Parent.CanCollide = false
    Parent.CanQuery = false
    Parent.CanTouch = false
    Parent.CastShadow = false
    Parent.Transparency = 1
    Parent.Size = Vector3.new( 2, 0.05000000074505806, 2 )
    local Table = { part = Parent, fades = { }, fade = 1 }
    local Underglow = LootShared.Aura:FindFirstChild( "Underglow" )

    if Underglow then
        Table.gui = Underglow:Clone( )
        Table.b0 = Table.gui.Brightness

        for Key, Value in Table.gui:GetChildren( ) do
            local Text

            if Value:IsA( "ImageLabel" ) then
                Text = "ImageTransparency"
            elseif Value:IsA( "CanvasGroup" ) then
                Text = "GroupTransparency"
            else
                Text = Value:IsA( "GuiObject" ) and "BackgroundTransparency"
            end
            if Text then
                local Fades = Table.fades
                table.insert( Fades, { Value, Text, Value[ Text ] } )
            end
        end

        Table.gui.Parent = Parent
    end

    local Volume = LootShared.Aura:FindFirstChild( "Volume" )

    if Volume then
        local A0 = Instance.new( "Attachment" )
        local A1 = Instance.new( "Attachment" )
        Table.a0 = A0
        Table.a1 = A1
        local A02 = Table.a0
        local A12 = Table.a1
        A02.Parent = Parent
        A12.Parent = Parent
        Table.beam = Volume:Clone( )
        local Beam = Table.beam
        local Beam2 = Table.beam
        local Attachment0 = Table.a0
        local Attachment1 = Table.a1
        Beam.Attachment0 = Attachment0
        Beam2.Attachment1 = Attachment1
        Table.b1 = Table.beam.Brightness
        Table.beam.Parent = Parent
        local Bout = Volume:GetAttribute( "Bout" )

        if type( Bout ) == "number" and Bout > 0 then
            local BoutLum2
            local C0 = Instance.new( "Attachment" )
            local C1 = Instance.new( "Attachment" )
            Table.c0 = C0
            Table.c1 = C1
            local C02 = Table.c0
            local C12 = Table.c1
            C02.Parent = Parent
            C12.Parent = Parent
            Table.cross = Volume:Clone( )
            Table.cross.Name = "VolumeTravers"
            local Cross = Table.cross
            local Cross2 = Table.cross
            local Attachment02 = Table.c0
            local Attachment12 = Table.c1
            Cross.Attachment0 = Attachment02
            Cross2.Attachment1 = Attachment12
            local BoutLum = Volume:GetAttribute( "BoutLum" )
            local B1 = Table.b1
            BoutLum2 = type( BoutLum ) == "number" and BoutLum or 0.6
            Table.b3 = B1 * BoutLum2
            Table.cross.Parent = Parent
        end
    end

    local Reflet = LootShared.Aura:FindFirstChild( "Reflet" )

    if Reflet then
        Table.light = Reflet:Clone( )
        Table.b2 = Table.light.Brightness
        Table.light.Parent = Parent
    end

    return Table
end

local I = 1

for I = 1, 30 do
    Table2[ I ] = NewRig( )
end

local function FitRig( Rig, Argument2 )
    local Len = Argument2.len
    local Color = Argument2.color

    if Rig.gui then
        local Marge2
        local Marge = Rig.gui:GetAttribute( "Marge" )
        local Largeur = Rig.gui:GetAttribute( "Largeur" )
        Marge2 = type( Marge ) == "number" and Marge or 1.9
        local Largeur2
        local Len2 = Len + Marge2
        local Part = Rig.part
        Largeur2 = type( Largeur ) == "number" and Largeur or 2.3
        Part.Size = Vector3.new( Largeur2, 0.05, Len2 )

        for Key, Value in Rig.gui:GetDescendants( ) do
            if Value:IsA( "GuiObject" ) then
                local Blanc = Value:GetAttribute( "Blanc" )

                if type( Blanc ) == "number" then
                    local ImageColor3 = Color:Lerp( Color32, Blanc )

                    if Value:IsA( "ImageLabel" ) or Value:IsA( "ImageButton" ) then
                        Value.ImageColor3 = ImageColor3
                    else
                        Value.BackgroundColor3 = ImageColor3
                    end
                end

                local Longueur = Value:GetAttribute( "Longueur" )

                if type( Longueur ) == "number" then
                    local Plus2
                    local Plus = Value:GetAttribute( "Plus" )
                    local Len3 = Len * Longueur
                    Plus2 = type( Plus ) == "number" and Plus or 0
                    local Min = math.min( ( Len3 + Plus2 ) / Len2, 1 )
                    Value.Size = UDim2.new( Min, 0, Value.Size.Y.Scale, Value.Size.Y.Offset )
                end
            end
        end
    end
    if Rig.beam then
        local Marge4
        local Marge3 = Rig.beam:GetAttribute( "Marge" )
        local Bout = Rig.beam:GetAttribute( "Bout" )
        local Hauteur = Rig.beam:GetAttribute( "Hauteur" )
        Marge4 = type( Marge3 ) == "number" and Marge3 or 1.6
        local H
        local Len4 = ( Len + Marge4 ) / 2
        H = type( Hauteur ) == "number" and Hauteur or 0.75
        local W = 2 * H
        Rig.h = H
        Rig.w = W
        local A0 = Rig.a0
        local A1 = Rig.a1
        local Position = Vector3.new( 0, 0, -Len4 )
        local Position2 = Vector3.new( 0, 0, Len4 )
        A0.Position = Position
        A1.Position = Position2
        local Beam = Rig.beam
        local Beam2 = Rig.beam
        local Width0 = 2 * H
        local Width1 = 2 * H
        Beam.Width0 = Width0
        Beam2.Width1 = Width1
        local Beam3 = Rig.beam
        Beam3.Color = ColorSequence.new( Color )

        if Rig.cross then
            local Bout2
            Bout2 = type( Bout ) == "number" and Bout or 1.2
            local Bout3 = Bout2 / 2
            local C0 = Rig.c0
            local C1 = Rig.c1
            local Position3 = Vector3.new( -Bout3, 0, 0 )
            local Position4 = Vector3.new( Bout3, 0, 0 )
            C0.Position = Position3
            C1.Position = Position4
            local Cross = Rig.cross
            local Cross2 = Rig.cross
            local Width02 = 2 * H
            local Width12 = 2 * H
            Cross.Width0 = Width02
            Cross2.Width1 = Width12
            local Cross3 = Rig.cross
            Cross3.Color = ColorSequence.new( Color )
        end
    end
    if Rig.light then
        Rig.light.Color = Color
    end
end

local function RigLevel( Argument1, Fade, Argument3, Side )
    if Argument1.fade ~= Fade then
        local Value1
        Argument1.fade = Fade
        local Fades = Argument1.fades
        Value1 = nil

        for Key, Value in Fades, nil, nil do
            Value[ 1 ][ Value[ 2 ] ] = 1 - ( 1 - Value[ 3 ] ) * Fade
        end
    end

    local Side3

    if Side then
        Side3 = Side
    else
        local Side2 = Argument1.side

        if Side2 then
            Side3 = Side2
        else
            Side3 = 1
        end
    end

    Argument1.side = Side3
    local Far = Argument1.far or 1

    if Argument1.gui then
        local Gui = Argument1.gui
        Gui.Brightness = Argument1.b0 * Argument3 * Far
    end
    if Argument1.beam then
        local Beam = Argument1.beam
        Beam.Brightness = Argument1.b1 * Argument3 * Fade * Side3 * Far
    end
    if Argument1.cross then
        local Cross = Argument1.cross
        Cross.Brightness = Argument1.b3 * Argument3 * Fade * math.sqrt( 1 - Side3 * Side3 ) * Far
    end
    if Argument1.lit then
        local Light = Argument1.light
        Light.Brightness = Argument1.b2 * Argument3 * Fade
    end
end

local function SetFar( Argument1, Amount )
    local Clamp = math.clamp( ( Amount - 20 ) / 60, 0, 1 )
    Argument1.far = Clamp * 0.6 + 1
    local W = 2 * ( Argument1.h or 0.75 ) * ( Clamp * 1 + 1 )

    if Argument1.beam and math.abs( W - ( Argument1.w or 0 ) ) > 0.05 then
        Argument1.w = W
        local Beam = Argument1.beam
        local Beam2 = Argument1.beam
        Beam.Width0 = W
        Beam2.Width1 = W

        if Argument1.cross then
            local Cross = Argument1.cross
            local Cross2 = Argument1.cross
            Cross.Width0 = W
            Cross2.Width1 = W
        end
    end
end

local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true

local function GroundOf( Argument1 )
    if Argument1.ground then
        return Argument1.ground
    end

    local FilterDescendantsInstances = { Folder }

    for Key, Value in Players:GetPlayers( ) do
        if Value.Character then
            table.insert( FilterDescendantsInstances, Value.Character )
        end
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Argument1.pos, Vector3.new( 0, -( LootShared.FLOAT + 1.5 ), 0 ), RaycastParams2 )

    if Raycast then
        local CFrame3
        local Normal = Raycast.Normal
        local Cross = Vector3.new( 0, 1, 0 ):Cross( Normal )
        local CFrame2 = CFrame.new( Raycast.Position )
        CFrame3 = if not ( Normal.Y > 0.7 ) or not ( Cross.Magnitude > 0.001 ) then CFrame2 else CFrame2 * CFrame.fromAxisAngle( Cross.Unit, ( math.acos( ( math.clamp( Normal.Y, -1, 1 ) ) ) ) )
        Argument1.ground = CFrame3 * CFrame.new( 0, 0.03, 0 )
        return Argument1.ground
    end
    local Flat2
    local Flat = Argument1.flat
    Flat2 = if Flat then Flat else CFrame.new( Argument1.pos - Vector3.new( 0, LootShared.FLOAT - 0.03, 0 ) )
    Argument1.flat = Flat2
    return Argument1.flat
end

local function ReleaseRig( Argument1 )
    Argument1.part.Parent = nil
    table.insert( Table2, Argument1 )
end

local function SetRig( Argument1, Argument2 )
    local Flag = Argument1.rig ~= nil and true or false

    if Argument2 == Flag then
        return
    end
    if not Argument2 then
        local Rig2 = Argument1.rig
        Rig2.part.Parent = nil
        table.insert( Table2, Rig2 )
        Argument1.rig = nil
        return
    end

    local Rig = table.remove( Table2 )

    if not Rig then
        return
    end

    Argument1.rig = Rig
    FitRig( Rig, Argument1 )
    SetFar( Rig, Argument1.dist )
    Rig.lit = false

    if Rig.light then
        Rig.light.Enabled = false
    end

    local Part = Rig.part
    Part.CFrame = GroundOf( Argument1 ) * Argument1.align
    Rig.part.Parent = Folder
end

local function Build( Name, Name2 )
    local Parent

    if Name == "I" then
        Parent = nil
    else
        local FoundChild = WeaponVisuals:FindFirstChild( Name2 )

        if FoundChild then
            Parent = FoundChild:Clone( )
        else
            Parent = nil
        end
    end
    if not Parent then
        local Template = LootShared.Template( Name, Name2 )

        if not Template then
            return nil
        end

        local Parent2 = Instance.new( "Model" )

        for Key, Value in Template:GetChildren( ) do
            if Value:IsA( "BasePart" ) and Value.Transparency < 1 then
                Value:Clone( ).Parent = Parent2
            end
        end
        if #Parent2:GetChildren( ) == 0 then
            Parent2:Destroy( )
            return nil
        end
        Parent = Parent2
    end

    local Part0
    Strip( Parent )
    local PrimaryPart = Parent.PrimaryPart

    if PrimaryPart then
        Part0 = PrimaryPart
    else
        local PrimaryPart2 = Instance.new( "Part" )
        PrimaryPart2.Name = "LootRoot"
        PrimaryPart2.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
        PrimaryPart2.Transparency = 1
        PrimaryPart2.CanCollide = false
        PrimaryPart2.CanQuery = false
        PrimaryPart2.CanTouch = false
        PrimaryPart2.CastShadow = false
        PrimaryPart2.CFrame = CFrame.new( Parent:GetBoundingBox( ).Position )
        PrimaryPart2.Parent = Parent
        Parent.PrimaryPart = PrimaryPart2
        Part0 = PrimaryPart2
    end

    local GROUND_SCALE2
    local GROUND_SCALE = LootShared.GROUND_SCALE
    GROUND_SCALE2 = if GROUND_SCALE then LootShared.GROUND_SCALE[ Name2 ] else GROUND_SCALE

    if type( GROUND_SCALE2 ) == "number" and GROUND_SCALE2 > 0 and GROUND_SCALE2 ~= 1 then
        Parent:ScaleTo( GROUND_SCALE2 )
    end

    local VisibleBox2 = VisibleBox( Parent, Part0.CFrame )

    for Key2, Value2 in Parent:GetDescendants( ) do
        if Value2:IsA( "BasePart" ) then
            if Value2 == Part0 then
                Value2.Anchored = true
            else
                Value2.Anchored = false
                local WeldConstraint = Instance.new( "WeldConstraint" )
                WeldConstraint.Part0 = Part0
                WeldConstraint.Part1 = Value2
                WeldConstraint.Parent = Value2
            end
        end
    end

    Parent.Name = Name2
    local Value3, Value4 = FlatAxis( Parent, Part0.CFrame, VisibleBox2 )
    return {
        model = Parent,
        offset = CFrame.new( -VisibleBox2 ),
        len = Value3,
        align = Value4,
        scale = Parent:GetScale( )
    }
end

local Table3 = { }
local Table4 = { }
local Table5 = { }
local Table6 = { }

local function SetOn( Argument1, On )
    if Argument1.on == On then
        return
    end

    local Parent
    Argument1.on = On
    local Model = Argument1.model
    Parent = On and Folder or nil
    Model.Parent = Parent
end

local function Place( Argument1, Argument2 )
    Argument1.model:PivotTo( Argument2 * Argument1.root.CFrame:ToObjectSpace( Argument1.model:GetPivot( ) ) )
end

local Hide = nil

local function Show( Adornee )
    if Table4[ Adornee ] or not Adornee:IsA( "BasePart" ) then
        return
    end
    if Adornee:GetAttribute( "PickedBy" ) then
        return
    end

    local T = Adornee:GetAttribute( "T" )
    local K = Adornee:GetAttribute( "K" )

    if type( T ) ~= "string" or type( K ) ~= "string" then
        return
    end

    local Text = T .. K

    if Table3[ Text ] == nil then
        Table3[ Text ] = Build( T, K ) or false
    end

    local Entry = Table3[ Text ]

    if not Entry then
        return
    end

    local Armed
    local Clone = Entry.model:Clone( )
    local PrimaryPart = Clone.PrimaryPart
    local Position = Adornee.Position
    local Offset = Entry.offset
    local Len = Entry.len
    local Align = Entry.align
    local Scale = Entry.scale
    local Color = LootShared.Color( K )
    local CFrame2 = CFrame.new( Position )
    local Table = {
        part = Adornee,
        model = Clone,
        root = PrimaryPart,
        offset = Offset,
        len = Len,
        align = Align,
        scale = Scale,
        color = Color,
        pos = Position,
        base = CFrame2,
        phase = math.random( ) * 3.141592653589793 * 2,
        on = false,
        dist = math.huge
    }
    Armed = Adornee:GetAttribute( "By" ) ~= LocalPlayer.UserId and true or false
    Table.armed = Armed
    local From = Adornee:GetAttribute( "From" )
    local At = Adornee:GetAttribute( "At" )

    if typeof( From ) == "Vector3" and type( At ) == "number" and workspace:GetServerTimeNow( ) - At < 0.55 then
        Table.from = From
        Table.at = At
    end

    local CFrame4

    if Table.from then
        local CFrame3 = CFrame.new( Table.from )

        if CFrame3 then
            CFrame4 = CFrame3
        else
            CFrame4 = Table.base
        end
    else
        CFrame4 = Table.base
    end

    local Dist
    local CFrame5 = CFrame4 * Table.offset
    Table.model:PivotTo( CFrame5 * Table.root.CFrame:ToObjectSpace( Table.model:GetPivot( ) ) )
    Table.label = CashLabel( Adornee, K )
    Table4[ Adornee ] = Table
    Table.conn = Adornee:GetAttributeChangedSignal( "PickedBy" ):Connect( function()
        Hide( Adornee )
    end )
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Magnitude = ( Position - CurrentCamera.CFrame.Position ).Magnitude

        if Magnitude then
            Dist = Magnitude
        else
            Dist = math.huge
        end
    else
        Dist = math.huge
    end

    Table.dist = Dist

    if Table.dist <= 120 then
        if Table.on ~= true then
            Table.on = true
            local Model = Table.model
            Model.Parent = Folder or nil
        end

        table.insert( Table5, Table )
        SetRig( Table, true )
    end
end

Hide = function( Key )
    local Entry = Table4[ Key ]

    if not Entry then
        return
    end

    Table4[ Key ] = nil

    if Entry.conn then
        Entry.conn:Disconnect( )
    end
    if Entry.label then
        Entry.label:Destroy( )
        Entry.label = nil
    end

    local Find = table.find( Table5, Entry )

    if Find then
        table.remove( Table5, Find )
    end

    local PlayerByUserId
    local PickedBy = Key:GetAttribute( "PickedBy" )

    if type( PickedBy ) == "number" then
        PlayerByUserId = Players:GetPlayerByUserId( PickedBy )
    else
        PlayerByUserId = false
    end

    local Flag = if PlayerByUserId then PlayerByUserId.Character else PlayerByUserId
    local HumanoidRootPart

    if Flag then
        local UpperTorso = Flag:FindFirstChild( "UpperTorso" )

        if UpperTorso then
            HumanoidRootPart = UpperTorso
        else
            HumanoidRootPart = Flag:FindFirstChild( "HumanoidRootPart" )
        end
    else
        HumanoidRootPart = Flag
    end
    if Entry.on and HumanoidRootPart and HumanoidRootPart:IsA( "BasePart" ) then
        local CFrame = Entry.root.CFrame * Entry.offset:Inverse( )
        table.insert( Table6, {
            s = Entry,
            target = HumanoidRootPart,
            t0 = os.clock( ),
            from = CFrame.Position,
            rot = CFrame.Rotation,
            rig = Entry.rig
        } )
        Entry.rig = nil
        return
    end

    local Flag2 = Entry.rig ~= nil and true or false

    if Flag2 ~= false then
        local Rig = Entry.rig
        Rig.part.Parent = nil
        table.insert( Table2, Rig )
        Entry.rig = nil
    end

    Entry.model:Destroy( )
end

local function RefreshActive()
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Value1
    local Position = CurrentCamera.CFrame.Position
    table.clear( Table5 )
    Value1 = nil

    for Key, Value in Table4, nil, nil do
        local On
        Value.dist = ( Key.Position - Position ).Magnitude
        On = Value.dist <= 120 and true or false

        if Value.on ~= On then
            local Parent
            Value.on = On
            local Model = Value.model
            Parent = On and Folder or nil
            Model.Parent = Parent
        end
        if On then
            table.insert( Table5, Value )
        else
            local Flag2 = Value.rig ~= nil and true or false

            if Flag2 ~= false then
                local Rig3 = Value.rig
                Rig3.part.Parent = nil
                table.insert( Table2, Rig3 )
                Value.rig = nil
            end
        end
    end

    table.sort( Table5, function( Argument1, Argument2 )
        local Flag = Argument1.dist < Argument2.dist and true or false
        return Flag
    end )
    local Count = #Table5
    local I = 31

    for I = 31, Count do
        local Flag
        local Entry = Table5[ I ]
        Flag = Entry.rig ~= nil and true or false

        if Flag ~= false then
            local Rig = Entry.rig
            Rig.part.Parent = nil
            table.insert( Table2, Rig )
            Entry.rig = nil
        end
    end

    local Min = math.min( 30, #Table5 )
    local I2 = 1

    for I2 = 1, Min do
        local Entry2 = Table5[ I2 ]
        SetRig( Entry2, true )
        local Rig2 = Entry2.rig

        if Rig2 then
            if not Entry2.ground then
                GroundOf( Entry2 )
            end

            local Lit
            SetFar( Rig2, Entry2.dist )

            if I2 <= 8 then
                if Rig2.light == nil then
                    Lit = false
                else
                    Lit = true
                end
            else
                Lit = false
            end
            if Rig2.lit ~= Lit then
                Rig2.lit = Lit

                if Rig2.light then
                    Rig2.light.Enabled = Lit
                end
            end
        end
    end
end

local Table7 = { }
local Table8 = { }
RunService.PreRender:Connect( function()
    local Count = #Table6
    local I = Count

    for I = Count, 1, -1 do
        local Entry = Table6[ I ]
        local Clock = ( os.clock( ) - Entry.t0 ) / 0.3

        if Clock >= 1 or not Entry.target.Parent then
            Entry.s.model:Destroy( )

            if Entry.rig then
                local Rig2 = Entry.rig
                Rig2.part.Parent = nil
                table.insert( Table2, Rig2 )
            end

            table.remove( Table6, I )
        else
            local Clock2 = Clock * Clock
            local Clock3 = 1 - 0.85 * Clock2
            Entry.s.model:ScaleTo( Clock3 * Entry.s.scale )
            local From = Entry.from
            local Lerp = From:Lerp( Entry.target.Position, Clock2 ) + Vector3.new( 0, 2.4 * Clock * ( 1 - Clock ), 0 )
            local S = Entry.s
            local CFrame2 = CFrame.new( Lerp ) * Entry.rot * CFrame.new( Entry.s.offset.Position * Clock3 )
            S.model:PivotTo( CFrame2 * S.root.CFrame:ToObjectSpace( S.model:GetPivot( ) ) )

            if Entry.rig then
                local Rig = Entry.rig
                RigLevel( Rig, math.max( 1 - Clock * 2, 0 ), 1 )
            end
        end
    end

    local Number
    local Clock4 = os.clock( )
    local ServerTimeNow = workspace:GetServerTimeNow( )
    local Position = workspace.CurrentCamera.CFrame.Position
    local Count2 = #Table5
    local I2 = 1
    Number = 0

    for I2 = 1, Count2 do
        local Number3
        local Entry2 = Table5[ I2 ]
        local Base = Entry2.base

        if Entry2.from then
            local ServerTimeNow2 = ( ServerTimeNow - Entry2.at ) / 0.55

            if ServerTimeNow2 >= 1 then
                Entry2.from = nil
                Number3 = 1
            else
                local Max = math.max( ServerTimeNow2, 0 )
                local Max2 = 1 - ( 1 - Max ) ^ 3
                local From2 = Entry2.from
                Base = CFrame.new( From2:Lerp( Entry2.pos, Max2 ) + Vector3.new( 0, 3.6 * Max * ( 1 - Max ), 0 ) )
                Number3 = Max2
            end
        else
            Number3 = 1
        end

        local Sin = math.sin( Clock4 * 2 + Entry2.phase )
        local Angles = CFrame.Angles( 0, Clock4 * 0.9 + Entry2.phase, 0 )
        local Number2 = Number + 1
        Table7[ Number2 ] = Entry2.root
        Table8[ Number2 ] = Base * CFrame.new( 0, Sin * 0.15, 0 ) * Angles * Entry2.offset
        local Rig3 = Entry2.rig

        if Rig3 then
            local Ground2
            local Ground = Entry2.ground

            if Ground then
                Ground2 = Ground
            else
                local Flat = Entry2.flat

                if Flat then
                    Ground2 = Flat
                else
                    Ground2 = GroundOf( Entry2 )
                end
            end
            if Number3 < 1 then
                local Position2 = Base.Position - Entry2.pos
                local X = Position2.X
                Ground2 = CFrame.new( X, 0, Position2.Z ) * Ground2
            end

            local Min2
            local Ground3 = Ground2 * Angles * Entry2.align
            local Number4 = Number2 + 1
            Table7[ Number4 ] = Rig3.part
            Table8[ Number4 ] = Ground3
            local Position3 = Ground3.Position - Position
            local LookVector = Ground3.LookVector
            local Sqrt = math.sqrt( Position3.X * Position3.X + Position3.Z * Position3.Z )

            if Sqrt > 0.01 then
                local Min = math.min( math.abs( Position3.X * LookVector.Z - Position3.Z * LookVector.X ) / Sqrt, 1 )

                if Min then
                    Min2 = Min
                else
                    Min2 = 1
                end
            else
                Min2 = 1
            end

            RigLevel( Rig3, Number3, 1 - Sin * 0.12, Min2 )
            Number = Number4
        else
            Number = Number2
        end
    end

    local Count3 = #Table7
    local Number5 = Number + 1
    local I3 = Count3

    for I3 = Count3, Number5, -1 do
        Table7[ I3 ] = nil
        Table8[ I3 ] = nil
    end
    if Number > 0 then
        workspace:BulkMoveTo( Table7, Table8, Enum.BulkMoveMode.FireCFrameChanged )
    end
end )

local function PickCheck()
    if #Table5 == 0 then
        return
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
    if not Humanoid or not HumanoidRootPart or Humanoid.Health <= 0 or Humanoid.SeatPart or Character:GetAttribute( "Downed" ) then
        return
    end

    local Value1
    local Asked = os.clock( )
    local Position = HumanoidRootPart.Position
    Value1 = nil

    for Key, Value in Table5, nil, nil do
        local Position2 = Value.part.Position - Position
        local Magnitude = Vector2.new( Position2.X, Position2.Z ).Magnitude

        if not ( Magnitude <= LootShared.PICK_RADIUS ) or not ( math.abs( Position2.Y ) <= 4.5 ) then
            Value.refused = nil

            if not Value.armed and LootShared.PICK_RADIUS + 2.5 < Magnitude then
                Value.armed = true
            end
        elseif Value.armed and not Value.refused then
            if not Value.asked or Asked - Value.asked > 1 then
                Value.asked = Asked
                Loot:FireServer( "pick", Value.part )
            end
        end
    end
end

Loot.OnClientEvent:Connect( function( Name, Name2, Key, Argument4, Amount )
    if Name == "refused" then
        local Flag = if typeof( Key ) == "Instance" then Table4[ Key ] else false

        if Flag then
            Flag.refused = true
        end
        if type( Name2 ) == "string" then
            Notify.Error( Name2 )
            return
        end
    elseif Name == "picked" then
        local Text
        local Play = HitAudio.Play
        Text = Name2 ~= "I" and "WeaponPickup" or "ItemPickup"
        Play( Text )

        if type( Key ) == "string" then
            local Value1 = type( Argument4 ) == "string" and Argument4 or Key
            local Floor2

            if type( Amount ) ~= "number" or not ( Amount >= 1 ) then
                Floor2 = 1
            else
                local Floor = math.floor( Amount )

                if Floor then
                    Floor2 = Floor
                else
                    Floor2 = 1
                end
            end

            Notify.Pickup( ( "+%d %s" ):format( Floor2, Value1 ), LootShared.Color( Key ) )
        end
    end
end )
CollectionService:GetInstanceAddedSignal( LootShared.TAG ):Connect( Show )
CollectionService:GetInstanceRemovedSignal( LootShared.TAG ):Connect( Hide )

for Key, Value in CollectionService:GetTagged( LootShared.TAG ) do
    Show( Value )
end

task.spawn( function()
    local Number = 0

    while true do
        task.wait( 0.1 )
        PickCheck( )
        local Number2 = Number + 1

        if Number2 >= 5 then
            RefreshActive( )
            Number = 0
        else
            Number = Number2
        end
    end
end )
