-- Players.perkbrokeyou.PlayerScripts.DamageNumbersClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local HeadColor2
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local Remotes = ReplicatedStorage:WaitForChild( "Remotes" )
local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )
local Class = setmetatable( { }, { __mode = "k" } )
local DamageNumber = game:GetService( "StarterGui" ):WaitForChild( "WorldUI" ):WaitForChild( "DamageNumber" )
local Text = DamageNumber:WaitForChild( "Text" )
local HeadColor = Text:GetAttribute( "HeadColor" )
HeadColor2 = if HeadColor then HeadColor else Color3.fromRGB( 255, 214, 64 )
local ArmorColor2
local ArmorColor = Text:GetAttribute( "ArmorColor" )
ArmorColor2 = if ArmorColor then ArmorColor else Color3.fromRGB( 70, 160, 255 )
local Size = Text.Size
local Random2 = Random.new( )
local Folder = Instance.new( "Folder" )
Folder.Name = "DamageNumbers"
Folder.Parent = workspace.CurrentCamera

local function NextAngle( AngleName )
    local Entry2
    local Clock = os.clock( )
    local Entry = Class[ AngleName ]
    Entry2 = if Entry then Entry else { }
    Class[ AngleName ] = Entry2
    local Count = #Entry2
    local I = Count

    for I = Count, 1, -1 do
        if Entry2[ I ][ 2 ] <= Clock then
            table.remove( Entry2, I )
        end
    end

    local Number2, Number3
    local I2 = 1
    Number2 = -1
    Number3 = 0

    for I2 = 1, 12 do
        local Value1, Number
        local NextNumber = Random2:NextNumber( -45, 45 )
        Value1 = nil
        Number = math.huge

        for Key, Value in Entry2, nil, nil do
            Number = math.min( Number, ( math.abs( NextNumber - Value[ 1 ] ) ) )
        end
        if Number2 < Number then
            Number2 = Number
            Number3 = NextNumber
        end
    end

    table.insert( Entry2, { Number3, Clock + 0.7 } )
    return ( math.rad( Number3 ) )
end

local function Show( HitPos, Amount, Flag, AngleName, TextColor3 )
    local Unit
    local Adornee = Instance.new( "Part" )
    Adornee.Name = "DamageNumberAnchor"
    Adornee.Anchored = true
    Adornee.CanCollide = false
    Adornee.CanQuery = false
    Adornee.CanTouch = false
    Adornee.Transparency = 1
    Adornee.Size = Vector3.new( 0.10000000149011612, 0.10000000149011612, 0.10000000149011612 )
    local CFrame2 = workspace.CurrentCamera.CFrame
    local X = CFrame2.RightVector.X
    local Vector32 = Vector3.new( X, 0, CFrame2.RightVector.Z )
    Unit = Vector32.Magnitude > 0.01 and Vector32.Unit or Vector3.new( 1, 0, 0 )
    local HumanoidRootPart

    if AngleName then
        local Head = AngleName:FindFirstChild( "Head" )

        if Head then
            HumanoidRootPart = Head
        else
            HumanoidRootPart = AngleName:FindFirstChild( "HumanoidRootPart" )
        end
    else
        HumanoidRootPart = AngleName
    end

    local Position

    if HumanoidRootPart then
        local NextAngle2 = NextAngle( AngleName )
        local Clamp = math.clamp( ( CFrame2.Position - HumanoidRootPart.Position ).Magnitude * 0.075, 1.3, 30 ) * Random2:NextNumber( 0.9, 1.15 )
        Position = HumanoidRootPart.Position + Vector3.new( 0, -0.4000000059604645, 0 ) + Unit * ( math.sin( NextAngle2 ) * Clamp * 0.6 ) + Vector3.new( 0, 1, 0 ) * ( math.cos( NextAngle2 ) * Clamp )
    else
        local NextNumber = Random2:NextNumber( -0.35, 0.35 )
        Position = HitPos + Vector3.new( NextNumber, 2.2, Random2:NextNumber( -0.35, 0.35 ) )
    end

    local Unit3
    local Position2 = CFrame2.Position - Position

    if Position2.Magnitude > 0.01 then
        local Unit2 = Position2.Unit * math.min( 1.5, Position2.Magnitude * 0.5 )

        if Unit2 then
            Unit3 = Unit2
        else
            Unit3 = Vector3.new( 0, 0, 0 )
        end
    else
        Unit3 = Vector3.new( 0, 0, 0 )
    end

    Adornee.CFrame = CFrame.new( Position + Unit3 )
    Adornee.Parent = Folder
    local Clone = DamageNumber:Clone( )
    Clone.Adornee = Adornee
    Clone.Enabled = true
    local Text = Clone:WaitForChild( "Text" )
    local Scale = Size.X.Scale * 0.6
    Text.Size = UDim2.new( Scale, 0, Size.Y.Scale * 0.6, 0 )
    Text.Text = tostring( ( math.floor( Amount + 0.5 ) ) )

    if TextColor3 or Flag then
        Text.TextColor3 = TextColor3 or HeadColor2
    end

    Clone.Parent = PlayerGui
    TweenService:Create( Text, TweenInfo.new( 0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Size = Size } ):Play( )
    task.delay( 0.5499999999999999, function()
        if Text.Parent then
            TweenService:Create( Text, TweenInfo.new( 0.15 ), { TextTransparency = 1, TextStrokeTransparency = 1 } ):Play( )
            return
        end
        return
    end )
    task.delay( 0.7, function()
        Clone:Destroy( )
        Adornee:Destroy( )
    end )
end

local function ShowDamageNumber( Argument1 )
    if type( Argument1 ) ~= "table" or typeof( Argument1.HitPos ) ~= "Vector3" or type( Argument1.Damage ) ~= "number" then
        return
    end
    if Argument1.Damage <= 0 then
        return
    end

    local Target = typeof( Argument1.Target ) == "Instance" and Argument1.Target:IsA( "Model" ) and Argument1.Target or nil
    local Clamp2

    if type( Argument1.Armor ) == "number" then
        local Armor = Argument1.Armor
        local Clamp = math.clamp( Armor, 0, Argument1.Damage )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 0
        end
    else
        Clamp2 = 0
    end
    if Clamp2 > 0 then
        Show( Argument1.HitPos, Clamp2, false, Target, ArmorColor2 )
    end
    if Argument1.Damage - Clamp2 > 0.5 then
        local Flag
        local HitPos = Argument1.HitPos
        local Damage = Argument1.Damage - Clamp2
        Flag = Argument1.Headshot == true and true or false
        Show( HitPos, Damage, Flag, Target )
    end
end

Remotes:WaitForChild( "Hit" ).OnClientEvent:Connect( ShowDamageNumber )
require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) ).ShowDamageNumber = ShowDamageNumber
