-- ReplicatedStorage.Weapons.HealAnim
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Parent = script.Parent
local Config = require( Parent:WaitForChild( "Config" ) )
local ClientState = require( Parent:WaitForChild( "ClientState" ) )
local ArmIK = require( Parent:WaitForChild( "ArmIK" ) )
local AnimWorkers = require( Parent:WaitForChild( "AnimWorkers" ) )
local ObjetTenu = require( Parent:WaitForChild( "ObjetTenu" ) )
local Heal = Config.Heal
local Drink = Config.Drink
local LocalPlayer = Players.LocalPlayer

local function Smooth( Argument1 )
    local Clamp = math.clamp( Argument1, 0, 1 )
    return Clamp * Clamp * ( 3 - 2 * Clamp )
end

local function Basis( Argument1, Argument2 )
    local Unit = Argument1.Unit
    return CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, ( Argument2 - Unit * Argument2:Dot( Unit ) ).Unit )
end

local Unit = Vector3.new( 0, 0, -1 ).Unit
local FromMatrix = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit, ( Vector3.new( 1, 0.3499999940395355, 0 ) - Unit * Vector3.new( 1, 0.3499999940395355, 0 ):Dot( Unit ) ).Unit )
local Unit2 = Vector3.new( 0, 0, 1 ).Unit
local FromMatrix2 = CFrame.fromMatrix( Vector3.new( 0, 0, 0 ), Unit2, ( Vector3.new( -1, 0.3499999940395355, 0 ) - Unit2 * Vector3.new( -1, 0.3499999940395355, 0 ):Dot( Unit2 ) ).Unit )
local Table = {
    Bandage = function( Amount, Argument2 )
        local Max = math.max( 0, Amount - 0.12 ) * 3.141592653589793 * 2 * 2.4
        local Clamp = math.clamp( ( Amount - 0.12 ) / 0.2, 0, 1 ) * math.clamp( ( Argument2 - Amount - 0.1 ) / 0.2, 0, 1 )
        local Cos = math.cos( Max ) * 0.13
        return CFrame.new( Vector3.new( 0.11999999731779099, 0.11999999731779099, -0.8500000238418579 ) + Vector3.new( Cos, math.sin( Max ) * 0.11, 0 ) * Clamp ) * FromMatrix * CFrame.Angles( 0, 0, math.sin( Max ) * 0.25 * Clamp ), nil, -0.32, -0.12
    end,
    Medkit = function( Amount, Amount2 )
        local Max2
        local Clamp = math.clamp( Amount / 0.45, 0, 1 )
        local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
        local Sin = math.sin( math.max( 0, Amount - 0.5 ) * 3.141592653589793 * 2 * 1.3 )
        local Clamp3 = math.clamp( ( Amount - 0.5 ) / 0.3, 0, 1 )
        local Sin2 = Sin * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
        local Clamp4 = math.clamp( ( Amount2 - 0.35 - Amount ) / 0.3, 0, 1 )
        local Sin3 = Sin2 * ( Clamp4 * Clamp4 * ( 3 - 2 * Clamp4 ) )
        local Sin4 = 0.02 + 0.04 * Sin3
        local Vector32 = Vector3.new( 0.05, Sin4, -1.08 + 0.05 * Sin3 )
        local CFrame2 = CFrame.new( ( Vector32:Lerp( Vector3.new( 0.30000001192092896, -0.25, -1.2999999523162842 ), 1 - Clamp2 ) ) ) * FromMatrix * CFrame.Angles( 0.15 * Sin3, 0, 0 )
        local Max = math.max( 0, Amount - 0.6 ) / 0.9 % 1
        Max2 = Max < 0.5 and Max * 2 or ( 1 - Max ) * 2
        local Clamp5 = math.clamp( Max2, 0, 1 )
        local Clamp6 = Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 )
        local Clamp7 = math.clamp( ( Amount - 0.6 ) / 0.25, 0, 1 )
        local Clamp8 = Clamp7 * Clamp7 * ( 3 - 2 * Clamp7 )
        local Clamp9 = math.clamp( ( Amount2 - 0.4 - Amount ) / 0.25, 0, 1 )
        local Clamp10 = Clamp8 * ( Clamp9 * Clamp9 * ( 3 - 2 * Clamp9 ) )
        return CFrame2, CFrame.new( ( Vector3.new( -0.44999998807907104, -0.10000000149011612, -1.0499999523162842 ):Lerp( Vector3.new( -0.25, 0.3199999928474426, -0.6600000262260437 ), Clamp6 * Clamp10 ) ) ) * FromMatrix2 * CFrame.Angles( 0, 0, -0.3 * Clamp6 * Clamp10 ), -0.45, -0.2
    end
}
local Class = setmetatable( { }, { __mode = "k" } )

