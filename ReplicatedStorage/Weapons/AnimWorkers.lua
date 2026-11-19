-- ReplicatedStorage.Weapons.AnimWorkers
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #30

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Actor = Object:FindFirstAncestorOfClass( "Actor" )

if Actor and Actor:GetAttribute( "AWIndex" ) then
    Upvalue1.IsWorker = true
    Upvalue1.Index = Actor:GetAttribute( "AWIndex" )
    Upvalue1.Count = Actor:GetAttribute( "AWCount" )
end

return Upvalue1.IsWorker
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1[ Key ]

if Entry == nil then
    local GA_W = Key:GetAttribute( "GA_W" ) or false
    Upvalue1[ Key ] = GA_W
    Entry2 = GA_W
else
    Entry2 = Entry
end

return Entry2
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.MyChar = MyChar
Upvalue1.MyCharSet = true
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2.SetMyChar( Upvalue1.Character )
end

local Go = Upvalue2.State.Go == true and true or false
local Flag
local Gen = Upvalue2.State.Gen or 0

if Go == Upvalue2.Go then
    if Gen == Upvalue2.Gen then
        Flag = false
    else
        Flag = true
    end
else
    Flag = true
end

Upvalue2.Go = Go
Upvalue2.Gen = Gen

if Flag then
    table.clear( Upvalue3 )
end

return Flag
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Key == nil then
    return false
end
if not Upvalue1 then
    return true
end

local MyChar2

if Upvalue2.MyCharSet then
    local MyChar = Upvalue2.MyChar

    if MyChar then
        MyChar2 = MyChar
    else
        MyChar2 = Upvalue1.Character
    end
else
    MyChar2 = Upvalue1.Character
end

local Flag = Key == MyChar2 and true or false

if Upvalue2.IsWorker then
    local Go2
    local Go = Upvalue2.Go

    if Go then
        local NotFlag = not Flag

        if NotFlag then
            local Entry2
            local Entry = Upvalue3[ Key ]

            if Entry == nil then
                local GA_W = Key:GetAttribute( "GA_W" ) or false
                Upvalue3[ Key ] = GA_W
                Entry2 = GA_W
            else
                Entry2 = Entry
            end
            if Entry2 == Upvalue2.Index then
                Go2 = true
            else
                Go2 = false
            end
        else
            Go2 = NotFlag
        end
    else
        Go2 = Go
    end

    return Go2
end
local Flag2

if Flag then
    Flag2 = Flag
else
    local NotGo = not Upvalue2.Go

    if NotGo then
        Flag2 = NotGo
    else
        local Entry4
        local Entry3 = Upvalue3[ Key ]

        if Entry3 == nil then
            local GA_W2 = Key:GetAttribute( "GA_W" ) or false
            Upvalue3[ Key ] = GA_W2
            Entry4 = GA_W2
        else
            Entry4 = Entry3
        end
        if Entry4 == false then
            Flag2 = true
        else
            Flag2 = false
        end
    end
end

return Flag2
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Entry then
    return Entry
end

local GA_Id2
local GA_Id = Key:GetAttribute( "GA_Id" )

if GA_Id or Upvalue2.IsWorker or Upvalue2.InParallel then
    GA_Id2 = GA_Id
else
    Upvalue3 = Upvalue3 + 1
    Key:SetAttribute( "GA_Id", Upvalue3 )
    GA_Id2 = Upvalue3
end
if GA_Id2 then
    Upvalue1[ Key ] = GA_Id2
end

return GA_Id2
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsWorker or Upvalue1.COUNT <= 0 or not Upvalue2 then
    return
end

local Value1, Table4
local Character = Upvalue2.Character
local Create = table.create( Upvalue1.COUNT, 0 )
local Table = { }
Value1 = nil
Table4 = nil

for Key, Value in List, nil, nil do
    if Value ~= Character then
        local GA_W = Value:GetAttribute( "GA_W" )

        if not GA_W or not Create[ GA_W ] then
            local Table5 = if Table4 then Table4 else { }
            table.insert( Table5, Value )
            Table4 = Table5
        else
            Create[ GA_W ] = Create[ GA_W ] + 1
        end
    end

    local Id = Upvalue1.Id( Value )

    if Id then
        Table[ Id ] = true
    end
