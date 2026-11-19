-- Players.perkbrokeyou.PlayerScripts.BoussoleClient
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
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Table = {
    [ 0 ] = "N",
    [ 45 ] = "NE",
    [ 90 ] = "E",
    [ 135 ] = "SE",
    [ 180 ] = "S",
    [ 225 ] = "SW",
    [ 270 ] = "W",
    [ 315 ] = "NW"
}
local Value1 = nil
local Zones = workspace:WaitForChild( "Zones", 10 )

if Zones then
    CompassPOI = Zones:WaitForChild( "CompassPOI", 10 )
else
    CompassPOI = Zones
end

local Flag = true

if CompassPOI then
    CompassPOI.ChildAdded:Connect( function()
        Flag = true
    end )
    CompassPOI.ChildRemoved:Connect( function()
        Flag = true
    end )
end

local function PoiPos( Model )
    local PrimaryPart2

    if Model:IsA( "Model" ) then
        local PrimaryPart = Model.PrimaryPart

        if PrimaryPart then
            PrimaryPart2 = PrimaryPart
        else
            local Point = Model:FindFirstChild( "Point" )

            if Point then
                PrimaryPart2 = Point
            else
                PrimaryPart2 = Model
            end
        end
    else
        PrimaryPart2 = Model
    end

    local Position = PrimaryPart2 and PrimaryPart2:IsA( "BasePart" ) and PrimaryPart2.Position or nil
    return Position
end

local function ConstruirePois( Argument1 )
    local Pois3
    local Pois = Argument1.pois
    Pois3 = if Pois then Pois else { }
    local Value1 = nil

    for Key, Value in Pois3, nil, nil do
        Value[ 1 ]:Destroy( )

        if Value[ 4 ] then
            Value[ 4 ]:Destroy( )
        end
    end

    local Poi
    Argument1.pois = { }
    local Modeles = Argument1.cadre:FindFirstChild( "Modeles" )

    if Modeles then
        Poi = Modeles:FindFirstChild( "Poi" )
    else
        Poi = Modeles
    end
    if not Poi or not Poi:IsA( "ImageLabel" ) or not CompassPOI then
        return
    end

    local PoiNom = Modeles:FindFirstChild( "PoiNom" )
    local Parent = Argument1.cadre:FindFirstChild( "Noms" )

    for Key2, Value2 in CompassPOI:GetChildren( ) do
        local FoundChild
        local Image = Value2:GetAttribute( "Icon" )
        local Modele = Value2:GetAttribute( "Modele" )

        if type( Modele ) ~= "string" or not Modeles:FindFirstChild( Modele ) then
            FoundChild = nil
        else
            FoundChild = Modeles:FindFirstChild( Modele )
        end
        if FoundChild and not FoundChild:IsA( "GuiObject" ) then
            FoundChild = nil
        end
        if not FoundChild then
            if type( Image ) ~= "string" or Image == "" then
                continue
            end
        end

        local Clone

        if FoundChild then
            Clone = FoundChild:Clone( )
        else
            local Clone2 = Poi:Clone( )
            Clone2.Image = Image
            Clone = Clone2
        end

        local Parent2
        Clone.Name = "Poi_" .. Value2.Name
        Clone.Visible = false
        local Icones = Argument1.cadre:FindFirstChild( "Icones" )
        Parent2 = if Icones then Icones else Argument1.bande
        local Clone4
        Clone.Parent = Parent2

        if not PoiNom or not Parent or type( Value2:GetAttribute( "Label" ) ) ~= "string" then
            Clone4 = nil
        else
            local Clone3 = PoiNom:Clone( )
            Clone3.Name = "Nom_" .. Value2.Name
            Clone3.Text = Value2:GetAttribute( "Label" )
            Clone3.Visible = false
            Clone3.Parent = Parent
            Clone4 = Clone3
        end

        local ImageColor3 = Value2:GetAttribute( "Couleur" )

        if typeof( ImageColor3 ) == "Color3" and not FoundChild then
            Clone.ImageColor3 = ImageColor3

            if Clone4 then
                Clone4.TextColor3 = ImageColor3
            end
        end

        local Table5, Ping2

        if FoundChild then
            local Value3
            local Table = { }
            local Ping = Clone:FindFirstChild( "Ping" )
            local Table2 = { Clone, table.unpack( Clone:GetDescendants( ) ) }
            Value3 = nil

            for Key3, Value4 in Table2, nil, nil do
                if Ping then
                    if Value4 == Ping or Value4:IsDescendantOf( Ping ) then
                        continue
                    end
                end
                if Value4:IsA( "TextLabel" ) or Value4:IsA( "TextButton" ) then
                    table.insert( Table, { Value4, "TextTransparency", Value4.TextTransparency } )
                end
                if Value4:IsA( "ImageLabel" ) or Value4:IsA( "ImageButton" ) then
                    table.insert( Table, { Value4, "ImageTransparency", Value4.ImageTransparency } )
                end
                if Value4:IsA( "GuiObject" ) and Value4.BackgroundTransparency < 1 then
                    table.insert( Table, { Value4, "BackgroundTransparency", Value4.BackgroundTransparency } )
                end
                if Value4:IsA( "UIStroke" ) then
                    table.insert( Table, { Value4, "Transparency", Value4.Transparency } )
                end
            end
            if Ping then
                local Base
                local Table3 = {
                    frame = Ping,
                    stroke = Ping:FindFirstChildOfClass( "UIStroke" ),
                    from = tonumber( Clone:GetAttribute( "PingDe" ) ) or 0.55,
                    to = tonumber( Clone:GetAttribute( "PingA" ) ) or 1.6,
                    period = math.max( tonumber( Clone:GetAttribute( "PingPeriode" ) ) or 1.1, 0.1 )
                }

                if Table3.stroke then
                    local Transparency = Table3.stroke.Transparency

                    if Transparency then
                        Base = Transparency
                    else
                        Base = 0
                    end
                else
                    Base = 0
                end

                Table3.base = Base
                Table5 = Table
                Ping2 = Table3
            else
                Table5 = Table
                Ping2 = Ping
            end
        else
            Table5 = nil
            Ping2 = nil
        end

        local ImageTransparency
        local Pois2 = Argument1.pois
        local Table4 = { }
        ImageTransparency = Clone:IsA( "ImageLabel" ) and Clone.ImageTransparency or 0
        local Flag
        local Size = Clone.Size
        Flag = Value2:GetAttribute( "Evenement" ) == true and true or false
        Table4[ 1 ] = Clone
        Table4[ 2 ] = Value2
        Table4[ 3 ] = ImageTransparency
        Table4[ 4 ] = Clone4
        Table4[ 5 ] = nil
        Table4[ 6 ] = Size
        Table4[ 7 ] = Flag
        Table4[ 8 ] = Table5
        Table4[ 9 ] = Ping2
        table.insert( Pois2, Table4 )
    end
