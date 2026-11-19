-- StarterPlayer.StarterPlayerScripts.CameraClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value4
local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local IsStudio = RunService:IsStudio( )
local UserGameSettings = UserSettings( ):GetService( "UserGameSettings" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Config = require( Weapons:WaitForChild( "Config" ) )
local ClientState = require( Weapons:WaitForChild( "ClientState" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local AimAssist = require( Weapons:WaitForChild( "AimAssist" ) )
local Camera = Config.Global.Camera
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local Vector22 = Vector2.new( 0.006283185307179587, 0.00471238898038469 )
local Vector23 = Vector2.new( 4.725, 2.25 )
local Vector24 = Vector2.new( 0.008727, 0.00672 )
local Zero = Vector2.zero
UserInputService.InputChanged:Connect( function( Argument1 )
    if Argument1.UserInputType == Enum.UserInputType.MouseMovement then
        Zero = Zero + Vector2.new( Argument1.Delta.X, Argument1.Delta.Y )
    end
end )

local function TakeMouse()
    Zero = Vector2.zero
    return Zero
end

local function MouseRadians( Argument1 )
    return Argument1 * Vector24
end

local Rad = math.rad( Camera.MinPitch )
local Rad2 = math.rad( Camera.MaxPitch )
local Number = 0
local Number2 = -0.20943951023931956
local Distance = Camera.Distance
local Side = Camera.Side
local Height = Camera.Height
local HipFOV = Config.Global.HipFOV
local Value1 = nil
local Number3 = 0
local Value2 = nil
local ScopeEye = require( Weapons:WaitForChild( "ScopeEye" ) )
local Number4 = 0
local ClientHitboxes = require( Weapons:WaitForChild( "ClientHitboxes" ) )
local VehicleSurface = require( Weapons:WaitForChild( "VehicleSurface" ) )
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.CollisionGroup = "Default"

local function AimedPoint( PointName, Argument2 )
    local CFrame = CurrentCamera.CFrame
    local FilterDescendantsInstances = { PointName }
    local FX = workspace:FindFirstChild( "FX" )
    local Entry = ClientHitboxes.folders[ PointName ]

    if FX then
        table.insert( FilterDescendantsInstances, FX )
    end
    if Entry then
        table.insert( FilterDescendantsInstances, Entry )
    end

    local Vehicle2
    local Vehicle = ClientState.Vehicle
    Vehicle2 = if Vehicle then ClientState.Vehicle.Model else Vehicle

    if Vehicle2 then
        table.insert( FilterDescendantsInstances, Vehicle2 )
    end

    local Children
    local Find = WorldRefs.Find( "Cars" )
    Children = Find and Find:GetChildren( ) or { }
    local Value1 = nil

    for Key, Value in Children, nil, nil do
        for Key2, Value2 in Value:GetChildren( ) do
            if Value2:IsA( "BasePart" ) and Value2.Name:sub( 1, 6 ) == "Armor_" then
                table.insert( FilterDescendantsInstances, Value2 )
            end
        end
    end

    local Max2
    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Head = PointName:FindFirstChild( "Head" )
    local LookVector = CFrame.LookVector
    local Position = CFrame.Position

    if Head then
        local Max = math.max( 0, ( Head.Position - CFrame.Position ):Dot( LookVector ) )

        if Max then
            Max2 = Max
        else
            Max2 = 0
        end
    else
        Max2 = 0
    end

    local Position2 = Position + LookVector * Max2
    local ClientHitboxesInner = workspace:FindFirstChild( "ClientHitboxes" )

    if ClientHitboxesInner then
        table.insert( FilterDescendantsInstances, ClientHitboxesInner )
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Position2, LookVector * 2000, RaycastParams2 )
    local I = 1

    for I = 1, 8 do
        if not Raycast or not ( Raycast.Instance.Transparency >= 0.95 ) then
            break
        end

        table.insert( FilterDescendantsInstances, Raycast.Instance )
        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
        Raycast = workspace:Raycast( Position2, LookVector * 2000, RaycastParams2 )
    end

    local Position3

    if not Raycast or not Raycast.Position then
        Position3 = Position2 + LookVector * 2000
    else
        Position3 = Raycast.Position
    end

    local Raycast2, _, Raycast3 = VehicleSurface.Raycast( Position2, LookVector, 2000, Vehicle2 )

    if Raycast2 and Raycast3 < ( Position3 - Position2 ).Magnitude then
        Position3 = Raycast2
    end
    if Argument2 then
        local Spherecast = workspace:Spherecast( Position2, Argument2, LookVector * math.min( ( Position3 - Position2 ).Magnitude, 1000 ), RaycastParams2 )

        if Spherecast then
            Position3 = Position2 + LookVector * math.max( 0, ( Spherecast.Position - Position2 ):Dot( LookVector ) )
        end
    end

    return Position3
end

local Value3 = nil
local Flag = false
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.IgnoreWater = true
RaycastParams3.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams3.RespectCanCollide = true
local Flag2 = false
local Flag3 = false
local Number5 = -1
local Number6 = 0
local Table = {
    "BetaNotice",
    "GenderChoice",
    "ModNotice",
    "Armory",
    "Inventory",
    "SettingsMenu",
    "EffectsMenu",
    "ModEditor",
    "Wardrobe",
    "PlayerProfile",
    "ControlsMenu",
    "CaseMenu",
    "VehicleCrateMenu",
    "VehicleCrateFXLive",
    "CaseFXLive",
    "DanceMenu",
    "EmoteWheel",
    "CarLiftMenu",
    "Stash",
    "ItemShop",
    "ATM",
    "Pawn",
    "CommunityPack",
    "ShopMenu",
    "CrewMenu"
}
local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local Flag4 = false
local Table2 = { }
local Table3 = { }
Value4 = nil

for Key, Value in Table, nil, nil do
    Table3[ Value ] = true
end

local Value5 = nil
local Class = setmetatable( { }, { __mode = "k" } )
local Number7 = 0

local function AnyMenuOpen()
    if ClientState.CaseRolling then
        Number7 = os.clock( ) + 1
        return true
    end
    if os.clock( ) < Number7 then
        return true
    end
    if Value5 == nil or Value5.Parent ~= LocalPlayer then
        local PlayerGui = LocalPlayer:FindFirstChild( "PlayerGui" )

        if not PlayerGui then
            return false
        end

        Value5 = PlayerGui
        table.clear( Table2 )

        local function Forget( Self )
            if Table3[ Self.Name ] then
                Table2[ Self.Name ] = nil
            end

            local Screen = Self:GetAttribute( "Screen" )

            if Screen and Table3[ Screen ] then
                Table2[ Screen ] = nil
            end
        end

        PlayerGui.DescendantAdded:Connect( Forget )
        PlayerGui.DescendantRemoving:Connect( Forget )
    end

    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Entry2
        local Entry = Table2[ Value ]

        if Entry == nil then
            local Find = Screens.Find( Value, Value5 ) or false
            Table2[ Value ] = Find
            Entry2 = Find
        else
            Entry2 = Entry
        end
        if Entry2 and Screens.IsShown( Entry2 ) then
            local Entry4

            if Value == "Inventory" then
                local Entry3 = Class[ Entry2 ]

                if not Entry3 or Entry3.Parent ~= Entry2 then
                    local Window = Entry2:FindFirstChild( "Window" )
                    Class[ Entry2 ] = Window
                    Entry4 = Window
                else
                    Entry4 = Entry3
                end
            else
                Entry4 = nil
            end
            if Entry4 then
                if not Entry4.Visible then
                    continue
                end
            end

            return true
        end
    end

    return false
end

local function IsCursorKey( Argument1 )
    local Is

    if Argument1.UserInputType == Enum.UserInputType.Keyboard then
        Is = Controls.Is( "CursorMode", Argument1 )
    else
        Is = false
    end

    return Is
end

UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
    local Is

    if Argument1.UserInputType == Enum.UserInputType.Keyboard then
        Is = Controls.Is( "CursorMode", Argument1 )
    else
        Is = false
    end
    if Is and not UserInputService:GetFocusedTextBox( ) and not ClientState.CursorFree then
        ClientState.CursorFree = "alt"
        Flag2 = true
        Number6 = 2
    end
end )
UserInputService.InputEnded:Connect( function( Argument1 )
    local Is

    if Argument1.UserInputType == Enum.UserInputType.Keyboard then
        Is = Controls.Is( "CursorMode", Argument1 )
    else
        Is = false
    end
    if Is and Flag2 then
        Flag2 = false

        if ClientState.CursorFree == "alt" then
            ClientState.CursorFree = false
        end
    end
end )

local function Approach( Argument1, Argument2, Argument3, Argument4 )
    return Argument1 + ( Argument2 - Argument1 ) * ( 1 - math.exp( -Argument3 * Argument4 ) )
end

local function AngleDiff( Argument1, Argument2 )
    return ( Argument2 - Argument1 + 3.141592653589793 ) % 6.283185307179586 - 3.141592653589793
end

local Number8 = 0
local Value6 = nil
local Number9 = 17
local Flag5 = false
local Number10 = 0
local Value7 = nil
local Value8 = nil
local Value9 = nil

local function KeepOutOfCar( Argument1, Argument2 )
    if not ( Argument2 and Argument2.Root ) or not ( Argument2 and Argument2.Root ).Parent or not Argument2.Model then
        return Argument1
    end
    if not Value9 or Value9.model ~= Argument2.Model then
        local BoundingBox, BoundingBox2 = Argument2.Model:GetBoundingBox( )
        Value9 = {
            model = Argument2.Model,
            off = ( Argument2 and Argument2.Root ).CFrame:ToObjectSpace( BoundingBox ),
            half = BoundingBox2 / 2 + Vector3.new( 0.6000000238418579, 0.6000000238418579, 0.6000000238418579 )
        }
    end

    local CFrame = ( Argument2 and Argument2.Root ).CFrame * Value9.off
    local PointToObjectSpace = CFrame:PointToObjectSpace( Argument1 )
    local Half = Value9.half

    if not ( math.abs( PointToObjectSpace.X ) < Half.X ) or not ( math.abs( PointToObjectSpace.Z ) < Half.Z ) or not ( PointToObjectSpace.Y < Half.Y ) or not ( -Half.Y - 4 < PointToObjectSpace.Y ) then
        return Argument1
    end
    local X = PointToObjectSpace.X
    local Y = Half.Y
    return CFrame:PointToWorldSpace( ( Vector3.new( X, Y, PointToObjectSpace.Z ) ) )
end

local Number11 = 0
local Number12 = 1

local function Finite( Amount )
    local Flag

    if Amount == Amount then
        if Amount == math.huge then
            Flag = false
        elseif Amount == -math.huge then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    return Flag
end

local function FiniteV( Argument1 )
    local Flag
    local X = Argument1.X

    if X == X then
        if X == math.huge then
            Flag = false
        elseif X == -math.huge then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
    if Flag then
        local Y = Argument1.Y

        if Y == Y then
            if Y == math.huge then
                Flag = false
            elseif Y == -math.huge then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag then
            local Z = Argument1.Z

            if Z == Z then
                if Z == math.huge then
                    Flag = false
                elseif Z == -math.huge then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
        end
    end

    return Flag
end

local Table4 = { }

local function NanFrom( FromName )
    if Table4[ FromName ] then
        return
    end
    Table4[ FromName ] = true
    warn( "[CameraClient] valeur non finie (NaN) venant de : " .. FromName .. " -> ignorée, caméra conservée" )
    return
end

local function ClearDistance( Argument1, Argument2, Amount )
    local Flag
    local X = Argument1.X

    if X == X then
        if X == math.huge then
            Flag = false
        elseif X == -math.huge then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
    if Flag then
        local Y = Argument1.Y

        if Y == Y then
            if Y == math.huge then
                Flag = false
            elseif Y == -math.huge then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag then
            local Z = Argument1.Z

            if Z == Z then
                if Z == math.huge then
                    Flag = false
                elseif Z == -math.huge then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
        end
    end
    if Flag then
        local Flag2
        local X2 = Argument2.X

        if X2 == X2 then
            if X2 == math.huge then
                Flag2 = false
            elseif X2 == -math.huge then
                Flag2 = false
            else
                Flag2 = true
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Y2 = Argument2.Y

            if Y2 == Y2 then
                if Y2 == math.huge then
                    Flag2 = false
                elseif Y2 == -math.huge then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = false
            end
            if Flag2 then
                local Z2 = Argument2.Z

                if Z2 == Z2 then
                    if Z2 == math.huge then
                        Flag2 = false
                    elseif Z2 == -math.huge then
                        Flag2 = false
                    else
                        Flag2 = true
                    end
                else
                    Flag2 = false
                end
            end
        end
        if Flag2 then
            local Flag3

            if Amount == Amount then
                if Amount == math.huge then
                    Flag3 = false
                elseif Amount == -math.huge then
                    Flag3 = false
                else
                    Flag3 = true
                end
            else
                Flag3 = false
            end
            if Flag3 then
                local Max2
                local Spherecast = workspace:Spherecast( Argument1, 0.35, Argument2 * Amount, RaycastParams3 )

                if Spherecast then
                    local Max = math.max( Spherecast.Distance - 0.1, 0 )

                    if Max then
                        Max2 = Max
                    else
                        Max2 = Amount
                    end
                else
                    Max2 = Amount
                end

                return Max2
            end
        end
    end
    if not Table4.clearDistance then
        Table4.clearDistance = true
        warn( "[CameraClient] valeur non finie (NaN) venant de : clearDistance -> ignorée, caméra conservée" )
    end

    return 0
end

local function OnCharacter( Object )
    local _, ToOrientation2 = Object:WaitForChild( "HumanoidRootPart" ).CFrame:ToOrientation( )
    Number = ToOrientation2
    Number2 = -0.20943951023931956
end

LocalPlayer.CharacterAdded:Connect( OnCharacter )

if LocalPlayer.Character then
    task.spawn( OnCharacter, LocalPlayer.Character )
end

function ClientState.FaceCamera()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if HumanoidRootPart then
        local _, ToOrientation2 = HumanoidRootPart.CFrame:ToOrientation( )
        Number = ToOrientation2
        Number2 = -0.20943951023931956
        return
    end
    return
end
local Number13 = 0
local Number14 = -0.20943951023931956

local function CheckAngles( AnglesName )
    local Flag

    if Number == Number then
        if Number == math.huge then
            Flag = false
        elseif Number == -math.huge then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
    if Flag then
        local Flag2

        if Number2 == Number2 then
            if Number2 == math.huge then
                Flag2 = false
            elseif Number2 == -math.huge then
                Flag2 = false
            else
                Flag2 = true
            end
        else
            Flag2 = false
        end
        if Flag2 then
            Number13 = Number
            Number14 = Number2
            return
        end
    end
    if not Table4[ AnglesName ] then
        Table4[ AnglesName ] = true
        warn( "[CameraClient] valeur non finie (NaN) venant de : " .. AnglesName .. " -> ignorée, caméra conservée" )
    end

    Number = Number13
    Number2 = Number14
end

local Flag6 = false
local Number15 = 0
local Number16 = 0

local function AddRecoil( Argument1, Argument2 )
    if type( Argument1 ) == "number" and type( Argument2 ) == "number" and Argument1 == Argument1 and Argument2 == Argument2 then
        Number15 = Number15 + Argument1
        Number16 = Number16 + Argument2
    end

    return true
end

task.spawn( function()
    rawset( ClientState, ClientState.RecoilKey( ), AddRecoil )
end )
RunService:BindToRenderStep( "GTACamera", Enum.RenderPriority.Camera.Value, function( p1 )
    -- Could not structure function #22
end )

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.CameraMinZoomDistance = Upvalue2
]]
