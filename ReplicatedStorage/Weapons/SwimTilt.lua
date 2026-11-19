-- ReplicatedStorage.Weapons.SwimTilt
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Eau = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Eau" ) )
local Identity = CFrame.identity
local Class = setmetatable( { }, { __mode = "k" } )
local AnimWorkers = require( script.Parent:WaitForChild( "AnimWorkers" ) )
local Players = game:GetService( "Players" )
local Class2 = setmetatable( { }, { __mode = "k" } )

local function Publish( Self, Argument2 )
    if AnimWorkers.IsWorker or AnimWorkers.COUNT <= 0 then
        return
    end

    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer or Self == LocalPlayer.Character then
        return
    end

    local NotActif2
    local NotActif = not Argument2.actif
    NotActif2 = if NotActif then not Argument2.nage else NotActif

    if NotActif2 and not Class2[ Self ] then
        return
    end

    local Id = AnimWorkers.Id( Self )

    if not Id then
        return
    end

    local Entry = AnimWorkers.Swim[ Id ]

    if Entry then
        local Actif
        local Rot = Argument2.rot
        local Vis = Argument2.vis
        Actif = Argument2.actif == true and true or false
        local Nage = Argument2.nage == true and true or false
        Entry.rot = Rot
        Entry.vis = Vis
        Entry.actif = Actif
        Entry.nage = Nage
    else
        local Actif2
        local Swim = AnimWorkers.Swim
        local Table = { rot = Argument2.rot, vis = Argument2.vis }
        Actif2 = Argument2.actif == true and true or false
        local Nage2
        Table.actif = Actif2
        Nage2 = Argument2.nage == true and true or false
        Table.nage = Nage2
        Swim[ Id ] = SharedTable.new( Table )
    end

    Class2[ Self ] = not NotActif2 or nil
end