end

local function MajPois( Argument1, Cap, Amount, Argument4 )
    if Flag then
        Flag = false
        ConstruirePois( Argument1 )
    end
    if #Argument1.pois == 0 then
        return
    end

    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local Position = HumanoidRootPart and HumanoidRootPart.Position or workspace.CurrentCamera.CFrame.Position
    local Value1
    local Cadre = Argument1.cadre
    local Number = tonumber( Cadre:GetAttribute( "PoiDistance" ) ) or 400
    local Max = math.max( tonumber( Cadre:GetAttribute( "PoiFondu" ) ) or 120, 1 )
    local Max2 = math.max( tonumber( Cadre:GetAttribute( "PoiProche" ) ) or 18, 0.1 )
    local Pois = Argument1.pois
    Value1 = nil

    for Key, Value in Pois, nil, nil do
        local Parent3
        local Item4 = Value[ 1 ]
        local Item5 = Value[ 2 ]
        local Item6 = Value[ 3 ]
        local Parent2 = Item5.Parent

        if Parent2 then
            local PrimaryPart2

            if Item5:IsA( "Model" ) then
                local PrimaryPart = Item5.PrimaryPart

                if PrimaryPart then
                    PrimaryPart2 = PrimaryPart
                else
                    local Point = Item5:FindFirstChild( "Point" )

                    if Point then
                        PrimaryPart2 = Point
                    else
                        PrimaryPart2 = Item5
                    end
                end
            else
                PrimaryPart2 = Item5
            end
            if not PrimaryPart2 or not PrimaryPart2:IsA( "BasePart" ) or not PrimaryPart2.Position then
                Parent3 = nil
            else
                Parent3 = PrimaryPart2.Position
            end
        else
            Parent3 = Parent2
        end

        local Number4, Number5

        if Parent3 then
            local Clamp
            local X2 = Parent3.X - Position.X
            local Z = Parent3.Z - Position.Z
            local Sqrt = math.sqrt( X2 * X2 + Z * Z )

            if Item5:GetAttribute( "Toujours" ) == true then
                Clamp = 1
            else
                Clamp = math.clamp( 1 - ( Sqrt - Number ) / Max, 0, 1 )
            end
            if Value[ 7 ] then
                local Number3 = not ( Max2 < Sqrt ) and 0 or 1
                Number4 = Number3
            else
                Number4 = Clamp * math.clamp( ( Sqrt - Max2 ) / Max2, 0, 1 )
            end

            local Deg = ( ( math.deg( ( math.atan2( X2, -Z ) ) ) - Argument4 ) % 360 - Cap + 540 ) % 360 - 180

            if Amount < math.abs( Deg ) then
                Number4 = 0
                Number5 = Deg
            else
                Number5 = Deg
            end
        else
            Number4 = 0
            Number5 = 0
        end

        local Visible = Number4 > 0.01 and true or false

        if Item4.Visible ~= Visible then
            Item4.Visible = Visible
        end
        if Visible then
            local Clamp2

            if Item4.Parent == Argument1.bande then
                Clamp2 = 1
            else
                Clamp2 = math.clamp( ( Amount - math.abs( Number5 ) ) / ( Amount * 0.25 ), 0, 1 )
            end

            local Number6 = 0.5 + Number5 / ( 2 * Amount )
            Item4.Position = UDim2.new( Number6, 0, Item4.Position.Y.Scale, Item4.Position.Y.Offset )
            local Number7 = Number4 * Clamp2

            if Value[ 8 ] then
                local Value6
                local Item7 = Value[ 8 ]
                Value6 = nil

                for Key4, Value7 in Item7, nil, nil do
                    Value7[ 1 ][ Value7[ 2 ] ] = 1 - ( 1 - Value7[ 3 ] ) * Number7
                end
            else
                Item4.ImageTransparency = 1 - ( 1 - Item6 ) * Number7
            end

            local Item8 = Value[ 9 ]

            if Item8 then
                local Clock = os.clock( ) / Item8.period % 1
                local From = Item8.from + ( Item8.to - Item8.from ) * Clock
                local Frame = Item8.frame
                Frame.Size = UDim2.fromScale( From, From )

                if Item8.stroke then
                    local Stroke = Item8.stroke
                    Stroke.Transparency = 1 - ( 1 - Item8.base ) * ( 1 - Clock ) * Number7
                end
            end
            if Value[ 7 ] then
                local Sin = ( math.sin( os.clock( ) * 4 ) * 0.5 + 0.5 ) * 0.15 + 1
                local Scale = Value[ 6 ].X.Scale * Sin
                Item4.Size = UDim2.new( Scale, 0, Value[ 6 ].Y.Scale * Sin, 0 )
            end
        end

        local Item9 = Value[ 4 ]

        if Item9 then
            local Visible2
            local Number8 = Number4 * math.clamp( ( Amount - math.abs( Number5 ) ) / ( Amount * 0.25 ), 0, 1 )
            Visible2 = Number8 > 0.01 and true or false

            if Item9.Visible ~= Visible2 then
                Item9.Visible = Visible2
            end

            local Number10

            if Visible2 then
                local Number9 = 0.5 + Number5 / ( 2 * Amount )

                if Number9 then
                    Number10 = Number9
                else
                    Number10 = nil
                end
            else
                Number10 = nil
            end

            Value[ 5 ] = Number10

            if Visible2 then
                Item9.TextTransparency = 1 - Number8
                local UIStroke = Item9:FindFirstChildOfClass( "UIStroke" )

                if UIStroke then
                    UIStroke.Transparency = 1 - Number8 * 0.75
                end
            end
        end
    end

    local Noms = Argument1.cadre:FindFirstChild( "Noms" )
    local NomsBas = Argument1.cadre:FindFirstChild( "NomsBas" )

    if not Noms then
        return
    end

    local Value2
    local Table = { }
    local Pois2 = Argument1.pois
    Value2 = nil

    for Key2, Value3 in Pois2, nil, nil do
        if Value3[ 4 ] and Value3[ 5 ] then
            table.insert( Table, Value3 )
        end
    end

    local Value4, Number2
    table.sort( Table, function( List, List2 )
        local Flag = List[ 5 ] < List2[ 5 ] and true or false
        return Flag
    end )
    local Max3 = math.max( Noms.AbsoluteSize.X, 1 )
    Value4 = nil
    Number2 = -math.huge

    for Key3, Value5 in Table, nil, nil do
        local Parent
        local Item = Value5[ 4 ]
        local Item2 = Value5[ 5 ]
        local X = Item.TextBounds.X / Max3 / 2 + 0.01

        if not ( Item2 - X < Number2 ) or not NomsBas then
            Parent = Noms
            Number2 = Item2 + X
        else
            local Item3 = Item2 + X
            Parent = NomsBas
        end
        if Item.Parent ~= Parent then
            Item.Parent = Parent
        end

        Item.Position = UDim2.new( Item2, 0, Item.Position.Y.Scale, 0 )
    end