local function Tilt( Neck, Argument2 )
    local GetT
    local Entry = Class[ Neck ]

    if not Entry or AnimWorkers.getT( Neck ) ~= Entry.value or not Entry.base then
        GetT = AnimWorkers.getT( Neck )
    else
        GetT = Entry.base
    end

    local Base = GetT * Argument2
    AnimWorkers.setT( Neck, Base )
    Class[ Neck ] = { value = Base, base = GetT }
end

local function Untilt( Key )
    if not ( Key and Class[ Key ] ) then
        return
    end
    if AnimWorkers.getT( Key ) == ( Key and Class[ Key ] ).value then
        local SetT = AnimWorkers.setT
        SetT( Key, ( Key and Class[ Key ] ).base )
    end

    Class[ Key ] = nil
end

local function JointOf( Object, Name, Name2 )
    local FoundChild2
    local FoundChild = Object:FindFirstChild( Name )
    FoundChild2 = if FoundChild then FoundChild:FindFirstChild( Name2 ) else FoundChild
    return FoundChild2
end

local function HealInfo( Character )
    if Character == LocalPlayer.Character and ClientState.HealItem then
        return ClientState.HealItem, os.clock( ) - ClientState.HealStart
    end

    local HealItem = Character:GetAttribute( "HealItem" )
    local HealStart = Character:GetAttribute( "HealStart" )

    if not HealItem or not HealStart then
        return nil
    end
    return HealItem, workspace:GetServerTimeNow( ) - HealStart
end

local function SetGrip( Character, Argument2, Argument3 )
    local Of
    local Tool = Character:FindFirstChildOfClass( "Tool" )

    if Tool then
        local Item = Tool:GetAttribute( "Item" )

        if Item then
            Of = ObjetTenu.Of( Tool )
        else
            Of = Item
        end
    else
        Of = Tool
    end
    if not Of or not Argument2 then
        return
    end

    local Carry = Argument2.Carry
    local Lerp = Carry:Lerp( Argument2.Press, Argument3 )

    for Key, Value in Of:GetChildren( ) do
        if Value.Name == "ItemGrip" and Value:IsA( "Weld" ) then
            AnimWorkers.setC0( Value, Lerp )
        end
    end
end

local function DrinkInfo( Object )
    if Object == LocalPlayer.Character and ClientState.DrinkStart then
        local Clock = os.clock( ) - ClientState.DrinkStart

        if Clock <= Drink.Time then
            return Clock
        end

        ClientState.DrinkStart = nil
    end

    local ServerTimeNow2
    local DrinkStart = Object:GetAttribute( "DrinkStart" )

    if DrinkStart then
        local ServerTimeNow = workspace:GetServerTimeNow( ) - DrinkStart

        if ServerTimeNow then
            ServerTimeNow2 = ServerTimeNow
        else
            ServerTimeNow2 = nil
        end
    else
        ServerTimeNow2 = nil
    end

    return ServerTimeNow2
end

