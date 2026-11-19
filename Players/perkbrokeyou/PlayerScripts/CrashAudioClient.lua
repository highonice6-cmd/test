-- Players.perkbrokeyou.PlayerScripts.CrashAudioClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local Debris = game:GetService( "Debris" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local Config = require( ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "Config" ) )
local Eau = require( ReplicatedStorage:WaitForChild( "Eau" ) )
local BodySparks = require( ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "BodySparks" ) )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local VehicleAction = ReplicatedStorage:WaitForChild( "VehicleSystem" ):WaitForChild( "VehicleAction" )

local function DrivenByMe( Argument1 )
    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    local IsDescendantOf

    if Character2 == nil then
        IsDescendantOf = false
    elseif Character2:GetAttribute( "Role" ) == "Driver" then
        IsDescendantOf = Character2:IsDescendantOf( Argument1 )
    else
        IsDescendantOf = false
    end

    return IsDescendantOf
end

local Table = {
    Light = {
        volume = { 0.18, 0.4 },
        hauteur = { 1.06, 0.98 },
        pres = 24,
        portee = 110
    },
    Medium = {
        volume = { 0.38, 0.55 },
        hauteur = { 1.03, 0.95 },
        pres = 28,
        portee = 190
    },
    Strong = { volume = { 0.3, 0.5 }, hauteur = { 1, 0.9 }, pres = 32, portee = 300 }
}
local Table2 = { }

local function Suivre( Key )
    if not Table2[ Key ] then
        Table2[ Key ] = { depuis = 0, dernier = 0 }
    end
end

for Key, Value in CollectionService:GetTagged( "Vehicle" ) do
    if not Table2[ Value ] then
        Table2[ Value ] = { depuis = 0, dernier = 0 }
    end
end

CollectionService:GetInstanceAddedSignal( "Vehicle" ):Connect( Suivre )
CollectionService:GetInstanceRemovedSignal( "Vehicle" ):Connect( function( Key )
    Table2[ Key ] = nil
end )
local Table3 = { }
local Number = 0

local function Jouer( Argument1, Dernier )
    local Force2, Text
    local Cfg = Argument1.st.cfg
    local Force = Argument1.force

    if Force >= 85 then
        Force2 = ( Force - 85 ) / 55
        Text = "Strong"
    elseif Force >= 35 then
        Force2 = ( Force - 35 ) / 50
        Text = "Medium"
    else
        Force2 = ( Force - 8 ) / 27
        Text = "Light"
    end

    local CrashSounds2
    local Clamp = math.clamp( Force2, 0, 1 )
    local Entry = Table[ Text ]
    local CrashSounds = Cfg.CrashSounds
    CrashSounds2 = if CrashSounds then Cfg.CrashSounds[ Text ] else CrashSounds

    if not CrashSounds2 then
        return
    end

    local Count = #Table3
    local I = Count

    for I = Count, 1, -1 do
        local Entry2 = Table3[ I ]

        if Dernier - Entry2.t > 0.1 then
            table.remove( Table3, I )
        elseif ( Entry2.pos - Argument1.pos ).Magnitude < 35 and Force * 0.7 <= Entry2.force then
            return
        end
    end

    local Magnitude2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Magnitude = ( CurrentCamera.CFrame.Position - Argument1.pos ).Magnitude

        if Magnitude then
            Magnitude2 = Magnitude
        else
            Magnitude2 = 0
        end
    else
        Magnitude2 = 0
    end
    if Entry.portee < Magnitude2 or Number >= 8 then
        return
    end

    local SoundId
    table.insert( Table3, { t = Dernier, pos = Argument1.pos, force = Force } )
    local Volume = ( Entry.volume[ 1 ] + ( Entry.volume[ 2 ] - Entry.volume[ 1 ] ) * Clamp ) * ( Cfg.CrashVolume or 1 )
    local PlaybackSpeed = ( Entry.hauteur[ 1 ] + ( Entry.hauteur[ 2 ] - Entry.hauteur[ 1 ] ) * Clamp ) * ( 1 + ( ( Cfg.ImpactPitch or 1.2 ) - 1.2 ) * 0.35 ) * ( 1 + ( math.random( ) * 2 - 1 ) * 0.05 )
    local Parent = Instance.new( "Attachment" )
    Parent.Name = "ChocSon"
    Parent.Parent = Argument1.root
    Parent.WorldPosition = Argument1.pos
    local Sound = Instance.new( "Sound" )
    Sound.Name = "Choc" .. Text
    SoundId = type( CrashSounds2 ) == "number" and "rbxassetid://" .. CrashSounds2 or CrashSounds2
    Sound.SoundId = SoundId
    Sound.Volume = Volume
    Sound.PlaybackSpeed = PlaybackSpeed
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered
    local RollOffMinDistance = Entry.pres
    local RollOffMaxDistance = Entry.portee
    Sound.RollOffMinDistance = RollOffMinDistance
    Sound.RollOffMaxDistance = RollOffMaxDistance
    Sound.SoundGroup = SoundService:FindFirstChild( "Master_Vehicles" )
    Sound.Parent = Parent
    Sound:Play( )
    Number = Number + 1
    local Item = 1 / PlaybackSpeed + 0.3
    task.delay( Item, function()
        Number = Number - 1
    end )
    Debris:AddItem( Parent, Item )

    if workspace:GetAttribute( "DebugCrash" ) then
        print( ( "[CHOC] %s : violence %.1f studs/s -> %s, volume %.2f, hauteur %.2f, à %.0f studs" ):format( Argument1.model.Name, Force, Text, Volume, PlaybackSpeed, Magnitude2 ) )
    end
