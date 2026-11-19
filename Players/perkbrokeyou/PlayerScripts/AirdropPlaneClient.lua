-- Players.perkbrokeyou.PlayerScripts.AirdropPlaneClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Value1 = nil
local Value2 = nil

local function Stop()
    if Value2 then
        Value2:Disconnect( )
        Value2 = nil
    end
    if Value1 then
        Value1:Destroy( )
        Value1 = nil
    end
end

local function Fly()
    if Value2 then
        Value2:Disconnect( )
        Value2 = nil
    end
    if Value1 then
        Value1:Destroy( )
        Value1 = nil
    end

    local AirdropPlaneFrom = ReplicatedStorage:GetAttribute( "AirdropPlaneFrom" )
    local AirdropPlaneDropPos = ReplicatedStorage:GetAttribute( "AirdropPlaneDropPos" )
    local AirdropPlaneTo = ReplicatedStorage:GetAttribute( "AirdropPlaneTo" )
    local AirdropPlaneT0 = ReplicatedStorage:GetAttribute( "AirdropPlaneT0" )
    local AirdropPlaneDrop = ReplicatedStorage:GetAttribute( "AirdropPlaneDrop" )
    local AirdropPlaneT1 = ReplicatedStorage:GetAttribute( "AirdropPlaneT1" )

    if typeof( AirdropPlaneFrom ) ~= "Vector3" or typeof( AirdropPlaneDropPos ) ~= "Vector3" or typeof( AirdropPlaneTo ) ~= "Vector3" then
        return
    end
    if type( AirdropPlaneT0 ) ~= "number" or type( AirdropPlaneDrop ) ~= "number" or type( AirdropPlaneT1 ) ~= "number" or AirdropPlaneT1 <= AirdropPlaneDrop or AirdropPlaneDrop <= AirdropPlaneT0 then
        return
    end
    if AirdropPlaneT1 <= workspace:GetServerTimeNow( ) then
        return
    end

    local AirdropPlane = ReplicatedStorage:FindFirstChild( "AirdropPlane" )

    if not AirdropPlane then
        warn( "[AirdropPlane] modèle ReplicatedStorage.AirdropPlane introuvable" )
        return
    end

    Value1 = AirdropPlane:Clone( )
    Value1.Name = "AirdropPlaneLive"
    local Number = tonumber( AirdropPlane:GetAttribute( "Scale" ) ) or 1

    if Number > 0 and Number ~= 1 then
        Value1:ScaleTo( Number )
    end

    local Number2 = tonumber( AirdropPlane:GetAttribute( "HelixSpeed" ) ) or 32
    local Table = { }
    local Pivot = Value1:GetPivot( )

    for Key, Value in Value1:GetDescendants( ) do
        if Value:IsA( "BasePart" ) and Value.Name:match( "^Helix" ) then
            table.insert( Table, { part = Value, rel = Pivot:ToObjectSpace( Value:GetPivot( ) ) } )
        end
    end
    for Key2, Value2Inner in Value1:GetDescendants( ) do
        if Value2Inner:IsA( "BasePart" ) then
            Value2Inner.Anchored = true
            Value2Inner.CanCollide = false
            Value2Inner.CanQuery = false
            Value2Inner.CanTouch = false
        end
    end

    local Unit
    local Angles = CFrame.Angles( 0, math.rad( tonumber( AirdropPlane:GetAttribute( "Yaw" ) ) or 0 ), 0 )
    local Number3 = tonumber( AirdropPlane:GetAttribute( "Bob" ) ) or 1.5
    local Number4 = tonumber( AirdropPlane:GetAttribute( "BobSpeed" ) ) or 0.8
    local AirdropPlaneTo2 = ( AirdropPlaneTo - AirdropPlaneFrom ) * Vector3.new( 1, 0, 1 )
    Unit = AirdropPlaneTo2.Magnitude > 0.01 and AirdropPlaneTo2.Unit or Vector3.new( 0, 0, 1 )
    local Lerp

    local function At( Argument1 )
        if Argument1 < AirdropPlaneDrop then
            return AirdropPlaneFrom:Lerp( AirdropPlaneDropPos, ( math.clamp( ( Argument1 - AirdropPlaneT0 ) / ( AirdropPlaneDrop - AirdropPlaneT0 ), 0, 1 ) ) )
        end
        return AirdropPlaneDropPos:Lerp( AirdropPlaneTo, ( math.clamp( ( Argument1 - AirdropPlaneDrop ) / ( AirdropPlaneT1 - AirdropPlaneDrop ), 0, 1 ) ) )
    end

    local ServerTimeNow = workspace:GetServerTimeNow( )

    if ServerTimeNow < AirdropPlaneDrop then
        Lerp = AirdropPlaneFrom:Lerp( AirdropPlaneDropPos, ( math.clamp( ( ServerTimeNow - AirdropPlaneT0 ) / ( AirdropPlaneDrop - AirdropPlaneT0 ), 0, 1 ) ) )
    else
        Lerp = AirdropPlaneDropPos:Lerp( AirdropPlaneTo, ( math.clamp( ( ServerTimeNow - AirdropPlaneDrop ) / ( AirdropPlaneT1 - AirdropPlaneDrop ), 0, 1 ) ) )
    end

    local Lerp2
    local ServerTimeNow2 = workspace:GetServerTimeNow( )

    if ServerTimeNow2 < AirdropPlaneDrop then
        Lerp2 = AirdropPlaneFrom:Lerp( AirdropPlaneDropPos, ( math.clamp( ( ServerTimeNow2 - AirdropPlaneT0 ) / ( AirdropPlaneDrop - AirdropPlaneT0 ), 0, 1 ) ) )
    else
        Lerp2 = AirdropPlaneDropPos:Lerp( AirdropPlaneTo, ( math.clamp( ( ServerTimeNow2 - AirdropPlaneDrop ) / ( AirdropPlaneT1 - AirdropPlaneDrop ), 0, 1 ) ) )
    end

    Value1:PivotTo( CFrame.lookAt( Lerp, Lerp2 + Unit ) * Angles )
    Value1.Parent = workspace

    for Key3, Value3 in Value1:GetDescendants( ) do
        if Value3:IsA( "Sound" ) and Value3.Looped then
            Value3:Play( )
        end
    end

    Value2 = RunService.RenderStepped:Connect( function()
        local ServerTimeNow = workspace:GetServerTimeNow( )

        if AirdropPlaneT1 <= ServerTimeNow then
            if Value2 then
                Value2:Disconnect( )
                Value2 = nil
            end
            if Value1 then
                Value1:Destroy( )
                Value1 = nil
            end

            return
        end
        local Lerp

        if ServerTimeNow < AirdropPlaneDrop then
            Lerp = AirdropPlaneFrom:Lerp( AirdropPlaneDropPos, ( math.clamp( ( ServerTimeNow - AirdropPlaneT0 ) / ( AirdropPlaneDrop - AirdropPlaneT0 ), 0, 1 ) ) )
        else
            Lerp = AirdropPlaneDropPos:Lerp( AirdropPlaneTo, ( math.clamp( ( ServerTimeNow - AirdropPlaneDrop ) / ( AirdropPlaneT1 - AirdropPlaneDrop ), 0, 1 ) ) )
        end

        local Value1Inner
        local Lerp2 = Lerp + Vector3.new( 0, Number3 * math.sin( ServerTimeNow * Number4 * 2 * 3.141592653589793 ), 0 )
        local LookAt = CFrame.lookAt( Lerp2, Lerp2 + Unit ) * Angles
        Value1:PivotTo( LookAt )
        local ServerTimeNow2 = ( ServerTimeNow - AirdropPlaneT0 ) * Number2
        Value1Inner = nil

        for Key, Value in Table, nil, nil do
            Value.part:PivotTo( LookAt * Value.rel * CFrame.Angles( 0, 0, ServerTimeNow2 ) )
        end

        return
    end )
