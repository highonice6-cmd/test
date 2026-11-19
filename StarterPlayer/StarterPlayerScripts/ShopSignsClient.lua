-- StarterPlayer.StarterPlayerScripts.ShopSignsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CompassPOI
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local ShopSign = game:GetService( "StarterGui" ):WaitForChild( "WorldUI" ):WaitForChild( "ShopSign" )
local Zones = workspace:WaitForChild( "Zones", 30 )

if Zones then
    CompassPOI = Zones:WaitForChild( "CompassPOI", 30 )
else
    CompassPOI = Zones
end
if not CompassPOI then
    return
end

local Number = tonumber( ShopSign:GetAttribute( "Proche" ) ) or 25
local Table = { }

local function Add( Model )
    if Table[ Model ] or not Model:IsA( "Model" ) then
        return
    end

    local Adornee
    local Image = Model:GetAttribute( "Icon" )
    local Enseigne = Model:FindFirstChild( "Enseigne" )
    Adornee = if Enseigne then Enseigne else Model.PrimaryPart

    if type( Image ) ~= "string" or Image == "" or not Adornee or not Adornee:IsA( "BasePart" ) then
        return
    end

    local Clone = ShopSign:Clone( )
    Clone.Adornee = Adornee
    local MaxDistance = tonumber( Model:GetAttribute( "SignDistance" ) )

    if MaxDistance then
        Clone.MaxDistance = MaxDistance
    end
    if Model:GetAttribute( "Toujours" ) == true then
        Clone.MaxDistance = math.huge
        local Number = tonumber( ShopSign:GetAttribute( "ToujoursPx" ) ) or 56
        local Scale = Clone.Size.X.Scale
        local Number2 = Number * Clone.Size.X.Scale / Clone.Size.Y.Scale
        Clone.Size = UDim2.new( Scale, Number2, Clone.Size.Y.Scale, Number )
    end

    local Icon
    local Logo = Clone:FindFirstChild( "Logo" )

    if Logo then
        Icon = Logo:FindFirstChild( "Icon" )
    else
        Icon = Logo
    end
    if Icon and Icon:IsA( "ImageLabel" ) then
        Icon.Image = Image
    end

    local Nom = Clone:FindFirstChild( "Nom" )

    if Nom and Nom:IsA( "TextLabel" ) then
        local Text
        local Label = Model:GetAttribute( "Label" )
        Text = type( Label ) == "string" and Label or ""
        local Visible
        Nom.Text = Text
        Visible = Nom.Text ~= "" and true or false
        Nom.Visible = Visible
    end

    local ImageColor3 = Model:GetAttribute( "Couleur" )

    if typeof( ImageColor3 ) == "Color3" then
        if Icon and Icon:IsA( "ImageLabel" ) then
            Icon.ImageColor3 = ImageColor3
        end

        local UIStroke

        if Logo then
            UIStroke = Logo:FindFirstChildOfClass( "UIStroke" )
        else
            UIStroke = Logo
        end
        if UIStroke then
            UIStroke.Color = ImageColor3
        end
        if Nom and Nom:IsA( "TextLabel" ) then
            Nom.TextColor3 = ImageColor3
        end
    end

    local Table2

    if Model:GetAttribute( "Effet" ) ~= true or not Logo then
        Table2 = nil
    else
        local Halo = Clone:FindFirstChild( "Halo" )

        if Halo then
            Halo.Visible = true

            if typeof( ImageColor3 ) == "Color3" then
                Halo.BackgroundColor3 = ImageColor3
            end
        end

        local HaloSize
        local TableInner = { logo = Logo, halo = Halo, size = Logo.Size }
        HaloSize = if Halo then Halo.Size else Halo
        TableInner.haloSize = HaloSize
        Table2 = TableInner
    end

    Clone.Parent = Adornee
    Table[ Model ] = { bb = Clone, point = Model.PrimaryPart or Adornee, effet = Table2 }
end

local function Remove( Key )
    local Entry = Table[ Key ]

    if Entry then
        Table[ Key ] = nil
        Entry.bb:Destroy( )
    end
end

CompassPOI.ChildAdded:Connect( function( Argument1 )
    task.defer( Add, Argument1 )
end )
CompassPOI.ChildRemoved:Connect( Remove )

for Key, Value in CompassPOI:GetChildren( ) do
    Add( Value )
end

local Number2 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    Number2 = Number2 + Argument1

    if Number2 < 0.2 then
        return
    end

    local Flag
    Number2 = 0

    if ClientState.CaseRolling == true then
        Flag = true
    elseif ClientState.FixedCamera == nil then
        if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = true
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Character2 = if HumanoidRootPart then HumanoidRootPart.Position else HumanoidRootPart
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        if not Key.Parent or not Value.bb.Parent then
            Table[ Key ] = nil
        else
            local Enabled
            local NotFlag = not Flag

            if not NotFlag or not Character2 or not Value.point.Parent then
                Enabled = NotFlag
            else
                local Position = Value.point.Position - Character2
                local X = Position.X

                if Number < Vector3.new( X, 0, Position.Z ).Magnitude then
                    Enabled = true
                else
                    Enabled = false
                end
            end
            if Value.bb.Enabled ~= Enabled then
                Value.bb.Enabled = Enabled
            end
        end
    end
end )
local Number3 = tonumber( ShopSign:GetAttribute( "MonteeDebut" ) ) or 150
local Number4 = tonumber( ShopSign:GetAttribute( "MonteeFin" ) ) or 900
local Max = math.max( Number4, Number3 + 1 )
local Number5 = tonumber( ShopSign:GetAttribute( "MonteeMax" ) ) or 150
RunService.RenderStepped:Connect( function()
    local Value1
    local Position = workspace.CurrentCamera.CFrame.Position
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Bb = Value.bb

        if Bb.Enabled and Bb.Adornee then
            local Position2 = Bb.Adornee.Position - Position
            local X = Position2.X
            local Floor = math.floor( math.clamp( ( Vector3.new( X, 0, Position2.Z ).Magnitude - Number3 ) / ( Max - Number3 ), 0, 1 ) * Number5 * 4 + 0.5 ) / 4

            if Bb.StudsOffsetWorldSpace.Y ~= Floor then
                Bb.StudsOffsetWorldSpace = Vector3.new( 0, Floor, 0 )
            end

            local Effet = Value.effet

            if Effet then
                local Clock = os.clock( )
                local Sin = math.sin( Clock * 3 ) * 0.06 + 1
                local Logo = Effet.logo
                local Scale = Effet.size.X.Scale * Sin
                Logo.Size = UDim2.new( Scale, 0, Effet.size.Y.Scale * Sin, 0 )

                if Effet.halo then
                    local Clock2 = Clock * 0.8 % 1
                    local Halo = Effet.halo
                    local Scale2 = Effet.haloSize.X.Scale * ( 1 + 0.6 * Clock2 )
                    Halo.Size = UDim2.new( Scale2, 0, Effet.haloSize.Y.Scale * ( 1 + 0.6 * Clock2 ), 0 )
                    local Halo2 = Effet.halo
                    Halo2.BackgroundTransparency = 0.25 + 0.75 * Clock2
                end
            end
        end
    end
end )