end

local function Cadre()
    local TopCenter
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopCenter = GlobalGui:FindFirstChild( "TopCenter" )
    else
        TopCenter = GlobalGui
    end

    local GlobalGui2 = if TopCenter then TopCenter:FindFirstChild( "Boussole" ) else TopCenter
    return GlobalGui2
end

local function Construire( Boussole )
    local Parent = Boussole:FindFirstChild( "Bande" )
    local Modeles = Boussole:FindFirstChild( "Modeles" )
    local Cap = Boussole:FindFirstChild( "Cap" )

    if not Parent or not Modeles then
        return nil
    end
    for Key, Value in Parent:GetChildren( ) do
        if Value:IsA( "GuiObject" ) then
            Value:Destroy( )
        end
    end

    local Grads = { }
    local I = 0

    for I = 0, 355, 5 do
        local Text

        if Table[ I ] then
            Text = "Cardinal"
        elseif I % 15 == 0 then
            Text = "Degres"
        else
            Text = "Repere"
        end

        local FoundChild = Modeles:FindFirstChild( Text )

        if FoundChild then
            local Clone = FoundChild:Clone( )
            Clone.Name = Text .. "_" .. I
            local Texte = Clone:FindFirstChild( "Texte" )

            if Texte then
                local Text2
                local Entry = Table[ I ]
                Text2 = if Entry then Entry else tostring( I )
                Texte.Text = Text2
            end

            Clone.Visible = false
            Clone.Parent = Parent
            table.insert( Grads, { Clone, I } )
        end
    end

    local Valeur
    local TableInner = { cadre = Boussole, bande = Parent, cap = nil }
    Valeur = if Cap then Cap:FindFirstChild( "Valeur" ) else Cap
    TableInner.valeur = Valeur
    TableInner.grads = Grads
    TableInner.pois = { }
    ConstruirePois( TableInner )
    return TableInner