local function Relayed( Argument1 )
    local Entry2
    local Id = AnimWorkers.Id( Argument1 )

    if Id then
        local Entry = AnimWorkers.Swim[ Id ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = nil
        end
    else
        Entry2 = nil
    end

    return Entry2
end

local function DansLEau( Self, Part, Humanoid, Argument4, EauT )
    if Argument4.eau == false and Argument4.eauT and EauT - Argument4.eauT < 0.1 then
        return false
    end
    if Humanoid.Health <= 0 or Humanoid.Sit or Humanoid.SeatPart ~= nil or Humanoid.PlatformStand then
        return false
    end
    if Self:GetAttribute( "Downed" ) or Self:GetAttribute( "CarRagdoll" ) then
        return false
    end
    if not Argument4.eauT or EauT - Argument4.eauT >= 0.1 then
        local EauInner
        Argument4.eauT = EauT
        local Profondeur = Eau.Profondeur( Part.Position )

        if Profondeur == nil then
            EauInner = false
        elseif Profondeur > 0.1 then
            EauInner = true
        else
            EauInner = false
        end

        Argument4.eau = EauInner
    end

    return Argument4.eau
end

return {
    Update = function( Self, Part, Humanoid, Argument4, Argument5 )
        local Entry2
        local T = os.clock( )
        local Entry = Class[ Self ]

        if Entry then
            Entry2 = Entry
        else
            local Table = { rot = Identity, vis = Identity, t = T }
            Class[ Self ] = Table
            Entry2 = Table
        end

        local DansLEau2

        if Argument5 == nil then
            DansLEau2 = DansLEau( Self, Part, Humanoid, Entry2, T )
        else
            Value1 = Argument5
        end

        local Nage = Value1 == true and true or false
        Entry2.nage = Nage

        if not Value1 and rawequal( Entry2.rot, Identity ) and rawequal( Entry2.vis, Identity ) then
            Entry2.depuis = nil
            Entry2.t = T
            Entry2.actif = false
            Publish( Self, Entry2 )
            return nil, nil
        end

        local FromAxisAngle, FromAxisAngle2

        if Value1 then
            Entry2.depuis = Entry2.depuis or T

            if Argument4 or not ( T - Entry2.depuis >= 0.25 ) then
                FromAxisAngle = Identity
                FromAxisAngle2 = Identity
            else
                local AssemblyLinearVelocity = Part.AssemblyLinearVelocity
                local Magnitude = AssemblyLinearVelocity.Magnitude
                local Clamp = math.clamp( ( Magnitude - 1.5 ) / 3, 0, 1 )

                if Clamp > 0 then
                    local Unit
                    local AssemblyLinearVelocity2 = AssemblyLinearVelocity / Magnitude
                    local Acos = math.acos( ( math.clamp( AssemblyLinearVelocity2.Y, -1, 1 ) ) )
                    local Cross = Vector3.new( 0, 1, 0 ):Cross( AssemblyLinearVelocity2 )
                    Unit = Cross.Magnitude > 0.05 and Cross.Unit or -Part.CFrame.RightVector
                    local VectorToObjectSpace = Part.CFrame:VectorToObjectSpace( Unit )
                    FromAxisAngle = CFrame.fromAxisAngle( VectorToObjectSpace, math.max( Acos - 0.3141592653589793, 0 ) * Clamp )
                    FromAxisAngle2 = CFrame.fromAxisAngle( VectorToObjectSpace, Acos * Clamp )
                else
                    FromAxisAngle = Identity
                    FromAxisAngle2 = Identity
                end
            end
        else
            Entry2.depuis = nil
            FromAxisAngle = Identity
            FromAxisAngle2 = Identity
        end

        local Exp = 1 - math.exp( math.clamp( T - Entry2.t, 0, 0.1 ) * -7 )
        Entry2.t = T
        Entry2.rot = Entry2.rot:Lerp( FromAxisAngle, Exp )
        Entry2.vis = Entry2.vis:Lerp( FromAxisAngle2, Exp )
        local _, ToAxisAngle2 = Entry2.vis:ToAxisAngle( )

        if not ( ToAxisAngle2 < 0.002 ) then
            Entry2.actif = true
            Publish( Self, Entry2 )
            return Entry2.rot, Entry2.vis
        end
        if FromAxisAngle == Identity then
            Entry2.rot = Identity
            Entry2.vis = Identity
        end

        Entry2.actif = false
        Publish( Self, Entry2 )
        return nil, nil
    end,
    EnNage = function( NageName )
        if AnimWorkers.IsWorker then
            local Entry2
            local Id = AnimWorkers.Id( NageName )

            if Id then
                local Entry = AnimWorkers.Swim[ Id ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = nil
                end
            else
                Entry2 = nil
            end

            local Flag

            if Entry2 == nil then
                Flag = false
            elseif Entry2.nage == true then
                Flag = true
            else
                Flag = false
            end

            return Flag
        end
        local Flag2
        local Entry3 = Class[ NageName ]

        if Entry3 == nil then
            Flag2 = false
        elseif Entry3.nage == true then
            Flag2 = true
        else
            Flag2 = false
        end

        return Flag2
    end,
    Get = function( Key )
        if AnimWorkers.IsWorker then
            local Entry2
            local Id = AnimWorkers.Id( Key )

            if Id then
                local Entry = AnimWorkers.Swim[ Id ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = nil
                end
            else
                Entry2 = nil
            end
            if not Entry2 or not Entry2.actif then
                return nil, nil
            end
            return Entry2.rot, Entry2.vis
        else
            local Entry3 = Class[ Key ]

            if not Entry3 or not Entry3.actif then
                return nil, nil
            end
            return Entry3.rot, Entry3.vis
        end
    end,
    Root = function( Argument1, Argument2 )
        return Argument2:Inverse( ) * CFrame.new( Vector3.new( 0, 0.75, 0 ) ) * Argument1 * CFrame.new( Vector3.new( -0, -0.75, -0 ) ) * Argument2
    end,
    Neck = function( Argument1 )
        return Identity:Lerp( Argument1:Inverse( ), 0.6 )
    end
}
