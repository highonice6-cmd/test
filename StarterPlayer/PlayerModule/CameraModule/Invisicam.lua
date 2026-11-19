-- StarterPlayer.PlayerModule.CameraModule.Invisicam
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Get = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" )
local UserFlag = Get.getUserFlag( "UserRaycastUpdateAPI2" )
local UserFlag2 = Get.getUserFlag( "UserPlayerModuleEngineAPI" )
local Table = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
}
local Table2 = {
    Head = true,
    [ "Left Arm" ] = true,
    [ "Right Arm" ] = true,
    [ "Left Leg" ] = true,
    [ "Right Leg" ] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
}
local Table3 = {
    Vector3.new( 1, 1, -1 ),
    Vector3.new( 1, -1, -1 ),
    Vector3.new( -1, -1, -1 ),
    Vector3.new( -1, 1, -1 )
}
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.FilterType = Enum.RaycastFilterType.Include

local function AssertTypes( Mode, ... )
    local Text
    local Table = { }
    Text = ""

    for Key, Value in pairs( { ... } ) do
        local Text2
        Table[ Value ] = true
        Text2 = Text ~= "" and " or " or ""
        Text = Text .. Text2 .. Value
    end

    local Kind = type( Mode )
    local Entry = Table[ Kind ]
    assert( Entry, Text .. " type expected, got: " .. Kind )
end

local function Det3x3( Argument1, Argument2, Argument3, Argument4, Argument5, Argument6, Argument7, Argument8, Argument9 )
    return Argument1 * ( Argument5 * Argument9 - Argument6 * Argument8 ) - Argument2 * ( Argument4 * Argument9 - Argument6 * Argument7 ) + Argument3 * ( Argument4 * Argument8 - Argument5 * Argument7 )
end

local function RayIntersection( Argument1, Argument2, Argument3, Argument4 )
    local Cross = Argument2:Cross( Argument4 )
    local X = Argument3.X - Argument1.X
    local Y = Argument3.Y - Argument1.Y
    local Z = Argument3.Z - Argument1.Z
    local X2 = Argument2.X
    local Amount = -Argument4.X
    local X3 = Cross.X
    local Y2 = Argument2.Y
    local Amount2 = -Argument4.Y
    local Y3 = Cross.Y
    local Z2 = Argument2.Z
    local Amount3 = -Argument4.Z
    local Z3 = Cross.Z
    local X4 = X2 * ( Amount2 * Z3 - Y3 * Amount3 ) - Amount * ( Y2 * Z3 - Y3 * Z2 ) + X3 * ( Y2 * Amount3 - Amount2 * Z2 )

    if X4 == 0 then
        return Vector3.new( 0, 0, 0 )
    end

    local Amount4 = -Argument4.X
    local X5 = Cross.X
    local Amount5 = -Argument4.Y
    local Y4 = Cross.Y
    local Amount6 = -Argument4.Z
    local Z4 = Cross.Z
    local X6 = ( X * ( Amount5 * Z4 - Y4 * Amount6 ) - Amount4 * ( Y * Z4 - Y4 * Z ) + X5 * ( Y * Amount6 - Amount5 * Z ) ) / X4
    local X7 = Argument2.X
    local X8 = Cross.X
    local Y5 = Argument2.Y
    local Y6 = Cross.Y
    local Z5 = Argument2.Z
    local Z6 = Cross.Z
    local X9 = ( X7 * ( Y * Z6 - Y6 * Z ) - X * ( Y5 * Z6 - Y6 * Z5 ) + X8 * ( Y5 * Z - Y * Z5 ) ) / X4
    local X10 = Argument1 + X6 * Argument2
    local X11 = Argument3 + X9 * Argument4
    local X12 = X10 + ( X11 - X10 ) * 0.5

    if ( X11 - X10 ).Magnitude < 0.25 then
        return X12
    end
    return Vector3.new( 0, 0, 0 )
end

