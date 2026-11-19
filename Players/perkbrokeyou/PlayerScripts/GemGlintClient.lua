-- Players.perkbrokeyou.PlayerScripts.GemGlintClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local RunService = game:GetService( "RunService" )
local Lighting = game:GetService( "Lighting" )
local Stretch = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Stretch" ) )
local Actor = script:FindFirstAncestorOfClass( "Actor" )

if Actor then
    local GlintIndex = Actor:GetAttribute( "GlintIndex" ) or 1
    local GlintCount = Actor:GetAttribute( "GlintCount" ) or 1
    local FromRGB = Color3.fromRGB( 200, 255, 225 )
    local Random2 = Random.new( )
    local RaycastParams2 = RaycastParams.new( )
    RaycastParams2.FilterType = Enum.RaycastFilterType.Include
    local Table = { }
    local Table2 = { }
    local Table3 = { }
    local Table4 = { }

    local function RandomUnit()
        local NextNumber = Random2:NextNumber( -1, 1 )
        local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )
        local Sqrt = math.sqrt( 1 - NextNumber * NextNumber )
        local Sqrt2 = Sqrt * math.cos( NextNumber2 )
        return ( Vector3.new( Sqrt2, Sqrt * math.sin( NextNumber2 ), NextNumber ) )
    end

    local function Tilt( Argument1 )
        local NextNumber = Random2:NextNumber( -1, 1 )
        local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )
        local Sqrt = math.sqrt( 1 - NextNumber * NextNumber )
        local Sqrt2 = Sqrt * math.cos( NextNumber2 )
        local Cross = Argument1:Cross( ( Vector3.new( Sqrt2, Sqrt * math.sin( NextNumber2 ), NextNumber ) ) )

        if Cross.Magnitude < 0.001 then
            return Argument1
        end
        return CFrame.fromAxisAngle( Cross.Unit, Random2:NextNumber( 0, 0.6108652381980153 ) ):VectorToWorldSpace( Argument1 )
    end

    local Value1 = nil
    local Table5 = { }

    local function NewPair()
        if not Value1 then
            local Parent
            Value1 = Instance.new( "Part" )
            Value1.Name = "GemGlintPool"
            Value1.Anchored = true
            Value1.CanCollide = false
            Value1.CanQuery = false
            Value1.CanTouch = false
            Value1.CastShadow = false
            Value1.Transparency = 1
            Value1.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
            Value1.CFrame = CFrame.new( 0, -5000, 0 )
            local FX = workspace:FindFirstChild( "FX" )
            Parent = if FX then FX else workspace
            Value1.Parent = Parent
        end

        local Parent2 = Instance.new( "Attachment" )
        Parent2.Name = "GemGlint"
        Parent2.Parent = Value1
        local ParticleEmitter = Instance.new( "ParticleEmitter" )
        ParticleEmitter.Name = "Eclat"
        ParticleEmitter.Texture = "rbxassetid://84683470246681"
        ParticleEmitter.Color = ColorSequence.new( FromRGB )
        ParticleEmitter.LightInfluence = 0
        ParticleEmitter.LightEmission = 0
        ParticleEmitter.Orientation = Enum.ParticleOrientation.FacingCamera
        ParticleEmitter.Rate = 0
        ParticleEmitter.Lifetime = NumberRange.new( 20 )
        ParticleEmitter.Speed = NumberRange.new( 0 )
        ParticleEmitter.Rotation = NumberRange.new( 0 )
        ParticleEmitter.RotSpeed = NumberRange.new( 0 )
        ParticleEmitter.LockedToPart = true
        ParticleEmitter.ZOffset = 0.15
        ParticleEmitter.Size = NumberSequence.new( 0.45 )
        ParticleEmitter.Parent = Parent2
        return {
            att = Parent2,
            pe = ParticleEmitter,
            size = 0.45,
            alpha = 0,
            color = nil
        }
    end

    local function Take( Parent, Argument2 )
        local E
        local Remove = table.remove( Table5 )

        if Remove then
            E = Remove
        else
            E = NewPair( )
        end

        local Color = Table4[ Parent ]

        if Color and E.color ~= Color then
            E.color = Color
            E.pe.Color = Color
        end
        if E.size ~= Argument2.size then
            E.size = Argument2.size
            local Pe = E.pe
            Pe.Size = NumberSequence.new( Argument2.size )
        end
        if E.alpha ~= Argument2.alpha then
            E.alpha = Argument2.alpha
            local Pe2 = E.pe
            Pe2.Transparency = NumberSequence.new( Argument2.alpha )
        end

        local Att = E.att
        Att.Position = Argument2.lp
        E.att.Parent = Parent
        Argument2.e = E
        return E
    end

    local function Release( Argument1 )
        local E = Argument1.e

        if not E then
            return
        end

        Argument1.e = nil

        if E.att.Parent == nil then
            return
        end
        E.pe:Clear( )
        E.att.Parent = Value1
        table.insert( Table5, E )
        return
    end

    local Table6 = { }
    local I2 = 1

    for I2 = 1, 64 do
        Table6[ ( "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" ):byte( I2 ) ] = I2 - 1
    end

    local function Dec( GlintPts, List, Argument3 )
        local Number
        local Total = List + Argument3 - 1
        local I = List
        Number = 0

        for I = List, Total do
            Number = Number * 64 + ( Table6[ GlintPts:byte( I ) ] or 0 )
        end

        return Number
    end

    local function Precomputed( Object, Size, Clamp )
        local GlintPts = Object:GetAttribute( "GlintPts" )

        if type( GlintPts ) ~= "string" or #GlintPts < 12 then
            return nil
        end

        local Max = math.max( Size.X / 2, 0.1 )
        local Max2 = math.max( Size.Y / 2, 0.1 )
        local Vector32 = Vector3.new( Max, Max2, ( math.max( Size.Z / 2, 0.1 ) ) )
        local Min = math.min( #GlintPts // 12, Clamp )
        local Table = { }
        local I = GlintIndex

        for I = GlintIndex, Min, GlintCount do
            local Total = ( I - 1 ) * 12 + 1
            local Dec2 = Dec( GlintPts, Total, 3 )
            local Dec3 = Dec( GlintPts, Total + 3, 3 )
            local Vector33 = Vector3.new( Dec2, Dec3, ( Dec( GlintPts, Total + 6, 3 ) ) ) / 262143 * 4 - Vector3.new( 2, 2, 2 )
            local Dec4 = Dec( GlintPts, Total + 9, 1 )
            local Dec5 = Dec( GlintPts, Total + 10, 1 )
            local Vector34 = Vector3.new( Dec4, Dec5, ( Dec( GlintPts, Total + 11, 1 ) ) ) / 63 * 2 - Vector3.new( 1, 1, 1 )

            if Vector34.Magnitude > 0.001 then
                local N
                local Table2 = { on = false, t = 0, size = 0.45, alpha = 0, e = nil }
                local Unit = Vector34.Unit
                local NextNumber = Random2:NextNumber( -1, 1 )
                local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )
                local Sqrt = math.sqrt( 1 - NextNumber * NextNumber )
                local Sqrt2 = Sqrt * math.cos( NextNumber2 )
                local Cross = Unit:Cross( ( Vector3.new( Sqrt2, Sqrt * math.sin( NextNumber2 ), NextNumber ) ) )

                if Cross.Magnitude < 0.001 then
                    N = Unit
                else
                    N = CFrame.fromAxisAngle( Cross.Unit, Random2:NextNumber( 0, 0.6108652381980153 ) ):VectorToWorldSpace( Unit )
                end

                Table2.n = N
                Table2.lp = Vector33 * Vector32
                table.insert( Table, Table2 )
            end
        end

        return Table
    end

    local function Build( Object )
        if Table[ Object ] or not Object:IsA( "BasePart" ) or not Object:IsDescendantOf( workspace ) then
            return
        end

        local Floor3
        local Size = Object.Size
        local Floor = math.floor( 2 * ( Size.X * Size.Y + Size.Y * Size.Z + Size.X * Size.Z ) * 22 + 0.5 )
        local Clamp = math.clamp( Floor, 1, Object:GetAttribute( "GlintMax" ) or 40 )

        if GlintIndex <= Clamp then
            local Floor2 = math.floor( ( Clamp - GlintIndex ) / GlintCount ) + 1

            if Floor2 then
                Floor3 = Floor2
            else
                Floor3 = 0
            end
        else
            Floor3 = 0
        end

        local GlintColor2
        local Magnitude = Size.Magnitude
        local GlintColor = Object:GetAttribute( "GlintColor" )
        GlintColor2 = if GlintColor then GlintColor else FromRGB
        local Table2
        Table4[ Object ] = ColorSequence.new( GlintColor2 )
        local Precomputed2 = Precomputed( Object, Size, Clamp )

        if Precomputed2 then
            Table2 = Precomputed2
        else
            local CanQuery = Object.CanQuery
            Object.CanQuery = true
            RaycastParams2.FilterDescendantsInstances = { Object }
            local TableInner = { }
            local Floor4 = Floor3 * 4
            local I = 1

            for I = 1, Floor4 do
                if Floor3 <= #TableInner then
                    break
                end

                local NextNumber = Random2:NextNumber( -1, 1 )
                local NextNumber2 = Random2:NextNumber( 0, 6.283185307179586 )
                local Sqrt = math.sqrt( 1 - NextNumber * NextNumber )
                local Sqrt2 = Sqrt * math.cos( NextNumber2 )
                local Vector32 = Vector3.new( Sqrt2, Sqrt * math.sin( NextNumber2 ), NextNumber )
                local Raycast = workspace:Raycast( Object.Position + Vector32 * Magnitude, -Vector32 * Magnitude * 2, RaycastParams2 )

                if Raycast then
                    table.insert( TableInner, {
                        n = Object.CFrame:VectorToObjectSpace( Tilt( Raycast.Normal ) ),
                        lp = Object.CFrame:PointToObjectSpace( Raycast.Position + Raycast.Normal * 0.03 ),
                        on = false,
                        t = 0,
                        size = 0.45,
                        alpha = 0,
                        e = nil
                    } )
                end
            end

            Object.CanQuery = CanQuery
            Table2 = TableInner
        end

        Table3[ Object ] = Magnitude
        Table[ Object ] = Table2
    end

    local function Remove( Key )
        local Entry2
        local Entry = Table[ Key ]
        Table[ Key ] = nil
        Table2[ Key ] = nil
        Table3[ Key ] = nil
        Table4[ Key ] = nil
        Entry2 = if Entry then Entry else { }
        local Value1Inner = nil

        for Key2, Value in Entry2, nil, nil do
            local E = Value.e

            if E then
                Value.e = nil

                if E.att.Parent ~= nil then
                    E.pe:Clear( )
                    E.att.Parent = Value1
                    table.insert( Table5, E )
                end
            end
        end
    end

    local GlintCount2 = 0.001 / GlintCount
    local Table7 = { }
    local Table8 = { }

    local function Enqueue( Key )
        if Table[ Key ] or Table8[ Key ] then
            return
        end
        Table8[ Key ] = true
        table.insert( Table7, Key )
        return
    end

    for Key, Value in CollectionService:GetTagged( "SkinGlint" ) do
        if not Table[ Value ] then
            if not Table8[ Value ] then
                Table8[ Value ] = true
                table.insert( Table7, Value )
            end
        end
    end

    CollectionService:GetInstanceAddedSignal( "SkinGlint" ):Connect( Enqueue )
    CollectionService:GetInstanceRemovedSignal( "SkinGlint" ):Connect( function( Key2 )
        Table8[ Key2 ] = nil
        Remove( Key2 )
    end )
    RunService.Heartbeat:Connect( function()
        if #Table7 == 0 then
            return
        end

        local Clock = os.clock( )

        while true do
            local Remove = table.remove( Table7, 1 )

            if Table8[ Remove ] then
                Table8[ Remove ] = nil

                if Remove.Parent then
                    Build( Remove )
                end
            end
            if #Table7 == 0 or GlintCount2 < os.clock( ) - Clock then
                break
            end
        end
    end )
    local Table9 = { }
    local Table10 = { }
    local Table11 = { }
    local Number = 0

    local function Act( Argument1, Argument2, Argument3 )
        Number = Number + 1
        Table9[ Number ] = Argument1
        Table10[ Number ] = Argument2
        Table11[ Number ] = Argument3
    end

    local function Off( Argument1 )
        if Argument1.on then
            Argument1.on = false
            Number = Number + 1
            Table9[ Number ] = 1
            Table10[ Number ] = Argument1
            Table11[ Number ] = nil
        end
    end

    local CurrentCamera = workspace.CurrentCamera
    local Identity = CFrame.identity
    local Zero = Vector2.zero
    local Number2 = 70
    local Position = Vector3.new( 0, 1, 0 )
    local Number3 = 0
    RunService.RenderStepped:Connect( function()
        Identity = CurrentCamera.CFrame
        Zero = CurrentCamera.ViewportSize
        Number2 = CurrentCamera.FieldOfView
        Position = Lighting:GetSunDirection( )
        Number3 = os.clock( )
    end )
    RunService.RenderStepped:ConnectParallel( function()
        local Flag4
        Number = 0
        local PositionInner = Identity.Position
        Flag4 = Position.Y > -0.05 and true or false
        local Tan3
        local Unit = Identity.LookVector.Unit
        local Unit2 = Identity.RightVector.Unit
        local Unit3 = Identity.UpVector.Unit
        local Tan = math.tan( math.rad( Number2 ) / 2 ) * math.max( Stretch.Factor or 1, 1.3333333333333333 ) * 1.25

        if not ( Zero.X >= 1 ) or not ( Zero.Y >= 1 ) then
            Tan3 = nil
        else
            local Tan2 = Tan * Zero.X / Zero.Y

            if Tan2 then
                Tan3 = Tan2
            else
                Tan3 = nil
            end
        end

        local Tan4
        local Sqrt = math.sqrt( Tan * Tan + 1 )
        Tan4 = if Tan3 then math.sqrt( 1 + Tan3 * Tan3 ) else Tan3
        local Value1Inner = nil

        for Key, Value in Table, nil, nil do
            if Key.Parent then
                local Flag
                local Position2 = Key.Position - PositionInner

                if Position2.Magnitude > 70 then
                    Flag = true
                elseif Key.LocalTransparencyModifier >= 0.99 then
                    Flag = true
                else
                    Flag = false
                end
                if not Flag and Tan3 then
                    local Flag2
                    local Entry3 = Table3[ Key ] or 0
                    local Max = math.max( Entry3, Key.Size.Magnitude ) + 1
                    local Dot = Position2:Dot( Unit )
                    local Abs = math.abs( ( Position2:Dot( Unit2 ) ) ) - Dot * Tan3

                    if Max * Tan4 < Abs then
                        Flag2 = true
                    else
                        local Abs2 = math.abs( ( Position2:Dot( Unit3 ) ) ) - Dot * Tan

                        if Max * Sqrt < Abs2 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    end

                    Flag = Flag2
                end
                if Flag then
                    if Table2[ Key ] then
                        local Value2 = nil

                        for Key2, Value3 in Value, nil, nil do
                            if Value3.on then
                                Value3.on = false
                                Number = Number + 1
                                Table9[ Number ] = 1
                                Table10[ Number ] = Value3
                                Table11[ Number ] = nil
                            end
                        end

                        Table2[ Key ] = nil
                    end
                else
                    local Value4, Flag3
                    Table2[ Key ] = true
                    local CFrame = Key.CFrame
                    Value4 = nil
                    Flag3 = false

                    for Key3, Value5 in Value, nil, nil do
                        local Max3
                        local Unit4 = ( PositionInner - CFrame:PointToWorldSpace( Value5.lp ) ).Unit
                        local VectorToWorldSpace = CFrame:VectorToWorldSpace( Value5.n )
                        local Max2 = math.max( VectorToWorldSpace:Dot( Unit4 ), 0 ) ^ 40 * 0.8

                        if Flag4 then
                            Max3 = math.max( Max2, math.max( VectorToWorldSpace:Dot( ( Unit4 + Position ).Unit ), 0 ) ^ 28 )
                        else
                            Max3 = Max2
                        end
                        if Max3 > 0.06 then
                            local Alpha = 1 - math.min( 1, Max3 * 1.3 )

                            if math.abs( Alpha - Value5.alpha ) > 0.01 then
                                Value5.alpha = Alpha
                                Number = Number + 1
                                Table9[ Number ] = 2
                                Table10[ Number ] = Value5
                                Table11[ Number ] = nil
                            end

                            local Size = ( math.min( 1, Max3 ) * 0.75 + 0.45 ) * 0.45

                            if math.abs( Size - Value5.size ) > 0.004 then
                                Value5.size = Size
                                Number = Number + 1
                                Table9[ Number ] = 3
                                Table10[ Number ] = Value5
                                Table11[ Number ] = nil
                            end
                            if not Value5.on or Number3 - Value5.t > 15 then
                                Number = Number + 1
                                Table9[ Number ] = 4
                                Table10[ Number ] = Value5
                                Table11[ Number ] = Key
                                Value5.on = true
                                Value5.t = Number3
                            end
                        elseif Value5.on then
                            Value5.on = false
                            Number = Number + 1
                            Table9[ Number ] = 1
                            Table10[ Number ] = Value5
                            Table11[ Number ] = nil
                        end
                        if Value5.on then
                            Flag3 = true
                        end
                    end

                    Table2[ Key ] = Flag3 or nil
                end
            else
                Number = Number + 1
                Table9[ Number ] = 5
                Table10[ Number ] = nil
                Table11[ Number ] = Key
            end
        end
        if Number == 0 then
            return
        end

        task.synchronize( )
        local I = 1

        for I = 1, Number do
            local Entry = Table9[ I ]
            local Entry2 = Table10[ I ]

            if Entry == 1 then
                local E = Entry2.e

                if E then
                    Entry2.e = nil

                    if E.att.Parent ~= nil then
                        E.pe:Clear( )
                        E.att.Parent = Value1
                        table.insert( Table5, E )
                    end
                end
            elseif Entry == 2 then
                local E2 = Entry2.e

                if E2 and E2.alpha ~= Entry2.alpha then
                    E2.alpha = Entry2.alpha
                    local Pe = E2.pe
                    Pe.Transparency = NumberSequence.new( Entry2.alpha )
                end
            elseif Entry == 3 then
                local E3 = Entry2.e

                if E3 and E3.size ~= Entry2.size then
                    E3.size = Entry2.size
                    local Pe2 = E3.pe
                    Pe2.Size = NumberSequence.new( Entry2.size )
                end
            elseif Entry == 4 then
                local E5
                local E4 = Entry2.e

                if E4 then
                    E5 = E4
                else
                    E5 = Take( Table11[ I ], Entry2 )
                end

                E5.pe:Clear( )
                E5.pe:Emit( 1 )
            elseif Entry == 5 then
                Remove( Table11[ I ] )
            end

            Table10[ I ] = nil
            Table11[ I ] = nil
        end
    end )
    return
end
local I = 1

for I = 1, 4 do
    local Parent = Instance.new( "Actor" )
    Parent.Name = "GemGlintWorker" .. I
    Parent:SetAttribute( "GlintIndex", I )
    Parent:SetAttribute( "GlintCount", 4 )
    script:Clone( ).Parent = Parent
    Parent.Parent = script.Parent
end

return
