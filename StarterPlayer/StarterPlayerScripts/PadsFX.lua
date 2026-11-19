-- StarterPlayer.StarterPlayerScripts.PadsFX
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Ranked = workspace:WaitForChild( "Ranked", 60 )

if Ranked then
    local Table = { }
    local Table2 = { }

    local function SetupDuel( Self )
        local VS
        local LienA = Self:FindFirstChild( "LienA" )
        local LienB = Self:FindFirstChild( "LienB" )
        local Ancre = Self:FindFirstChild( "Ancre" )

        if Ancre then
            VS = Ancre:FindFirstChild( "VS" )
        else
            VS = Ancre
        end

        local Txt

        if VS then
            Txt = VS:FindFirstChild( "Texte" )
        else
            Txt = VS
        end

        local LaT
        local Table = { la = LienA, lb = LienB }
        LaT = LienA and LienA.Transparency or 0.55
        local LbT
        Table.laT = LaT
        LbT = LienB and LienB.Transparency or 0.55
        local TxtT
        Table.lbT = LbT
        Table.txt = Txt
        TxtT = Txt and Txt.TextTransparency or 0.15
        local Size
        Table.txtT = TxtT

        if not Txt or not Txt.Size then
            Size = UDim2.fromScale( 0.85, 0.85 )
        else
            Size = Txt.Size
        end

        Table.size = Size
        return Table
    end

    local function Setup( Self )
        local Sol
        local Dalle = Self:FindFirstChild( "Dalle" )

        if Dalle then
            Sol = Dalle:FindFirstChild( "Sol" )
        else
            Sol = Dalle
        end
        if not Sol then
            return nil
        end

        local Dir
        local Table = { k = 0, angle = 0, beams = { }, caps = { } }
        local Zone = Self:FindFirstChild( "Zone" )
        Dir = ( not Zone or Zone:GetAttribute( "Slot" ) ~= 2 ) and 1 or -1
        local Anneau
        Table.dir = Dir
        local Embleme = Sol:FindFirstChild( "Embleme" )

        if Embleme then
            Anneau = Embleme:FindFirstChild( "Anneau" )
        else
            Anneau = Embleme
        end

        local UIStroke

        if Anneau then
            UIStroke = Anneau:FindFirstChildOfClass( "UIStroke" )
        else
            UIStroke = Anneau
        end

        local Arcs = if UIStroke then UIStroke:FindFirstChild( "Arcs" ) else UIStroke
        local Halo
        Table.arcs = Arcs
        Halo = if Embleme then Embleme:FindFirstChild( "Halo" ) else Embleme
        local HaloT
        Table.halo = Halo

        if Table.halo then
            local BackgroundTransparency = Table.halo.BackgroundTransparency

            if BackgroundTransparency then
                HaloT = BackgroundTransparency
            else
                HaloT = 0.82
            end
        else
            HaloT = 0.82
        end

        Table.haloT = HaloT
        local Rideaux = Dalle:FindFirstChild( "Rideaux" )

        if Rideaux then
            for Key, Value in Rideaux:GetChildren( ) do
                if Value:IsA( "Beam" ) then
                    local Beams = Table.beams
                    table.insert( Beams, { b = Value, base = Value.Transparency, emit = Value.LightEmission } )
                end
            end
        end
        for Key2, Value2 in Dalle:GetChildren( ) do
            if Value2.Name == "Capuchon" and Value2:IsA( "BasePart" ) then
                table.insert( Table.caps, Value2 )
            end
        end

        local Light
        local Lumiere = Dalle:FindFirstChild( "Lumiere" )
        Light = if Lumiere then Lumiere:FindFirstChildOfClass( "PointLight" ) else Lumiere
        local LightB
        Table.light = Light

        if Table.light then
            local Brightness = Table.light.Brightness

            if Brightness then
                LightB = Brightness
            else
                LightB = 1.1
            end
        else
            LightB = 1.1
        end

        local Pe
        Table.lightB = LightB
        local Etincelles = Dalle:FindFirstChild( "Etincelles" )
        Pe = if Etincelles then Etincelles:FindFirstChildOfClass( "ParticleEmitter" ) else Etincelles
        local Rate2
        Table.pe = Pe

        if Table.pe then
            local Rate = Table.pe.Rate

            if Rate then
                Rate2 = Rate
            else
                Rate2 = 5
            end
        else
            Rate2 = 5
        end

        Table.rate = Rate2
        Table.center = Sol.Position
        local CFrame = Sol.CFrame
        local Size = Sol.Size
        Table.hx = ( math.abs( CFrame.RightVector.X ) * Size.X + math.abs( CFrame.UpVector.X ) * Size.Y + math.abs( CFrame.LookVector.X ) * Size.Z ) / 2
        Table.hz = ( math.abs( CFrame.RightVector.Z ) * Size.X + math.abs( CFrame.UpVector.Z ) * Size.Y + math.abs( CFrame.LookVector.Z ) * Size.Z ) / 2
        return Table
    end

    local function Shifted( Argument1, Amount )
        local Value1
        local Table = { }
        local Keypoints = Argument1.Keypoints
        Value1 = nil

        for Key, Value in Keypoints, nil, nil do
            local Clamp
            local Value2 = Value.Value

            if Value2 < 1 then
                Clamp = math.clamp( Value2 - Amount * ( 1 - Value2 ) * 0.9 - Amount * 0.15, 0, 1 )
            else
                Clamp = Value2
            end

            table.insert( Table, NumberSequenceKeypoint.new( Value.Time, Clamp ) )
        end

        return NumberSequence.new( Table )
    end

    local function Occupied( Argument1, Argument2, Argument3 )
        for Key, Value in Players:GetPlayers( ) do
            local HumanoidRootPart
            local Character = Value.Character

            if Character then
                HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
            else
                HumanoidRootPart = Character
            end
            if HumanoidRootPart then
                local Position = HumanoidRootPart.Position - Argument1

                if math.abs( Position.X ) < Argument2 and math.abs( Position.Z ) < Argument3 and Position.Y > 0 then
                    if Position.Y < 8 then
                        return true
                    end
                end
            end
        end

        return false
    end

    local Clock = os.clock( )
    local Number = 0
    RunService.RenderStepped:Connect( function( Amount )
        if Ranked:GetAttribute( "Enabled" ) == false then
            return
        end

        local Pads = Ranked:FindFirstChild( "Pads" )

        if not Pads then
            return
        end

        local Flag
        local CurrentCamera = workspace.CurrentCamera
        local ClockInner = os.clock( ) - Clock
        Flag = false

        for Key, Value in Pads:GetChildren( ) do
            if Value:IsA( "Model" ) and Value.Name:sub( 1, 4 ) == "Pad_" then
                local Entry4
                local Entry3 = Table[ Value ]

                if Entry3 then
                    Entry4 = Entry3
                else
                    local Setup2 = Setup( Value )
                    Table[ Value ] = Setup2
                    Entry4 = Setup2
                end
                if Entry4 and ( CurrentCamera.CFrame.Position - Entry4.center ).Magnitude < 160 then
                    local NumberInner = not Occupied( Entry4.center, Entry4.hx, Entry4.hz ) and 0 or 1
                    Entry4.k = Entry4.k + ( NumberInner - Entry4.k ) * math.min( 1, Amount * 5 )
                    local Sin = ( math.sin( ClockInner * 1.6 + Entry4.center.Z ) + 1 ) / 2
                    Entry4.angle = ( Entry4.angle + Amount * ( 25 + 60 * Entry4.k ) * Entry4.dir ) % 360

                    if Entry4.arcs then
                        local Arcs = Entry4.arcs
                        Arcs.Rotation = Entry4.angle
                    end
                    if Entry4.halo then
                        local Halo = Entry4.halo
                        Halo.BackgroundTransparency = Entry4.haloT - 0.12 * Entry4.k - Sin * 0.03
                    end
                    if Entry4.light then
                        local Light = Entry4.light
                        Light.Brightness = Entry4.lightB * ( Sin * 0.15 + 0.9 ) + 0.35 * Entry4.k
                    end

                    local Value9
                    local Caps = Entry4.caps
                    Value9 = nil

                    for Key4, Value10 in Caps, nil, nil do
                        Value10.Transparency = 0.2 + ( 1 - Sin ) * 0.15 * ( 1 - Entry4.k )
                    end
                    if Entry4.pe then
                        local Pe = Entry4.pe
                        Pe.Rate = Entry4.rate + 4 * Entry4.k
                    end
                    if ClockInner - Number > 0.05 then
                        local Value11
                        local Sin2 = Sin * 0.05 + 0.22 * Entry4.k
                        local Beams = Entry4.beams
                        Value11 = nil

                        for Key5, Value12 in Beams, nil, nil do
                            local B = Value12.b
                            B.Transparency = Shifted( Value12.base, Sin2 )
                            local B2 = Value12.b
                            B2.LightEmission = Value12.emit + 0.1 * Entry4.k
                            Flag = true
                        end

                        Flag = true
                    else
                        Flag = true
                    end
                end
            end
        end

        local Value1 = nil

        for Value2 in Table, nil, nil do
            if not Value2.Parent then
                Table[ Value2 ] = nil
            end
        end

        local Duels = Pads:FindFirstChild( "Duels" )

        if Flag and Duels then
            for Key2, Value3 in Duels:GetChildren( ) do
                local Entry2
                local Entry = Table2[ Value3 ]

                if Entry then
                    Entry2 = Entry
                else
                    local Duel = SetupDuel( Value3 )
                    Table2[ Value3 ] = Duel
                    Entry2 = Duel
                end

                local K3
                local FoundChild = Pads:FindFirstChild( Value3:GetAttribute( "PadA" ) or "" )
                local FoundChild2 = Pads:FindFirstChild( Value3:GetAttribute( "PadB" ) or "" )

                if not FoundChild or not Table[ FoundChild ] then
                    K3 = 0
                else
                    local K = Table[ FoundChild ].k

                    if K then
                        K3 = K
                    else
                        K3 = 0
                    end
                end

                local K4

                if not FoundChild2 or not Table[ FoundChild2 ] then
                    K4 = 0
                else
                    local K2 = Table[ FoundChild2 ].k

                    if K2 then
                        K4 = K2
                    else
                        K4 = 0
                    end
                end

                local Min = math.min( K3, K4 )

                if Entry2.la then
                    local La = Entry2.la
                    La.Transparency = Entry2.laT - 0.45 * K3
                end
                if Entry2.lb then
                    local Lb = Entry2.lb
                    Lb.Transparency = Entry2.lbT - 0.45 * K4
                end
                if Entry2.txt then
                    local Txt = Entry2.txt
                    Txt.TextTransparency = Entry2.txtT * ( 1 - math.max( K3, K4 ) )
                    local Min2 = Min * ( math.sin( ClockInner * 6 ) * 0.1 + 0.18 ) + 1
                    local Txt2 = Entry2.txt
                    Txt2.Size = UDim2.fromScale( Entry2.size.X.Scale * Min2, Entry2.size.Y.Scale * Min2 )
                end
            end
        end

        local Value5 = nil

        for Value6 in Table2, nil, nil do
            if not Value6.Parent then
                Table2[ Value6 ] = nil
            end
        end
        if ClockInner - Number > 0.05 then
            Number = ClockInner
        end

        local Panneaux = Pads:FindFirstChild( "Panneaux" )

        if Flag and Panneaux then
            for Key3, Value7 in Panneaux:GetChildren( ) do
                local BaseY = Value7:GetAttribute( "BaseY" )

                if Value7:IsA( "BasePart" ) and type( BaseY ) == "number" then
                    local Position = Value7.Position
                    local X = Position.X
                    local BaseY2 = BaseY + math.sin( ClockInner * 1.2 + Key3 ) * 0.18
                    Value7.Position = Vector3.new( X, BaseY2, Position.Z )
                end
            end
        end
    end )
    return
end
return