end

ReplicatedStorage:GetAttributeChangedSignal( "AirdropPlaneT0" ):Connect( Fly )
task.defer( Fly )
local Value3 = nil
local Value4 = nil
local Value5 = nil

local function FallStop()
    if Value5 then
        Value5:Disconnect( )
        Value5 = nil
    end
    if Value3 then
        Value3:Destroy( )
        Value3 = nil
    end
    if Value4 then
        Value4:Destroy( )
        Value4 = nil
    end
end

local function RealCrateHere()
    local Flag
    local Airdrop = workspace:FindFirstChild( "Airdrop" )

    if Airdrop == nil then
        Flag = false
    elseif Airdrop:GetAttribute( "Landed" ) == true then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function Fall()
    if Value5 then
        Value5:Disconnect( )
        Value5 = nil
    end
    if Value3 then
        Value3:Destroy( )
        Value3 = nil
    end
    if Value4 then
        Value4:Destroy( )
        Value4 = nil
    end

    local AirdropFallLand = ReplicatedStorage:GetAttribute( "AirdropFallLand" )
    local AirdropFallHeight = ReplicatedStorage:GetAttribute( "AirdropFallHeight" )
    local AirdropFallT0 = ReplicatedStorage:GetAttribute( "AirdropFallT0" )
    local AirdropFallT1 = ReplicatedStorage:GetAttribute( "AirdropFallT1" )

    if typeof( AirdropFallLand ) ~= "CFrame" or type( AirdropFallHeight ) ~= "number" or type( AirdropFallT0 ) ~= "number" or type( AirdropFallT1 ) ~= "number" or AirdropFallT1 <= AirdropFallT0 then
        return
    end

    local ServerTimeNow = workspace:GetServerTimeNow( )

    if not ( AirdropFallT1 + 0.6 <= ServerTimeNow ) then
        local Flag
        local Airdrop = workspace:FindFirstChild( "Airdrop" )

        if Airdrop == nil then
            Flag = false
        elseif Airdrop:GetAttribute( "Landed" ) == true then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            local Crate
            local AirdropKit = ReplicatedStorage:FindFirstChild( "AirdropKit" )

            if AirdropKit then
                Crate = AirdropKit:FindFirstChild( "Crate" )
            else
                Crate = AirdropKit
            end
            if not Crate then
                warn( "[AirdropPlane] ReplicatedStorage.AirdropKit.Crate introuvable" )
                return
            end

            local Prep3
            local Number = tonumber( Crate:GetAttribute( "Height" ) ) or 3.8

            local function Prep( Object )
                Object.Name = Object.Name .. "Falling"

                for Key, Value in Object:GetDescendants( ) do
                    if Value:IsA( "BasePart" ) then
                        Value.Anchored = true
                        Value.CanCollide = false
                        Value.CanQuery = false
                        Value.CanTouch = false
                    elseif Value:IsA( "ProximityPrompt" ) or Value:IsA( "Script" ) or Value:IsA( "LocalScript" ) then
                        Value:Destroy( )
                    end
                end

                return Object
            end

            Value3 = Prep( Crate:Clone( ) )

            if AirdropKit:FindFirstChild( "Parachute" ) then
                local Prep2 = Prep( AirdropKit.Parachute:Clone( ) )

                if Prep2 then
                    Prep3 = Prep2
                else
                    Prep3 = nil
                end
            else
                Prep3 = nil
            end

            Value4 = Prep3
            local Number2 = 1
            local Flag2 = false
            Value5 = RunService.RenderStepped:Connect( function()
                local ServerTimeNow = workspace:GetServerTimeNow( )

                if ServerTimeNow < AirdropFallT0 then
                    return
                end
                if not Flag2 then
                    Flag2 = true
                    Value3.Parent = workspace

                    if Value4 then
                        Value4.Parent = workspace
                    end
                end

                local ServerTimeNow2 = ServerTimeNow - AirdropFallT0
                local Clamp = math.clamp( ServerTimeNow2 / ( AirdropFallT1 - AirdropFallT0 ), 0, 1 )
                local Clamp2 = math.clamp( ( AirdropFallT1 - ServerTimeNow ) / 2, 0, 1 )
                local Rad = math.rad( Clamp2 * 4 * math.sin( ServerTimeNow2 * 0.9 ) )
                local Angles = CFrame.Angles( Rad, 0, ( math.rad( Clamp2 * 4 * math.cos( ServerTimeNow2 * 0.7 ) ) ) )
                local Captured = AirdropFallLand * CFrame.new( 0, AirdropFallHeight * ( 1 - Clamp ), 0 ) * Angles

                if Value3 then
                    if AirdropFallT1 <= ServerTimeNow then
                        local Flag
                        local Airdrop = workspace:FindFirstChild( "Airdrop" )

                        if Airdrop == nil then
                            Flag = false
                        elseif Airdrop:GetAttribute( "Landed" ) == true then
                            Flag = true
                        else
                            Flag = false
                        end
                        if Flag then
                            Value3:Destroy( )
                            Value3 = nil
                            Value3 = nil
                        else
                            Value3:PivotTo( Captured )
                        end
                    else
                        Value3:PivotTo( Captured )
                    end
                end
                if Value4 then
                    local Min

                    if AirdropFallT1 <= ServerTimeNow then
                        local Max = math.max( 0.05, 1 - ( ServerTimeNow - AirdropFallT1 ) / 0.6 )

                        if Max then
                            Min = Max
                        else
                            Min = math.min( 1, 0.2 + 0.8 * ( ServerTimeNow2 / 1.2 ) )
                        end
                    else
                        Min = math.min( 1, 0.2 + 0.8 * ( ServerTimeNow2 / 1.2 ) )
                    end
                    if math.abs( Min - Number2 ) > 0.001 then
                        Value4:ScaleTo( Min )
                        Number2 = Min
                    end

                    Value4:PivotTo( Captured * CFrame.new( 0, Number, 0 ) )

                    if AirdropFallT1 + 0.6 <= ServerTimeNow then
                        Value4:Destroy( )
                        Value4 = nil

                        if Value4 then
                            Value4 = nil
                        end
                    end
                end
                if AirdropFallT1 <= ServerTimeNow and Value4 == nil then
                    if Value3 == nil or AirdropFallT1 + 3 <= ServerTimeNow then
                        if Value5 then
                            Value5:Disconnect( )
                            Value5 = nil
                        end
                        if Value3 then
                            Value3:Destroy( )
                            Value3 = nil
                        end
                        if Value4 then
                            Value4:Destroy( )
                            Value4 = nil
                        end
                    end
                end
            end )
            return
        end
    end