local function SetDrinkGrip( Object, Argument2 )
    local Of
    local Tool = Object:FindFirstChildOfClass( "Tool" )

    if Tool then
        if Tool:GetAttribute( "Item" ) == "EDrink" then
            Of = ObjetTenu.Of( Tool )
        else
            Of = false
        end
    else
        Of = Tool
    end
    if not Of then
        return
    end

    local Carry = Drink.Carry
    local Lerp = Carry:Lerp( Drink.DrinkGrip, Argument2 )

    for Key, Value in Of:GetChildren( ) do
        if Value.Name == "ItemGrip" or Value.Name == "LocalGrip" then
            if Value:IsA( "Weld" ) then
                AnimWorkers.setC0( Value, Lerp )
            end
        end
    end
end

local function DrinkUpdate( Object2 )
    local DrinkInfo2 = DrinkInfo( Object2 )
    local Time = Drink.Time

    if not DrinkInfo2 or DrinkInfo2 < 0 or Time < DrinkInfo2 then
        return false
    end

    local Value2
    local Clamp = math.clamp( DrinkInfo2 / Drink.Raise, 0, 1 )
    local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
    local Clamp3 = math.clamp( ( Time - DrinkInfo2 ) / Drink.Lower, 0, 1 )
    local Clamp4 = Clamp2 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
    local Clamp5 = math.clamp( DrinkInfo2 / Drink.Edge, 0, 1 )
    local Clamp6 = Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 )
    local Clamp7 = math.clamp( ( Time - DrinkInfo2 ) / Drink.Edge, 0, 1 )
    local Clamp8 = Clamp6 * ( Clamp7 * Clamp7 * ( 3 - 2 * Clamp7 ) )
    SetDrinkGrip( Object2, Clamp4 )
    local Table = {
        { "RightUpperArm", "RightShoulder" },
        { "RightLowerArm", "RightElbow" },
        { "RightHand", "RightWrist" }
    }
    Value2 = nil

    for Key, Value in Table, nil, nil do
        local FoundChild2
        local Item = Value[ 1 ]
        local Item2 = Value[ 2 ]
        local FoundChild = Object2:FindFirstChild( Item )

        if FoundChild then
            FoundChild2 = FoundChild:FindFirstChild( Item2 )
        else
            FoundChild2 = FoundChild
        end

        local Entry = Drink.Rest[ Value[ 2 ] ]
        local Entry2 = Drink.Joints[ Value[ 2 ] ]

        if FoundChild2 and Entry and Entry2 then
            local SetT = AnimWorkers.setT
            local GetT = AnimWorkers.getT( FoundChild2 )
            SetT( FoundChild2, GetT:Lerp( Entry:Lerp( Entry2, Clamp4 ), Clamp8 ) )
        end
    end

    return true
end