end

RunService:BindToRenderStep( "Boussole", Enum.RenderPriority.Last.Value, function()
    local TopCenter
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopCenter = GlobalGui:FindFirstChild( "TopCenter" )
    else
        TopCenter = GlobalGui
    end

    local Boussole

    if TopCenter then
        Boussole = TopCenter:FindFirstChild( "Boussole" )
    else
        Boussole = TopCenter
    end
    if not Boussole then
        Value1 = nil
        return
    end
    if not Value1 or Value1.cadre ~= Boussole then
        Value1 = Construire( Boussole )

        if not Value1 then
            return
        end
    end

    local Visible = if Controls.Settings.Compass == false then false else not workspace:GetAttribute( "RankedMatch" )

    if Boussole.Visible ~= Visible then
        Boussole.Visible = Visible
    end
    if not Visible then
        return
    end

    local LookVector2
    local CFrame = workspace.CurrentCamera.CFrame
    local LookVector = CFrame.LookVector
    LookVector2 = if math.abs( LookVector.X ) + math.abs( LookVector.Z ) < 0.001 then CFrame.UpVector else LookVector
    local Number = tonumber( Boussole:GetAttribute( "Nord" ) ) or 0
    local X = LookVector2.X
    local Cap = ( math.deg( ( math.atan2( X, -LookVector2.Z ) ) ) - Number ) % 360
    local Number2 = ( tonumber( Boussole:GetAttribute( "Champ" ) ) or 120 ) / 2
    MajPois( Value1, Cap, Number2, Number )

    if Value1.cap and math.abs( ( Cap - Value1.cap + 540 ) % 360 - 180 ) < 0.01 then
        return
    end

    local Value1Inner
    Value1.cap = Cap
    local Grads = Value1.grads
    Value1Inner = nil

    for Key, Value in Grads, nil, nil do
        local Visible2
        local Item = Value[ 1 ]
        local Item2 = ( Value[ 2 ] - Cap + 540 ) % 360 - 180
        Visible2 = math.abs( Item2 ) <= Number2 + 6 and true or false

        if Item.Visible ~= Visible2 then
            Item.Visible = Visible2
        end
        if Visible2 then
            local Item3 = 0.5 + Item2 / ( 2 * Number2 )
            Item.Position = UDim2.new( Item3, 0, Item.Position.Y.Scale, Item.Position.Y.Offset )
        end
    end
    if Value1.valeur then
        local Valeur = Value1.valeur
        Valeur.Text = tostring( math.floor( Cap + 0.5 ) % 360 )
    end
end )
