-- Players.perkbrokeyou.PlayerScripts.HitboxClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local WorldRefs = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "WorldRefs" ) )
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local HitboxModel = require( Weapons:WaitForChild( "HitboxModel" ) )
local ClientHitboxes = require( Weapons:WaitForChild( "ClientHitboxes" ) )
local WeaponData = require( Weapons:WaitForChild( "WeaponData" ) )
local LocalPlayer = Players.LocalPlayer

local function MyScale()
    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local HitboxScale2

    if Character2 then
        local HitboxScale = Character2.Handling.HitboxScale

        if HitboxScale then
            HitboxScale2 = HitboxScale
        else
            HitboxScale2 = 1
        end
    else
        HitboxScale2 = 1
    end

    return HitboxScale2
end

local Folder = Instance.new( "Folder" )
Folder.Name = "ClientHitboxes"
Folder.Parent = workspace
local CFrame2 = CFrame.new( 0, -10000, 0 )

local function FolderFor( ForName )
    local Entry = ClientHitboxes.folders[ ForName ]

    if Entry and Entry.Parent then
        return Entry
    end

    local Value1
    local Parent = Instance.new( "Folder" )
    Parent.Name = ForName.Name
    local BOXES = HitboxModel.BOXES
    Value1 = nil

    for Key, Value in BOXES, nil, nil do
        local Part = Instance.new( "Part" )
        Part.Name = Value
        Part.Anchored = true
        Part.CanCollide = false
        Part.CanTouch = false
        Part.CanQuery = true
        Part.CastShadow = false
        Part.Transparency = 1
        Part.Material = Enum.Material.ForceField
        Part.Color = Color3.fromRGB( 255, 40, 40 )
        Part.CollisionGroup = "Hitbox"
        Part.Size = Vector3.new( 1, 1, 1 )
        Part.CFrame = CFrame2
        Part.Parent = Parent
        ClientHitboxes.parts[ Part ] = { char = ForName, name = Value }
    end

    Parent.Parent = Folder
    ClientHitboxes.folders[ ForName ] = Parent
    return Parent
end

local function Drop( Key )
    local Entry = ClientHitboxes.folders[ Key ]

    if Entry then
        for Key2, Value in Entry:GetChildren( ) do
            ClientHitboxes.parts[ Value ] = nil
        end

        Entry:Destroy( )
    end

    ClientHitboxes.folders[ Key ] = nil
end

local Table = { }
local Number = -math.huge

local function Refresh()
    local Clock = os.clock( )

    if Clock - Number < 0.002 then
        return
    end

    local Flag
    Number = Clock
    local ServerTimeNow = workspace:GetServerTimeNow( )
    Flag = workspace:GetAttribute( "ShowHitboxes" ) == true and true or false
    local Tool
    local Character = LocalPlayer.Character

    if Character then
        Tool = Character:FindFirstChildOfClass( "Tool" )
    else
        Tool = Character
    end

    local Character2 = if Tool then WeaponData[ Tool:GetAttribute( "Weapon" ) or "" ] else Tool
    local HitboxScale2

    if Character2 then
        local HitboxScale = Character2.Handling.HitboxScale

        if HitboxScale then
            HitboxScale2 = HitboxScale
        else
            HitboxScale2 = 1
        end
    else
        HitboxScale2 = 1
    end

    local TableInner = { }
    local Table2 = { }
    table.clear( Table )

    local function Place( ForName )
        local HumanoidRootPart = ForName:FindFirstChild( "HumanoidRootPart" )
        local Humanoid = ForName:FindFirstChildOfClass( "Humanoid" )

        if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
            return
        end

        local Compute
        Table[ ForName ] = true
        Compute = nil

        for Key2, Value in FolderFor( ForName ):GetChildren( ) do
            local BoxCF2, Size
            local FoundChild = ForName:FindFirstChild( Value.Name )

            if not FoundChild or not FoundChild:IsA( "BasePart" ) then
                local Compute3

                if Compute then
                    Compute3 = Compute
                else
                    local Compute2 = HitboxModel.Compute
                    Compute3 = Compute2( ForName, HumanoidRootPart.CFrame, HitboxModel.State( ForName ), ServerTimeNow )
                end

                local Entry = Compute3[ Value.Name ]

                if not Entry or Entry.reach then
                    Size = nil
                    BoxCF2 = nil
                    Compute = Compute3
                else
                    Size = Entry.size
                    BoxCF2 = Entry.cf
                    Compute = Compute3
                end
            else
                local BoxCF = HitboxModel.BoxCF
                local Name = Value.Name
                BoxCF2 = BoxCF( Name, FoundChild.CFrame, FoundChild )
                local SizeOf = HitboxModel.SizeOf
                Size = SizeOf( Value.Name, FoundChild )
            end
            if Size and ForName ~= LocalPlayer.Character then
                Size = Size * HitboxScale2
            end
            if Size and Value.Size ~= Size then
                Value.Size = Size
            end

            local Transparency = not Flag and 1 or 0.55

            if Value.Transparency ~= Transparency then
                Value.Transparency = Transparency
            end

            local BoxCF3
            table.insert( TableInner, Value )
            BoxCF3 = if BoxCF2 then BoxCF2 else CFrame2
            table.insert( Table2, BoxCF3 )
        end
    end

    for Key, Value in Players:GetPlayers( ) do
        local Character3 = Value.Character

        if Character3 then
            if Value ~= LocalPlayer or Flag then
                if Value == LocalPlayer or Value:GetAttribute( "InTutorial" ) == nil then
                    Place( Character3 )
                end
            end
        end
    end

    local Find = WorldRefs.Find( "Dummies" )

    if Find then
        for Key2, Value2 in Find:GetChildren( ) do
            if Value2:IsA( "Model" ) then
                Place( Value2 )
            end
        end
    end
    if #TableInner > 0 then
        workspace:BulkMoveTo( TableInner, Table2, Enum.BulkMoveMode.FireCFrameChanged )
    end

    local Value1
    local Folders = ClientHitboxes.folders
    Value1 = nil

    for Value3 in Folders, nil, nil do
        if not Table[ Value3 ] then
            local Entry = ClientHitboxes.folders[ Value3 ]

            if Entry then
                for Key3, Value4 in Entry:GetChildren( ) do
                    ClientHitboxes.parts[ Value4 ] = nil
                end

                Entry:Destroy( )
            end

            ClientHitboxes.folders[ Value3 ] = nil
        end
    end
end

ClientHitboxes.Refresh = Refresh
RunService:BindToRenderStep( "ClientHitboxes", Enum.RenderPriority.Camera.Value - 2, function()
    if workspace:GetAttribute( "ShowHitboxes" ) == true then
        Refresh( )
    end
end )
