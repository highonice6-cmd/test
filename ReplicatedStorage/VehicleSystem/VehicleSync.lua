-- ReplicatedStorage.VehicleSystem.VehicleSync
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
game:GetService( "Players" )
local Table = { SEND_HZ = 30, MAX_AGE = 0.35, STALE = 0.4, CORRECTION = 8, SNAP = 25 }
function Table.Extrapolate( Argument1, Argument2, Argument3, Argument4, Argument5 )
    local Position, FromAxisAngle
    local Total = Argument5 - Argument4
    local Clamp = math.clamp( Total, 0, Table.MAX_AGE )
    local Rotation = Argument1.Rotation
    local Magnitude = Argument3.Magnitude

    if Magnitude > 0.001 then
        local Magnitude2 = Argument3 / Magnitude
        local Magnitude3 = Magnitude * Clamp
        local Magnitude4 = Magnitude2 * Magnitude2:Dot( Argument2 )
        Position = Argument1.Position + ( Argument2 - Magnitude4 ) * ( math.sin( Magnitude3 ) / Magnitude ) + Magnitude2:Cross( Argument2 ) * ( ( 1 - math.cos( Magnitude3 ) ) / Magnitude ) + Magnitude4 * Clamp
        FromAxisAngle = CFrame.fromAxisAngle( Magnitude2, Magnitude3 ) * Rotation
    else
        Position = Argument1.Position + Argument2 * Clamp
        FromAxisAngle = Rotation
    end

    return CFrame.new( Position ) * FromAxisAngle
end

local function Fade( Argument1, Argument2 )
    return ( 1 - math.exp( -Argument1 * Argument2 ) ) / Argument1
end

local function Nudged( Argument1, Argument2, ServerTimeNow )
    local Nudge = Argument1.nudge

    if not Nudge then
        return Argument2
    end

    local Rotation2
    local Clamp = math.clamp( ServerTimeNow - Nudge.t0, 0, 0.6 )
    local Rotation = Argument2.Rotation
    local Magnitude = Nudge.dw.Magnitude
    Rotation2 = if Magnitude > 0.0001 then CFrame.fromAxisAngle( Nudge.dw / Magnitude, Magnitude * ( ( 1 - math.exp( -4 * Clamp ) ) / 4 ) ) * Rotation else Rotation
    return CFrame.new( Argument2.Position + Nudge.dv * ( ( 1 - math.exp( -2.5 * Clamp ) ) / 2.5 ) ) * Rotation2
end

local function NudgeVel( Entry, Argument2 )
    local Nudge = Entry.nudge

    if Nudge then
        local Clamp = math.clamp( Argument2 - Nudge.t0, 0, 0.6 )
        return Entry.vel + Nudge.dv * math.exp( Clamp * -2.5 ), Entry.ang + Nudge.dw * math.exp( Clamp * -4 )
    end
    return Entry.vel, Entry.ang
end

local SyncState = script.Parent:WaitForChild( "SyncState" )
local NetLag = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "NetLag" ) )
local Table2 = { }
local Table3 = { }
function Table.SetOwned( OwnedName, Argument2 )
    Table2[ OwnedName ] = Argument2

    if Argument2 then
        Table3[ OwnedName ] = nil
    end