end

ReplicatedStorage:GetAttributeChangedSignal( "AirdropFallT0" ):Connect( Fall )
task.defer( Fall )
local ContentProvider = game:GetService( "ContentProvider" )

local function LandGains( Argument1, Object )
    local Number = tonumber( Object:GetAttribute( "SonProche" ) ) or 60
    local Number2 = tonumber( Object:GetAttribute( "SonFondu" ) ) or 450
    local Max = math.max( Number2, Number + 1 )
    local Number3 = tonumber( Object:GetAttribute( "SonLoin" ) ) or 3600
    local Max2 = math.max( Number3, Max + 1 )
    local Clamp = math.clamp( tonumber( Object:GetAttribute( "SonLoinMin" ) ) or 0.15, 0.001, 1 )
    local Clamp2 = math.clamp( ( Argument1 - Number ) / ( Max - Number ), 0, 1 )
    local Cos = math.cos( Clamp2 * 3.141592653589793 / 2 )
    local Sin = math.sin( Clamp2 * 3.141592653589793 / 2 )

    if Max < Argument1 then
        Sin = Clamp ^ math.clamp( math.log( Argument1 / Max ) / math.log( Max2 / Max ), 0, 1 )
    end

    return Cos, Sin
end

local function PlayLand( WorldPosition, Object2 )
    local Clone3, Number
    local Parent = Instance.new( "Attachment" )
    Parent.Name = "AirdropLandSound"
    Parent.WorldPosition = WorldPosition
    Parent.Parent = workspace.Terrain

    local function Make( Name )
        local FoundChild = Object2:FindFirstChild( Name )

        if not FoundChild or not FoundChild:IsA( "Sound" ) then
            return nil, 0
        end
        local Clone = FoundChild:Clone( )
        Clone.RollOffMode = Enum.RollOffMode.Linear
        Clone.RollOffMinDistance = 9999
        Clone.RollOffMaxDistance = 10000
        Clone.Looped = false
        Clone.Parent = Parent
        return Clone, FoundChild.Volume
    end

    local LandClose = Object2:FindFirstChild( "LandClose" )

    if not LandClose or not LandClose:IsA( "Sound" ) then
        Clone3 = nil
        Number = 0
    else
        local Clone = LandClose:Clone( )
        Clone.RollOffMode = Enum.RollOffMode.Linear
        Clone.RollOffMinDistance = 9999
        Clone.RollOffMaxDistance = 10000
        Clone.Looped = false
        Clone.Parent = Parent
        Clone3 = Clone
        Number = LandClose.Volume
    end

    local Clone4, Number2
    local LandFar = Object2:FindFirstChild( "LandFar" )

    if not LandFar or not LandFar:IsA( "Sound" ) then
        Clone4 = nil
        Number2 = 0
    else
        local Clone2 = LandFar:Clone( )
        Clone2.RollOffMode = Enum.RollOffMode.Linear
        Clone2.RollOffMinDistance = 9999
        Clone2.RollOffMaxDistance = 10000
        Clone2.Looped = false
        Clone2.Parent = Parent
        Clone4 = Clone2
        Number2 = LandFar.Volume
    end

    local Magnitude2

    local function Update()
        local Magnitude2
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            local Magnitude = ( CurrentCamera.CFrame.Position - WorldPosition ).Magnitude

            if Magnitude then
                Magnitude2 = Magnitude
            else
                Magnitude2 = 0
            end
        else
            Magnitude2 = 0
        end

        local Value1, Value2 = LandGains( Magnitude2, Object2 )

        if Clone3 then
            Clone3.Volume = Number * Value1
        end
        if Clone4 then
            Clone4.Volume = Number2 * Value2
        end
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Magnitude = ( CurrentCamera.CFrame.Position - WorldPosition ).Magnitude

        if Magnitude then
            Magnitude2 = Magnitude
        else
            Magnitude2 = 0
        end
    else
        Magnitude2 = 0
    end

    local Value1, Value2 = LandGains( Magnitude2, Object2 )

    if Clone3 then
        Clone3.Volume = Number * Value1
    end
    if Clone4 then
        Clone4.Volume = Number2 * Value2
    end
    if Clone3 then
        Clone3:Play( )
    end
    if Clone4 then
        Clone4:Play( )
    end

    local Connect = RunService.RenderStepped:Connect( Update )
    local Clock = os.clock( )
    task.spawn( function()
        while true do
            task.wait( 0.25 )

            if os.clock( ) - Clock > 20 then
                break
            end
            if os.clock( ) - Clock > 1 then
                if not Clone3 or not Clone3.IsPlaying then
                    if not Clone4 or not Clone4.IsPlaying then
                        break
                    end
                end
            end
        end

        Connect:Disconnect( )
        Parent:Destroy( )
    end )