end

RunService:BindToRenderStep( "CrashAudio", Enum.RenderPriority.First.Value + 1, function( Argument1 )
    local Value1, Table
    local Dernier = os.clock( )
    Value1 = nil
    Table = nil

    for Key, Value in Table2, nil, nil do
        local Root3
        local Root = Value.root

        if not Root or Root.Parent ~= Key then
            local Root2 = Key:FindFirstChild( "VehicleRoot" )
            Value.root = Root2
            Value.v = nil

            if Root2 then
                local VehicleConfig2
                local Get = Config.Get
                local VehicleConfig = Key:GetAttribute( "VehicleConfig" )
                VehicleConfig2 = if VehicleConfig then VehicleConfig else Key.Name
                local Cfg
                local Get2 = Get( VehicleConfig2 )
                Cfg = if Get2 then Get2 else Config.Default
                Value.cfg = Cfg
                Root3 = Root2
            else
                Root3 = Root2
            end
        else
            Root3 = Root
        end
        if Root3 then
            local Anchored = Root3.Anchored

            if not Anchored or BodySparks.Active( Key ) then
                BodySparks.Update( Key, Root3, Argument1 )
            end
            if Anchored then
                Value.v = nil
            else
                local V = Root3.AssemblyLinearVelocity
                local Pos = Root3.Position
                local V2 = Value.v
                local Pos2 = Value.pos
                Value.pos = Pos

                if V2 then
                    local AssemblyLinearVelocity = V - V2

                    if AssemblyLinearVelocity.Magnitude < 0.05 then
                        Value.depuis = Value.depuis + Argument1
                    else
                        local Number
                        local Depuis = Value.depuis + Argument1
                        Value.v = V
                        Value.depuis = 0
                        Number = not ( Root3.CFrame.UpVector.Y > 0.7 ) and 1 or 0.5
                        local X = AssemblyLinearVelocity.X
                        local Y = AssemblyLinearVelocity.Y * Number
                        local Vector32 = Vector3.new( X, Y, AssemblyLinearVelocity.Z )
                        local Magnitude = Vector32.Magnitude

                        if not ( Magnitude < 4 + 110 * Depuis ) and not ( Dernier - Value.dernier < 0.22 ) then
                            local Magnitude2 = ( Pos - Pos2 ).Magnitude

                            if not ( V2.Magnitude * Argument1 * 3 + 15 < Magnitude2 ) and not Eau.Profondeur( Pos ) then
                                local Min2
                                local X2 = V2.X
                                local Y2 = V2.Y * Number
                                local Vector33 = Vector3.new( X2, Y2, V2.Z )
                                local Vector34 = Vector32 / Magnitude
                                local Amount = -Vector33:Dot( Vector34 )
                                local Min = math.min( Amount, Vector33.Magnitude )
                                Min2 = 0.5 * Magnitude < Min and Min or Magnitude

                                if not ( Min2 < 8 ) then
                                    local Humanoid
                                    local Impact = BodySparks.Impact
                                    Impact( Key, Root3, -Vector34, Min2, V2 )
                                    Value.dernier = Dernier
                                    local Character = LocalPlayer.Character

                                    if Character then
                                        Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
                                    else
                                        Humanoid = Character
                                    end

                                    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
                                    local IsDescendantOf

                                    if Character2 == nil then
                                        IsDescendantOf = false
                                    elseif Character2:GetAttribute( "Role" ) == "Driver" then
                                        IsDescendantOf = Character2:IsDescendantOf( Key )
                                    else
                                        IsDescendantOf = false
                                    end
                                    if IsDescendantOf then
                                        VehicleAction:FireServer( "Crash" )
                                    end

                                    local Table2Inner = if Table then Table else { }
                                    table.insert( Table2Inner, {
                                        model = Key,
                                        st = Value,
                                        root = Root3,
                                        force = Min2,
                                        pos = Pos - Vector34 * 5
                                    } )
                                    Table = Table2Inner
                                end
                            end
                        end
                    end
                else
                    Value.v = V
                    Value.depuis = 0
                end
            end
        end
    end
    if Table then
        local Value2
        table.sort( Table, function( Argument1, Argument2 )
            local Flag
            local Force = Argument1.force
            Flag = Argument2.force < Force and true or false
            return Flag
        end )
        Value2 = nil

        for Key2, Value3 in Table, nil, nil do
            Jouer( Value3, Dernier )
        end
    end
end )