local BaseOcclusion = require( script.Parent:WaitForChild( "BaseOcclusion" ) )
local Self = setmetatable( { }, BaseOcclusion )
Self.__index = Self
function Self.new()
    local New = setmetatable( BaseOcclusion.new( ), Self )
    New.char = nil
    New.humanoidRootPart = nil
    New.torsoPart = nil
    New.headPart = nil
    New.childAddedConn = nil
    New.childRemovedConn = nil
    New.behaviors = { }
    New.behaviors[ Table.LIMBS ] = New.LimbBehavior
    New.behaviors[ Table.MOVEMENT ] = New.MoveBehavior
    New.behaviors[ Table.CORNERS ] = New.CornerBehavior
    New.behaviors[ Table.CIRCLE1 ] = New.CircleBehavior
    New.behaviors[ Table.CIRCLE2 ] = New.CircleBehavior
    New.behaviors[ Table.LIMBMOVE ] = New.LimbMoveBehavior
    New.behaviors[ Table.SMART_CIRCLE ] = New.SmartCircleBehavior
    New.behaviors[ Table.CHAR_OUTLINE ] = New.CharacterOutlineBehavior
    New.mode = Table.SMART_CIRCLE
    New.behaviorFunction = New.SmartCircleBehavior
    New.savedHits = { }
    New.trackedLimbs = { }
    New.camera = game.Workspace.CurrentCamera
    New.enabled = false
    return New
end
function Self.Enable( Self, Enabled )
    Self.enabled = Enabled

    if not Enabled then
        Self:Cleanup( )
    end
end
function Self.GetOcclusionMode( Argument1 )
    return Enum.DevCameraOcclusionMode.Invisicam