end

local Number = 0

local function ScheduleLand()
    Number = Number + 1
    local AirdropFallLand = ReplicatedStorage:GetAttribute( "AirdropFallLand" )
    local AirdropFallT1 = ReplicatedStorage:GetAttribute( "AirdropFallT1" )
    local AirdropKit = ReplicatedStorage:FindFirstChild( "AirdropKit" )

    if typeof( AirdropFallLand ) ~= "CFrame" or type( AirdropFallT1 ) ~= "number" or not AirdropKit then
        return
    end

    local AirdropFallT12 = AirdropFallT1 - workspace:GetServerTimeNow( )

    if AirdropFallT12 < -0.5 then
        return
    end

    local Value1
    local Table = { }
    local Table2 = { "LandClose", "LandFar" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local FoundChild = AirdropKit:FindFirstChild( Value )

        if FoundChild then
            table.insert( Table, FoundChild )
        end
    end

    task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, Table )
    task.delay( math.max( AirdropFallT12, 0 ), function()
        if Number ~= Number or ReplicatedStorage:GetAttribute( "AirdropFallT1" ) ~= AirdropFallT1 then
            return
        end
        PlayLand( AirdropFallLand.Position, AirdropKit )
        return
    end )
end

ReplicatedStorage:GetAttributeChangedSignal( "AirdropFallT0" ):Connect( ScheduleLand )
task.defer( ScheduleLand )