end

local Value2
local Table2 = { Upvalue1.Aim, Upvalue1.Swim }
Value2 = nil

for Key2, Value3 in Table2, nil, nil do
    local Value6
    local Table3 = { }
    Value6 = nil

    for Value7 in Value3, nil, nil do
        if not Table[ Value7 ] then
            table.insert( Table3, Value7 )
        end
    end

    local Value8 = nil

    for Key4, Value9 in Table3, nil, nil do
        Value3[ Value9 ] = nil
    end
end
if not Table4 then
    return
end

local Value4 = nil

for Key3, Value5 in Table4, nil, nil do
    local Number
    local COUNT = Upvalue1.COUNT
    local J = 2
    Number = 1

    for J = 2, COUNT do
        if Create[ J ] < Create[ Number ] then
            Number = J
        end
    end

    Create[ Number ] = Create[ Number ] + 1
    Value5:SetAttribute( "GA_W", Number )
    Upvalue3[ Value5 ] = nil
end

local State = Upvalue1.State
State.Gen = ( Upvalue1.State.Gen or 0 ) + 1
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ AimName ] == Argument2 then
    return
end

local Id = Upvalue2.Id( AimName )

if Id then
    Upvalue1[ AimName ] = Argument2
    Upvalue2.Aim[ Id ] = Argument2
    return
end
return
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Id = Upvalue1.Id( Argument1 )

if Id == nil then
    Flag = false
elseif Upvalue1.Aim[ Id ] == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Recording = true
table.clear( Upvalue2 )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Recording = false
Upvalue2 = Upvalue3
Upvalue3 = Upvalue2
table.clear( Upvalue3 )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Key.Parent then
        Key.Transform = Value
    end
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

table.clear( Upvalue1 )
table.clear( Upvalue2 )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    local Entry = Upvalue2[ Key ]

    if Entry ~= nil then
        return Entry
    end
end

return Key.Transform
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    Upvalue2[ Key ] = Transform
else
    Key.Transform = Transform
end
if Upvalue1.Recording then
    Upvalue3[ Key ] = Transform
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    local Entry = Upvalue2[ Key ]

    if Entry ~= nil then
        return Entry
    end
end

return Key.C0
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    Upvalue2[ Key ] = C0
    return
end
Key.C0 = C0
return
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    table.insert( Upvalue2, table.pack( Callback, ... ) )
    return
end
Callback( ... )
return
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1.InParallel = false
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Key.Transform = Value
end

local Value2
table.clear( Upvalue2 )
Value2 = nil

for Key2, Value3 in Upvalue3, nil, nil do
    Key2.C0 = Value3
end

table.clear( Upvalue3 )

if #Upvalue4 > 0 then
    local Value4
    Upvalue4 = { }
    Value4 = nil

    for Key3, Value5 in Upvalue4, nil, nil do
        local Item = Value5[ 1 ]
        local Success, Result = pcall( Item, table.unpack( Value5, 2, Value5.n ) )

        if not Success then
            warn( "[AnimWorkers] " .. tostring( Result ) )
        end
    end
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    task.synchronize( )
    Upvalue1.Syncs = Upvalue1.Syncs + 1
    Upvalue1.Flush( )
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

table.clear( Upvalue1 )

for Key, Value in Upvalue2:GetPlayers( ) do
    local Character = Value.Character

    if Character then
        Upvalue1[ Character ] = Value
    end
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.InParallel then
    return Upvalue2[ Key ]
end
return Upvalue3:GetPlayerFromCharacter( Key )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.COUNT <= 0 then
    return
end

local Entry2
local Entry = Upvalue2[ SteerName ]

if Entry then
    Entry2 = Entry
else
    Upvalue3 = Upvalue3 + 1
    Upvalue2[ SteerName ] = Upvalue3
    SteerName:SetAttribute( "GA_CarId", Upvalue3 )
    Entry2 = Upvalue3
end