end
local Flag = false
function Table.StartClient()
    if Flag then
        return
    end
    Flag = true
    local Number = 0
    RunService.Heartbeat:Connect( function( Argument1 )
        Number = Number + Argument1

        if Number < 1 / Table.SEND_HZ then
            return
        end

        local Value1
        Number = 0
        local ServerTimeNow = workspace:GetServerTimeNow( )
        Value1 = nil

        for Key, Value in Table2, nil, nil do
            if not Key.Parent or not Value.Parent or Value.Anchored then
                Table2[ Key ] = nil
            else
                local Out = NetLag.Out
                local FireServer = SyncState.FireServer
                local CFrame = Value.CFrame
                local AssemblyLinearVelocity = Value.AssemblyLinearVelocity
                Out( FireServer, SyncState, Key, CFrame, AssemblyLinearVelocity, Value.AssemblyAngularVelocity, ServerTimeNow )
            end
        end
    end )
    SyncState.OnClientEvent:Connect( NetLag.Wrap( function( Key, Cf, Vel, Ang, Stamp )
        if typeof( Key ) ~= "Instance" or Table2[ Key ] then
            return
        end

        local Root = Key:FindFirstChild( "VehicleRoot" )

        if not Root then
            return
        end

        local Entry = Table3[ Key ]

        if Entry and Stamp <= Entry.stamp then
            return
        end

        local Table2Inner
        local ServerTimeNow = workspace:GetServerTimeNow( )
        local Extrapolate = Table.Extrapolate( Cf, Vel, Ang, Stamp, ServerTimeNow )

        if Entry then
            if Entry.active then
                local Nudge2
                local Extrapolate2 = Table.Extrapolate
                local Cf2 = Entry.cf
                local Vel2 = Entry.vel
                local Ang2 = Entry.ang
                local Extrapolate3 = Extrapolate2( Cf2, Vel2, Ang2, Entry.stamp, ServerTimeNow ) * Entry.offset
                local Nudge = Entry.nudge

                if Nudge then
                    if Nudge.dv.Magnitude > 0.1 then
                        local Dot = ( Vel - Nudge.v0 ):Dot( Nudge.dv.Unit )

                        if 0.4 * Nudge.dv.Magnitude <= Dot then
                            Nudge2 = true
                        else
                            Nudge2 = false
                        end
                    else
                        Nudge2 = false
                    end
                else
                    Nudge2 = Nudge
                end
                if Nudge then
                    if Nudge2 or ServerTimeNow - Nudge.t0 > 0.6 then
                        Entry.offset = Extrapolate:Inverse( ) * Nudged( Entry, Extrapolate3, ServerTimeNow )
                        Entry.nudge = nil
                        Table2Inner = Entry
                    else
                        Entry.offset = Extrapolate:Inverse( ) * Extrapolate3
                        Table2Inner = Entry
                    end
                else
                    Entry.offset = Extrapolate:Inverse( ) * Extrapolate3
                    Table2Inner = Entry
                end
            else
                Entry.offset = Extrapolate:Inverse( ) * Root.CFrame
                Table2Inner = Entry
            end
        else
            local TableInner = { root = Root }
            Table3[ Key ] = TableInner
            TableInner.offset = Extrapolate:Inverse( ) * Root.CFrame
            Table2Inner = TableInner
        end

        local Magnitude = Table2Inner.offset.Position.Magnitude

        if Table.SNAP < Magnitude then
            Table2Inner.offset = CFrame.identity
        end

        local Received = os.clock( )
        Table2Inner.root = Root
        Table2Inner.cf = Cf
        Table2Inner.vel = Vel
        Table2Inner.ang = Ang
        Table2Inner.stamp = Stamp
        Table2Inner.received = Received
        Table2Inner.active = true
    end ) )

    local function Apply( Argument1 )
        local Value1
        local ServerTimeNow = workspace:GetServerTimeNow( )
        local Clock = os.clock( )
        local Exp = 1 - math.exp( -Table.CORRECTION * Argument1 )
        Value1 = nil

        for Key, Value in Table3, nil, nil do
            local Root = Value.root

            if not Key.Parent or not Root.Parent or Table2[ Key ] then
                Table3[ Key ] = nil
            else
                local Clock2 = Clock - Value.received

                if Table.STALE < Clock2 then
                    Table3[ Key ] = nil
                else
                    Value.offset = Value.offset:Lerp( CFrame.identity, Exp )

                    if Value.nudge and ServerTimeNow - Value.nudge.t0 > 0.6 then
                        local Extrapolate = Table.Extrapolate
                        local Cf = Value.cf
                        local Vel = Value.vel
                        local Ang = Value.ang
                        local Inverse = Extrapolate( Cf, Vel, Ang, Value.stamp, ServerTimeNow ):Inverse( )
                        local Extrapolate2 = Table.Extrapolate
                        local Cf2 = Value.cf
                        local Vel2 = Value.vel
                        local Ang2 = Value.ang
                        Value.offset = Inverse * Nudged( Value, Extrapolate2( Cf2, Vel2, Ang2, Value.stamp, ServerTimeNow ) * Value.offset, ServerTimeNow )
                        Value.nudge = nil
                    end

                    local AssemblyLinearVelocity, AssemblyAngularVelocity
                    local Extrapolate3 = Table.Extrapolate
                    local Cf3 = Value.cf
                    local Vel3 = Value.vel
                    local Ang3 = Value.ang
                    Root.CFrame = Nudged( Value, Extrapolate3( Cf3, Vel3, Ang3, Value.stamp, ServerTimeNow ) * Value.offset, ServerTimeNow )
                    local Nudge = Value.nudge

                    if Nudge then
                        local Clamp = math.clamp( ServerTimeNow - Nudge.t0, 0, 0.6 )
                        AssemblyLinearVelocity = Value.vel + Nudge.dv * math.exp( Clamp * -2.5 )
                        AssemblyAngularVelocity = Value.ang + Nudge.dw * math.exp( Clamp * -4 )
                    else
                        AssemblyLinearVelocity = Value.vel
                        AssemblyAngularVelocity = Value.ang
                    end

                    Root.AssemblyLinearVelocity = AssemblyLinearVelocity
                    Root.AssemblyAngularVelocity = AssemblyAngularVelocity
                end
            end
        end
    end

    RunService.PreSimulation:Connect( Apply )
    RunService:BindToRenderStep( "VehicleSync", Enum.RenderPriority.First.Value, function( Argument1 )
        Apply( 0 )
    end )
    return
end
function Table.RemoteState( StateName )
    local Entry = Table3[ StateName ]

    if Entry and Entry.active and not Table2[ StateName ] then
        local Clock = os.clock( ) - Entry.received

        if not ( Table.STALE < Clock ) then
            return NudgeVel( Entry, workspace:GetServerTimeNow( ) )
        end
    end

    return nil
end
function Table.Nudge( Key, Argument2, Argument3 )
    local Entry = Table3[ Key ]

    if not Entry or not Entry.active then
        return false
    end
    if Entry.nudge then
        local Nudge = Entry.nudge
        Nudge.dv = Nudge.dv + Argument2
        local Nudge2 = Entry.nudge
        Nudge2.dw = Nudge2.dw + Argument3
    else
        Entry.nudge = {
            t0 = workspace:GetServerTimeNow( ),
            dv = Argument2,
            dw = Argument3,
            v0 = Entry.vel
        }
    end

    return true
end
function Table.Debug( Key )
    return Table3[ Key ]
end
return Table