local function WatchFlare( Object )
    local Flare = Object:WaitForChild( "Flare", 10 )

    if not Flare then
        return
    end

    local Table = { }

    for Key, Value in Flare:GetDescendants( ) do
        if Value:IsA( "ParticleEmitter" ) and Value:GetAttribute( "VisibleDeLoin" ) == true then
            table.insert( Table, { pe = Value, acc = 0, base = Value.Size, k = 1 } )
        end
    end
    if #Table == 0 then
        return
    end
    local Connect = nil
    Connect = RunService.RenderStepped:Connect( function( Argument1 )
        if not Object.Parent then
            Connect:Disconnect( )
            return
        end

        local Magnitude3
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            local Magnitude = ( CurrentCamera.CFrame.Position - Flare.Position ).Magnitude

            if Magnitude then
                Magnitude3 = Magnitude
            else
                Magnitude3 = 0
            end
        else
            Magnitude3 = 0
        end

        local Value1 = nil

        for Key, Value in Table, nil, nil do
            local Pe = Value.pe

            if Pe.Parent then
                if Pe:GetAttribute( "VisibleDeLoin" ) == true then
                    if Pe.Enabled then
                        Pe.Enabled = false
                    end

                    Value.acc = Value.acc + Pe.Rate * math.min( Argument1, 0.1 )
                    local Floor = math.floor( Value.acc )

                    if Floor > 0 then
                        Value.acc = Value.acc - Floor
                        Pe:Emit( ( math.min( Floor, 6 ) ) )
                    end
                elseif not Pe.Enabled then
                    Pe.Enabled = true
                end

                local Magnitude2 = Magnitude3 / math.max( tonumber( Pe:GetAttribute( "TailleDe" ) ) or 400, 1 )
                local K = math.clamp( Magnitude2, 1, ( math.max( tonumber( Pe:GetAttribute( "TailleMax" ) ) or 8, 1 ) ) )
                local Abs = math.abs( K - Value.k )

                if 0.02 * Value.k < Abs then
                    local Value2
                    Value.k = K
                    local TableInner = { }
                    local Keypoints = Value.base.Keypoints
                    Value2 = nil

                    for Key2, Value3 in Keypoints, nil, nil do
                        table.insert( TableInner, NumberSequenceKeypoint.new( Value3.Time, Value3.Value * K, Value3.Envelope * K ) )
                    end

                    Pe.Size = NumberSequence.new( TableInner )
                end
            end
        end
    end )
    return
end

workspace.ChildAdded:Connect( function( Argument1 )
    if Argument1.Name == "AirdropFlare" then
        task.spawn( WatchFlare, Argument1 )
    end
end )
local AirdropFlare = workspace:FindFirstChild( "AirdropFlare" )

if AirdropFlare then
    task.spawn( WatchFlare, AirdropFlare )
end