Upvalue1.Steer[ Entry2 ] = Argument2
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local GA_CarId

if Key then
    GA_CarId = Key:GetAttribute( "GA_CarId" )
else
    GA_CarId = Key
end

local Entry2

if GA_CarId then
    local Entry = Upvalue1.Steer[ GA_CarId ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = nil
    end
else
    Entry2 = nil
end

return Entry2
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

return ( setmetatable( { }, {
    __index = function( Argument1, Key )
        local GA_CarId

        if Key then
            GA_CarId = Key:GetAttribute( "GA_CarId" )
        else
            GA_CarId = Key
        end

        local Entry2

        if GA_CarId then
            local Entry = Upvalue1.Steer[ GA_CarId ]

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
} ) )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local COUNT = Upvalue1.COUNT
local I = 1

for I = 1, COUNT do
    local Value1
    local Parent = Instance.new( "Actor" )
    Parent.Name = "AnimWorker" .. I
    Parent:SetAttribute( "AWIndex", I )
    Parent:SetAttribute( "AWCount", Upvalue1.COUNT )
    Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        if Value then
            Value:Clone( ).Parent = Parent
        end
    end

    Parent.Parent = Upvalue3

    if I < Upvalue1.COUNT then
        task.wait( )
    end
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsWorker or Upvalue1.COUNT <= 0 or not Upvalue2 then
    return
end

Upvalue1.State.Go = false
local PlayerScripts = Upvalue2:WaitForChild( "PlayerScripts" )
local COUNT = Upvalue1.COUNT
local I = 1

for I = 1, COUNT do
    local State = Upvalue1.State
    State[ "Ready" .. I ] = false
end

task.spawn( function()
    local COUNT = Upvalue1.COUNT
    local I = 1

    for I = 1, COUNT do
        local Value1
        local Parent = Instance.new( "Actor" )
        Parent.Name = "AnimWorker" .. I
        Parent:SetAttribute( "AWIndex", I )
        Parent:SetAttribute( "AWCount", Upvalue1.COUNT )
        Value1 = nil

        for Key, Value in Argument1, nil, nil do
            if Value then
                Value:Clone( ).Parent = Parent
            end
        end

        Parent.Parent = PlayerScripts

        if I < Upvalue1.COUNT then
            task.wait( )
        end
    end
end )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsWorker or Upvalue1.COUNT <= 0 then
    return
end
if Upvalue1.State.Off == true or Upvalue1.State.Dead == true then
    if Upvalue1.State.Go == true then
        Upvalue1.State.Go = false
    end

    return
end
if Upvalue1.State.Go == true then
    return
end

local COUNT = Upvalue1.COUNT
local I = 1

for I = 1, COUNT do
    if Upvalue1.State[ "Ready" .. I ] ~= true then
        return
    end
end

Upvalue1.State.Go = true
return
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = "Beat" .. Upvalue1.Index
local State = Upvalue1.State
State[ Text ] = ( Upvalue1.State[ Text ] or 0 ) + 1

if Upvalue1.Syncs ~= Upvalue2 then
    Upvalue2 = Upvalue1.Syncs
    Upvalue1.State[ "Sync" .. Upvalue1.Index ] = Upvalue1.Syncs
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsWorker or Upvalue1.State.Go ~= true then
    return
end

local COUNT = Upvalue1.COUNT
local I = 1

for I = 1, COUNT do
    local Entry = Upvalue1.State[ "Beat" .. I ]

    if Entry == Upvalue2[ I ] then
        Upvalue4[ I ] = ( Upvalue4[ I ] or 0 ) + 1
    else
        Upvalue2[ I ] = Entry
        Upvalue3[ I ] = Argument1
        Upvalue4[ I ] = 0
    end
    if Upvalue4[ I ] > 120 and Argument1 - ( Upvalue3[ I ] or Argument1 ) > 2 then
        Upvalue1.State.Go = false
        Upvalue1.State.Dead = true
        warn( "[AnimWorkers] ouvrier " .. I .. " arrêté : toutes les animations reviennent sur le fil principal" )

        if Callback then
            Callback( )
        end

        return
    end
end
]]