end
function Self.LimbBehavior( Argument1, List )
    for Value in pairs( Argument1.trackedLimbs ) do
        List[ #List + 1 ] = Value.Position
    end
end
function Self.MoveBehavior( Argument1, List )
    local I = 1

    for I = 1, 3 do
        local Position = Argument1.humanoidRootPart.Position
        local Velocity = Argument1.humanoidRootPart.Velocity
        local X = Velocity.X
        local Magnitude = Vector3.new( X, 0, Velocity.Z ).Magnitude / 2
        local Total = ( I - 1 ) * Argument1.humanoidRootPart.CFrame.lookVector * Magnitude
        List[ #List + 1 ] = Position + Total
    end
end
function Self.CornerBehavior( Argument1, List )
    local CFrame = Argument1.humanoidRootPart.CFrame
    local Position = CFrame.Position
    local CFrame2 = CFrame - Position
    local ExtentsSize = Argument1.char:GetExtentsSize( ) / 2
    List[ #List + 1 ] = Position
    local Count = #Table3
    local I = 1

    for I = 1, Count do
        List[ #List + 1 ] = Position + CFrame2 * ( ExtentsSize * Table3[ I ] )
    end
end
function Self.CircleBehavior( Argument1, List )
    local CFrame

    if Argument1.mode == Table.CIRCLE1 then
        CFrame = Argument1.humanoidRootPart.CFrame
    else
        local CoordinateFrame = Argument1.camera.CoordinateFrame
        CFrame = CoordinateFrame - CoordinateFrame.Position + Argument1.humanoidRootPart.Position
    end

    List[ #List + 1 ] = CFrame.Position
    local I = 0

    for I = 0, 9 do
        local Result = 0.6283185307179586 * I
        local Cos = math.cos( Result )
        local Vector32 = Vector3.new( Cos, math.sin( Result ), 0 ) * 3
        List[ #List + 1 ] = CFrame * Vector32
    end
end
function Self.LimbMoveBehavior( Self, Argument2 )
    Self:LimbBehavior( Argument2 )
    Self:MoveBehavior( Argument2 )
end
function Self.CharacterOutlineBehavior( Argument1, List )
    local Unit = Argument1.torsoPart.CFrame.upVector.unit
    local Unit2 = Argument1.torsoPart.CFrame.rightVector.unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position + Unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position - Unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position + Unit2
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position - Unit2

    if Argument1.headPart then
        List[ #List + 1 ] = Argument1.headPart.CFrame.Position
    end

    local Position3
    local X = Argument1.camera.CoordinateFrame.lookVector.X
    local CFrame2 = CFrame.new( Vector3.new( 0, 0, 0 ), ( Vector3.new( X, 0, Argument1.camera.CoordinateFrame.lookVector.Z ) ) )

    if Argument1.torsoPart then
        local Position = Argument1.torsoPart.Position

        if Position then
            Position3 = Position
        else
            Position3 = Argument1.humanoidRootPart.Position
        end
    else
        Position3 = Argument1.humanoidRootPart.Position
    end

    local FilterDescendantsInstances = { Argument1.torsoPart }

    if Argument1.headPart then
        FilterDescendantsInstances[ #FilterDescendantsInstances + 1 ] = Argument1.headPart
    end

    local I = 1

    for I = 1, 24 do
        local Result = 6.283185307179586 * I / 24
        local Cos = math.cos( Result )
        local CFrame3 = CFrame2 * ( Vector3.new( Cos, math.sin( Result ), 0 ) * 3 )
        local X2 = CFrame3.X
        local Max = math.max( CFrame3.Y, -2.25 )
        local Vector32 = Vector3.new( X2, Max, CFrame3.Z )

        if UserFlag then
            RaycastParams3.FilterDescendantsInstances = FilterDescendantsInstances
            local Raycast = game.Workspace:Raycast( Position3 + Vector32, -3 * Vector32, RaycastParams3 )

            if Raycast then
                local Position2 = Raycast.Position
                List[ #List + 1 ] = Position2 + 0.2 * ( Position3 - Position2 ).unit
            end
        else
            local Ray2 = Ray.new( Position3 + Vector32, -3 * Vector32 )
            local FoundPartOnRayWithWhitelist, FoundPartOnRayWithWhitelist2 = game.Workspace:FindPartOnRayWithWhitelist( Ray2, FilterDescendantsInstances, false )

            if FoundPartOnRayWithWhitelist then
                List[ #List + 1 ] = FoundPartOnRayWithWhitelist2 + 0.2 * ( Position3 - FoundPartOnRayWithWhitelist2 ).unit
            end
        end
    end
end
function Self.SmartCircleBehavior( Argument1, List )
    local Unit = Argument1.torsoPart.CFrame.upVector.unit
    local Unit2 = Argument1.torsoPart.CFrame.rightVector.unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position + Unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position - Unit
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position + Unit2
    List[ #List + 1 ] = Argument1.torsoPart.CFrame.Position - Unit2

    if Argument1.headPart then
        List[ #List + 1 ] = Argument1.headPart.CFrame.Position
    end

    local Position2
    local CFrame = Argument1.camera.CFrame - Argument1.camera.CFrame.Position

    if Argument1.torsoPart then
        local Position = Argument1.torsoPart.Position

        if Position then
            Position2 = Position
        else
            Position2 = Argument1.humanoidRootPart.Position
        end
    else
        Position2 = Argument1.humanoidRootPart.Position
    end

    local Position3 = Vector3.new( 0, 0.5, 0 ) + Position2
    local I = 1

    for I = 1, 24 do
        local Result = 0.2617993877991494 * I - 1.5707963267948966
        local Cos = math.cos( Result )
        local Position4 = Position3 + CFrame * ( Vector3.new( Cos, math.sin( Result ), 0 ) * 2.5 )
        local Position5 = Position4 - Argument1.camera.CFrame.Position

        if UserFlag then
            local Position9
            RaycastParams2.FilterDescendantsInstances = { Argument1.char }
            local Workspace = game.Workspace
            local Raycast = Workspace:Raycast( Position3, Position4 - Position3, RaycastParams2 )

            if Raycast then
                local Position6 = Raycast.Position
                local Normal = Raycast.Normal
                local Position7 = Position6 + 0.1 * Normal.unit
                local Position8 = Position7 - Position3
                local Unit3 = Position8:Cross( Position5 ).unit:Cross( Normal ).unit
                local Unit4 = ( Position7 - Argument1.camera.CFrame.Position ).unit

                if Position8.unit:Dot( -Unit3 ) < Position8.unit:Dot( Unit4 ) then
                    local RayIntersection2 = RayIntersection( Position7, Unit3, Position4, Position5 )

                    if RayIntersection2.Magnitude > 0 then
                        local Workspace2 = game.Workspace
                        local Raycast2 = Workspace2:Raycast( Position7, RayIntersection2 - Position7, RaycastParams2 )

                        if Raycast2 then
                            Position9 = Raycast2.Position + 0.1 * Raycast2.Normal.Unit
                        else
                            Position9 = RayIntersection2
                        end
                    else
                        Position9 = Position7
                    end
                else
                    Position9 = Position7
                end

                local Workspace3 = game.Workspace
                local Raycast3 = Workspace3:Raycast( Position3, Position9 - Position3, RaycastParams2 )

                if Raycast3 then
                    Position9 = Raycast3.Position - 0.1 * ( Position9 - Position3 ).unit
                end
            else
                Position9 = Position4
            end

            List[ #List + 1 ] = Position9
        else
            local FoundPartOnRayWithIgnoreList25
            local Ray2 = Ray.new( Position3, Position4 - Position3 )
            local Workspace4 = game.Workspace
            local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList3 = Workspace4:FindPartOnRayWithIgnoreList( Ray2, { Argument1.char }, false, false )

            if FoundPartOnRayWithIgnoreList then
                local FoundPartOnRayWithIgnoreList22 = FoundPartOnRayWithIgnoreList2 + 0.1 * FoundPartOnRayWithIgnoreList3.unit
                local FoundPartOnRayWithIgnoreList23 = FoundPartOnRayWithIgnoreList22 - Position3
                local Unit5 = FoundPartOnRayWithIgnoreList23:Cross( Position5 ).unit:Cross( FoundPartOnRayWithIgnoreList3 ).unit
                local Unit6 = ( FoundPartOnRayWithIgnoreList22 - Argument1.camera.CFrame.Position ).unit

                if FoundPartOnRayWithIgnoreList23.unit:Dot( -Unit5 ) < FoundPartOnRayWithIgnoreList23.unit:Dot( Unit6 ) then
                    local RayIntersection3 = RayIntersection( FoundPartOnRayWithIgnoreList22, Unit5, Position4, Position5 )

                    if RayIntersection3.Magnitude > 0 then
                        local Ray3 = Ray.new( FoundPartOnRayWithIgnoreList22, RayIntersection3 - FoundPartOnRayWithIgnoreList22 )
                        local Workspace5 = game.Workspace
                        local FoundPartOnRayWithIgnoreList4, FoundPartOnRayWithIgnoreList24, FoundPartOnRayWithIgnoreList32 = Workspace5:FindPartOnRayWithIgnoreList( Ray3, { Argument1.char }, false, false )

                        if FoundPartOnRayWithIgnoreList4 then
                            FoundPartOnRayWithIgnoreList25 = FoundPartOnRayWithIgnoreList24 + 0.1 * FoundPartOnRayWithIgnoreList32.unit
                        else
                            FoundPartOnRayWithIgnoreList25 = RayIntersection3
                        end
                    else
                        FoundPartOnRayWithIgnoreList25 = FoundPartOnRayWithIgnoreList22
                    end
                else
                    FoundPartOnRayWithIgnoreList25 = FoundPartOnRayWithIgnoreList22
                end

                local Ray4 = Ray.new( Position3, FoundPartOnRayWithIgnoreList25 - Position3 )
                local Workspace6 = game.Workspace
                local FoundPartOnRayWithIgnoreList5, FoundPartOnRayWithIgnoreList26 = Workspace6:FindPartOnRayWithIgnoreList( Ray4, { Argument1.char }, false, false )

                if FoundPartOnRayWithIgnoreList5 then
                    FoundPartOnRayWithIgnoreList25 = FoundPartOnRayWithIgnoreList26 - 0.1 * ( FoundPartOnRayWithIgnoreList25 - Position3 ).unit
                end
            else
                FoundPartOnRayWithIgnoreList25 = Position4
            end

            List[ #List + 1 ] = FoundPartOnRayWithIgnoreList25
        end
    end
end
function Self.CheckTorsoReference( Argument1 )
    if Argument1.char then
        Argument1.torsoPart = Argument1.char:FindFirstChild( "Torso" )

        if not Argument1.torsoPart then
            Argument1.torsoPart = Argument1.char:FindFirstChild( "UpperTorso" )

            if not Argument1.torsoPart then
                Argument1.torsoPart = Argument1.char:FindFirstChild( "HumanoidRootPart" )
            end
        end

        Argument1.headPart = Argument1.char:FindFirstChild( "Head" )
    end
end
function Self.CharacterAdded( Argument1, Char, Argument3 )
    if Argument3 ~= Players.LocalPlayer then
        return
    end
    if Argument1.childAddedConn then
        Argument1.childAddedConn:Disconnect( )
        Argument1.childAddedConn = nil
    end
    if Argument1.childRemovedConn then
        Argument1.childRemovedConn:Disconnect( )
        Argument1.childRemovedConn = nil
    end

    Argument1.char = Char
    Argument1.trackedLimbs = { }

    local function ChildAdded( TorsoPart )
        if TorsoPart:IsA( "BasePart" ) then
            if Table2[ TorsoPart.Name ] then
                Argument1.trackedLimbs[ TorsoPart ] = true
            end
            if TorsoPart.Name == "Torso" or TorsoPart.Name == "UpperTorso" then
                Argument1.torsoPart = TorsoPart
            end
            if TorsoPart.Name == "Head" then
                Argument1.headPart = TorsoPart
            end
        end
    end

    local function ChildRemoved( Key )
        Argument1.trackedLimbs[ Key ] = nil
        Argument1:CheckTorsoReference( )
    end

    Argument1.childAddedConn = Char.ChildAdded:Connect( ChildAdded )
    Argument1.childRemovedConn = Char.ChildRemoved:Connect( ChildRemoved )

    for Key, Value in pairs( Argument1.char:GetChildren( ) ) do
        if Value:IsA( "BasePart" ) then
            if Table2[ Value.Name ] then
                Argument1.trackedLimbs[ Value ] = true
            end
            if Value.Name == "Torso" or Value.Name == "UpperTorso" then
                Argument1.torsoPart = Value
            end
            if Value.Name == "Head" then
                Argument1.headPart = Value
            end
        end
    end
end
function Self.SetMode( Argument1, Mode )
    AssertTypes( Mode, "number" )

    for Key, Value in pairs( Table ) do
        if Value == Mode then
            Argument1.mode = Mode
            Argument1.behaviorFunction = Argument1.behaviors[ Argument1.mode ]
            return
        end
    end

    error( "Invalid mode number" )
end
function Self.GetObscuredParts( Argument1 )
    return Argument1.savedHits
end
function Self.Cleanup( Argument1 )
    for Key, Value in pairs( Argument1.savedHits ) do
        Key.LocalTransparencyModifier = Value
    end
end
function Self.Update( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local EngineInterface = Argument5.engineInterface
    local Player = EngineInterface.player
    local Character = EngineInterface.character

    if UserFlag2 and EngineInterface.characterChanged and Player and Character then
        Argument1:CharacterAdded( Character, Player )
    end
    if not Argument1.enabled or not Argument1.char then
        return Argument3, Argument4
    end

    Argument1.camera = game.Workspace.CurrentCamera

    if not Argument1.humanoidRootPart then
        local Humanoid = Argument1.char:FindFirstChildOfClass( "Humanoid" )

        if not Humanoid or not Humanoid.RootPart then
            Argument1.humanoidRootPart = Argument1.char:FindFirstChild( "HumanoidRootPart" )

            if not Argument1.humanoidRootPart then
                return Argument3, Argument4
            end
        else
            Argument1.humanoidRootPart = Humanoid.RootPart
        end

        local Connect = nil
        Connect = Argument1.humanoidRootPart.AncestryChanged:Connect( function( Argument1Inner, Argument2 )
            if Argument1Inner == Argument1.humanoidRootPart and not Argument2 then
                Argument1.humanoidRootPart = nil

                if Connect and Connect.Connected then
                    Connect:Disconnect( )
                    Connect = nil
                end
            end
        end )
    end
    if not Argument1.torsoPart then
        Argument1:CheckTorsoReference( )

        if not Argument1.torsoPart then
            return Argument3, Argument4
        end
    end

    local Position3
    local Table = { }
    Argument1.behaviorFunction( Argument1, Table )
    local Table2 = { }
    local Table3 = { Argument1.char }

    local function Add( Key )
        Table2[ Key ] = true

        if not Argument1.savedHits[ Key ] then
            local SavedHits = Argument1.savedHits
            SavedHits[ Key ] = Key.LocalTransparencyModifier
        end
    end

    local Table4 = { }

    if Argument1.headPart then
        local Position = Argument1.headPart.CFrame.Position

        if Position then
            Position3 = Position
        else
            Position3 = Table[ 1 ]
        end
    else
        Position3 = Table[ 1 ]
    end

    local Position4

    if Argument1.torsoPart then
        local Position2 = Argument1.torsoPart.CFrame.Position

        if Position2 then
            Position4 = Position2
        else
            Position4 = Table[ 2 ]
        end
    else
        Position4 = Table[ 2 ]
    end

    local Number
    local PartsObscuringTarget = Argument1.camera:GetPartsObscuringTarget( { Position3, Position4 }, Table3 )
    local Count = #PartsObscuringTarget
    local I = 1
    Number = 0

    for I = 1, Count do
        local Entry = PartsObscuringTarget[ I ]
        local Number2 = Number + 1
        Table4[ Entry ] = true

        for Key, Value in pairs( Entry:GetChildren( ) ) do
            if not Value:IsA( "Decal" ) then
                if not Value:IsA( "Texture" ) then
                    continue
                end
            end

            Number = Number2 + 1
            break
        end
    end

    local Pow, Pow2

    if Number > 0 then
        local Number3 = 0.375 / Number + 0.375
        Pow = math.pow( Number3, 1 / Number )
        local Number4 = 0.25 / Number + 0.25
        Pow2 = math.pow( Number4, 1 / Number )
    else
        Pow = 0.75
        Pow2 = 0.75
    end

    local PartsObscuringTarget2 = Argument1.camera:GetPartsObscuringTarget( Table, Table3 )
    local Table5 = { }
    local Count2 = #PartsObscuringTarget2
    local I2 = 1

    for I2 = 1, Count2 do
        local Number5
        local Entry2 = PartsObscuringTarget2[ I2 ]
        Number5 = if not Table4[ Entry2 ] or not Pow then Pow2 else Pow
        Table5[ Entry2 ] = Number5

        if Entry2.Transparency < Table5[ Entry2 ] then
            Table2[ Entry2 ] = true

            if not Argument1.savedHits[ Entry2 ] then
                local SavedHits = Argument1.savedHits
                SavedHits[ Entry2 ] = Entry2.LocalTransparencyModifier
            end
        end
        for Key2, Value3 in pairs( Entry2:GetChildren( ) ) do
            if Value3:IsA( "Decal" ) or Value3:IsA( "Texture" ) then
                if Value3.Transparency < Table5[ Entry2 ] then
                    Table5[ Value3 ] = Table5[ Entry2 ]
                    Table2[ Value3 ] = true

                    if not Argument1.savedHits[ Value3 ] then
                        local SavedHits2 = Argument1.savedHits
                        SavedHits2[ Value3 ] = Value3.LocalTransparencyModifier
                    end
                end
            end
        end
    end
    for Key3, Value5 in pairs( Argument1.savedHits ) do
        if Table2[ Key3 ] then
            local LocalTransparencyModifier

            if Key3.Transparency < 1 then
                local Entry3 = ( Table5[ Key3 ] - Key3.Transparency ) / ( 1 - Key3.Transparency )

                if Entry3 then
                    LocalTransparencyModifier = Entry3
                else
                    LocalTransparencyModifier = 0
                end
            else
                LocalTransparencyModifier = 0
            end

            Key3.LocalTransparencyModifier = LocalTransparencyModifier
        else
            Key3.LocalTransparencyModifier = Value5
            Argument1.savedHits[ Key3 ] = nil
        end
    end

    return Argument3, Argument4
end
return Self