return {
    Update = function()
        for Key, Value in Players:GetPlayers( ) do
            local Character = Value.Character

            if not Character or AnimWorkers.Owns( Character ) then
                local Humanoid

                if Character then
                    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
                else
                    Humanoid = Character
                end
                if Humanoid and not ( Humanoid.Health <= 0 ) then
                    local Tool2
                    local Tool = Character:FindFirstChildOfClass( "Tool" )
                    Tool2 = if Tool then Heal.Items[ Tool:GetAttribute( "Item" ) or "" ] else Tool
                    local Entry
                    local Value1, Value2 = HealInfo( Character )
                    Entry = if Value1 then Heal.Items[ Value1 ] else Value1

                    if not Entry or Value2 < 0 or Entry.Time < Value2 then
                        if not DrinkUpdate( Character ) then
                            local Neck2
                            SetGrip( Character, Tool2, 0 )
                            SetDrinkGrip( Character, 0 )
                            local Head2 = Character:FindFirstChild( "Head" )

                            if Head2 then
                                Neck2 = Head2:FindFirstChild( "Neck" )
                            else
                                Neck2 = Head2
                            end

                            local Head3 = if Neck2 then Class[ Neck2 ] else Neck2

                            if Head3 then
                                if AnimWorkers.getT( Neck2 ) == Head3.value then
                                    local SetT2 = AnimWorkers.setT
                                    SetT2( Neck2, Head3.base )
                                end

                                Class[ Neck2 ] = nil
                            end
                        end
                    else
                        local Neck
                        local Time = Entry.Time
                        local Clamp = math.clamp( Value2 / 0.22, 0, 1 )
                        local Clamp2 = Clamp * Clamp * ( 3 - 2 * Clamp )
                        local Clamp3 = math.clamp( ( Time - Value2 ) / 0.25, 0, 1 )
                        local Clamp4 = Clamp2 * ( Clamp3 * Clamp3 * ( 3 - 2 * Clamp3 ) )
                        local Clamp5 = math.clamp( math.min( Value2, Time - Value2 ) / 0.12, 0, 1 )
                        SetGrip( Character, Entry, Clamp5 * Clamp5 * ( 3 - 2 * Clamp5 ) )
                        local Value3, Value4, Value5 = Table[ Entry.Pose or Value1 ]( Value2, Time )
                        local Head = Character:FindFirstChild( "Head" )

                        if Head then
                            Neck = Head:FindFirstChild( "Neck" )
                        else
                            Neck = Head
                        end
                        if Neck then
                            Tilt( Neck, CFrame.Angles( Value5 * Clamp4, 0, 0 ) )
                        end

                        local UpperTorsoWorld = ArmIK.UpperTorsoWorld( Character )

                        if UpperTorsoWorld then
                            local Table2
                            local TableInner = { }
                            Table2 = Value4 and {
                                "RightShoulder",
                                "RightElbow",
                                "RightWrist",
                                "LeftShoulder",
                                "LeftElbow",
                                "LeftWrist"
                            } or { "RightShoulder", "RightElbow", "RightWrist" }
                            local Value6 = nil

                            for Key2, Value7 in Table2, nil, nil do
                                local Gsub

                                if not Value7:find( "Shoulder" ) or not Value7:gsub( "Shoulder", "UpperArm" ) then
                                    if not Value7:find( "Elbow" ) or not Value7:gsub( "Elbow", "LowerArm" ) then
                                        Gsub = Value7:gsub( "Wrist", "Hand" )
                                    else
                                        Gsub = Value7:gsub( "Elbow", "LowerArm" )
                                    end
                                else
                                    Gsub = Value7:gsub( "Shoulder", "UpperArm" )
                                end

                                local FoundChild2
                                local FoundChild = Character:FindFirstChild( Gsub )

                                if FoundChild then
                                    FoundChild2 = FoundChild:FindFirstChild( Value7 )
                                else
                                    FoundChild2 = FoundChild
                                end
                                if FoundChild2 then
                                    TableInner[ FoundChild2 ] = AnimWorkers.getT( FoundChild2 )
                                end
                            end

                            local Solve = ArmIK.Solve
                            Solve( Character, "Right", UpperTorsoWorld, UpperTorsoWorld * Value3, ( UpperTorsoWorld * CFrame.new( 1.6, -1.4, 0.4 ) ).Position )

                            if Value4 then
                                local Solve2 = ArmIK.Solve
                                Solve2( Character, "Left", UpperTorsoWorld, UpperTorsoWorld * Value4, ( UpperTorsoWorld * CFrame.new( -1.6, -1.4, 0.4 ) ).Position )
                            end
                            if Clamp4 < 0.999 then
                                local Value8 = nil

                                for Key3, Value9 in TableInner, nil, nil do
                                    local SetT = AnimWorkers.setT
                                    SetT( Key3, Value9:Lerp( AnimWorkers.getT( Key3 ), Clamp4 ) )
                                end
                            end
                        end
                    end
                end
            end
        end
    end
}
