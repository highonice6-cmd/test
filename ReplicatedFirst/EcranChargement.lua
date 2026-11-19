-- ReplicatedFirst.EcranChargement
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #42

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Child2
local Child = Upvalue1:WaitForChild( Upvalue2[ 1 ], 60 )

if Child then
    Child2 = Child:WaitForChild( Upvalue2[ 2 ], 60 )
else
    Child2 = Child
end
if Child2 and Child2:IsA( "BaseRemoteEvent" ) then
    Child2.OnClientEvent:Connect( function()
    end )
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = {
    { "VehicleSystem", "SyncState" },
    { "Remotes", "HitFX" },
    { "Remotes", "FX" }
}
Value1 = nil

for Key, Value in Table, nil, nil do
    task.spawn( function()
        local Child2
        local Child = ReplicatedStorage:WaitForChild( Value[ 1 ], 60 )

        if Child then
            Child2 = Child:WaitForChild( Value[ 2 ], 60 )
        else
            Child2 = Child
        end
        if Child2 and Child2:IsA( "BaseRemoteEvent" ) then
            Child2.OnClientEvent:Connect( function()
            end )
        end
    end )
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

return game:GetService( "TeleportService" ):GetLocalPlayerTeleportData( )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.PreferredInput
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Success, Result = pcall( function()
    return Upvalue1.PreferredInput
end )

if not Success or not Result then
    if Upvalue1.TouchEnabled and not Upvalue1.KeyboardEnabled then
        return "touch"
    end
    if not Upvalue1.GamepadEnabled or Upvalue1.KeyboardEnabled then
        return "pc"
    end
    return "pad"
else
    if Result == Enum.PreferredInput.Touch then
        return "touch"
    end
    if Result == Enum.PreferredInput.Gamepad then
        return "pad"
    end
    return "pc"
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { }
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Entry5
    local Entry4 = Value[ PourName ]
    Entry5 = if Entry4 then Entry4 else Value.all

    if Entry5 then
        table.insert( Table, Entry5 )
    end
end

local Random2 = Random.new( )
local Count = #Table
local I = Count

for I = Count, 3, -1 do
    local NextInteger = Random2:NextInteger( 2, I )
    local Entry = Table[ NextInteger ]
    local Entry2 = Table[ I ]
    Table[ I ] = Entry
    Table[ NextInteger ] = Entry2
end
if PourName ~= "pc" then
    local NextInteger2 = Random2:NextInteger( 1, #Table )
    local Entry3 = Table[ NextInteger2 ]
    local Item = Table[ 1 ]
    Table[ 1 ] = Entry3
    Table[ NextInteger2 ] = Item
end

return Table
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = false
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1:FindFirstChild( Name, true )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

game:GetService( "TeleportService" ):SetTeleportGui( Upvalue1 )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PreloadAsync( { Upvalue2 } )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

pcall( function()
    Upvalue1:PreloadAsync( { Upvalue2 } )
end )
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( Argument1, 0, 1 )

if Upvalue1 < Clamp then
    local Clock = os.clock( )
    Upvalue1 = Clamp
    Upvalue2 = Clock
end

local Number
local Clamp2 = Argument2 or Clamp
Number = not ( Clamp >= 1 ) and 0.97 or 1
Upvalue3 = math.max( Upvalue1, ( math.min( Clamp2, Number ) ) )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Argument1
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( ) - Upvalue1
Upvalue5 = math.max( Upvalue5, Upvalue5 + ( Upvalue2 + ( Upvalue3 - Upvalue2 ) * ( 1 - math.exp( -( os.clock( ) - Upvalue4 ) / 3.5 ) ) - Upvalue5 ) * math.clamp( Amount * 6, 0, 1 ) )

if Upvalue6 then
    Upvalue6.Size = UDim2.new( Upvalue5, 0, Upvalue7.Scale, Upvalue7.Offset )
end
if Upvalue8 then
    Upvalue8.Text = math.floor( Upvalue5 * 100 ) .. "%"
end

local Floor = math.floor( Clock * 2.5 ) % 4

if Floor ~= Upvalue9 and Upvalue10 ~= "Ready!" then
    Upvalue9 = Floor

    if Upvalue11 then
        Upvalue11.Text = Upvalue10 .. string.rep( ".", Floor )
    end
end
if Upvalue12 then
    local Clock2 = -0.3 + Clock * 0.6 % 1.6
    Upvalue12.Position = UDim2.new( Clock2, 0, Upvalue13.Scale, Upvalue13.Offset )
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1[ Upvalue2 ]
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Number = 1

while not Upvalue2 do
    if not Upvalue3.Parent then
        break
    end

    Upvalue1.Text = Upvalue4:gsub( "{tip}", function()
        return Upvalue5[ Number ]
    end )
    Upvalue6:Create( Upvalue1, TweenInfo.new( 0.35 ), { TextTransparency = Upvalue7 } ):Play( )
    task.wait( 5 )

    if Upvalue2 then
        break
    end

    Upvalue6:Create( Upvalue1, TweenInfo.new( 0.35 ), { TextTransparency = 1 } ):Play( )
    task.wait( 0.4 )
    Number = Number % #Upvalue5 + 1
end
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( Key, Clock - Upvalue2 ) )
Upvalue3[ Key ] = math.floor( ( Clock - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

return game:GetService( "Stats" ):GetTotalMemoryUsageMb( )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

return UserSettings( ):GetService( "UserGameSettings" ).SavedQualityLevel.Value
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local ChargementStats
local Remotes = Upvalue1:FindFirstChild( "Remotes" )

if Remotes then
    ChargementStats = Remotes:WaitForChild( "ChargementStats", 15 )
else
    ChargementStats = Remotes
end
if not ChargementStats or not ChargementStats:IsA( "RemoteEvent" ) then
    return
end

local M
local Success, Result = pcall( function()
    return game:GetService( "Stats" ):GetTotalMemoryUsageMb( )
end )
local Success2, Result2 = pcall( function()
    return UserSettings( ):GetService( "UserGameSettings" ).SavedQualityLevel.Value
end )
local FireServer = ChargementStats.FireServer
local Table = { e = Upvalue2, t = Upvalue3, d = Upvalue4( ) }
M = Success and Result or nil
local Q
Table.m = M
Q = Success2 and Result2 or nil
local Cap
Table.q = Q
Table.f = Upvalue5.statuts.Failure or 0
Table.n = Upvalue6
Table.a0 = Upvalue7
Cap = Upvalue8 == true and true or false
local S
Table.cap = Cap
S = Upvalue8 and Upvalue9 or nil
Table.s = S
pcall( FireServer, ChargementStats, Table )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
local Clock = os.clock( ) - Upvalue2
task.spawn( function()
    local ChargementStats
    local Remotes = Upvalue4:FindFirstChild( "Remotes" )

    if Remotes then
        ChargementStats = Remotes:WaitForChild( "ChargementStats", 15 )
    else
        ChargementStats = Remotes
    end
    if not ChargementStats or not ChargementStats:IsA( "RemoteEvent" ) then
        return
    end

    local M
    local Success, Result = pcall( function()
        return game:GetService( "Stats" ):GetTotalMemoryUsageMb( )
    end )
    local Success2, Result2 = pcall( function()
        return UserSettings( ):GetService( "UserGameSettings" ).SavedQualityLevel.Value
    end )
    local FireServer = ChargementStats.FireServer
    local Table = { e = Upvalue5, t = Clock, d = Upvalue6( ) }
    M = Success and Result or nil
    local Q
    Table.m = M
    Q = Success2 and Result2 or nil
    local Cap
    Table.q = Q
    Table.f = Upvalue7.statuts.Failure or 0
    Table.n = Upvalue8
    Table.a0 = Upvalue9
    Cap = Argument1 == true and true or false
    local S
    Table.cap = Cap
    S = Argument1 and Upvalue3 or nil
    Table.s = S
    pcall( FireServer, ChargementStats, Table )
end )
return
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == nil or Name == "" then
    return
end
if type( Name ) == "string" and Name:sub( 1, 11 ) == "rbxasset://" then
    return
end

local Value1 = Argument2 or Name

if not Upvalue1[ Value1 ] then
    Upvalue1[ Value1 ] = true
    table.insert( Upvalue2, Name )
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { }
local Table2 = { }
return Table, function( Name, Argument2 )
    if Name == nil or Name == "" then
        return
    end
    if type( Name ) == "string" and Name:sub( 1, 11 ) == "rbxasset://" then
        return
    end

    local Value1 = Argument2 or Name

    if not Table2[ Value1 ] then
        Table2[ Value1 ] = true
        table.insert( Table, Name )
    end
end
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "MeshPart" ) and Object.MeshId ~= "" then
    local MeshId = Object.MeshId
    Callback( Object, "mesh|" .. MeshId .. "|" .. Object.TextureID )
end
for Key, Value in Object:GetChildren( ) do
    if Value:IsA( "Texture" ) or Value:IsA( "Decal" ) then
        if Value.Texture ~= "" then
            Callback( Value, "img|" .. Value.Texture )
            continue
        end
    end
    if not Value:IsA( "SpecialMesh" ) or Value.MeshId == "" then
        if Value:IsA( "SurfaceAppearance" ) then
            Callback( Value )
        end
    else
        local MeshId2 = Value.MeshId
        Callback( Value, "mesh|" .. MeshId2 .. "|" .. Value.TextureId )
    end
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Object:GetDescendants( ) do
    if Value:IsA( "ImageLabel" ) or Value:IsA( "ImageButton" ) then
        if Value.Image ~= "" then
            Callback( Value, "img|" .. Value.Image )
        end
        if Value:IsA( "ImageButton" ) then
            if Value.HoverImage ~= "" or Value.PressedImage ~= "" then
                local HoverImage = Value.HoverImage
                Callback( Value, "imgb|" .. HoverImage .. "|" .. Value.PressedImage )
            end
        end
    elseif Value:IsA( "BasePart" ) then
        Upvalue1( Value, Callback )
    end
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { }
local Count = #List
local I = 1

for I = 1, Count, 100 do
    local Total = I + 100 - 1
    table.insert( Table, table.move( List, I, math.min( Total, #List ), 1, { } ) )
end

return Table
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1:GetAttribute( "Onboarding" ) == false then
    if Upvalue1:GetAttribute( "InWardrobe" ) == true then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + ( 1 / math.max( Argument1, 0.004166666666666667 ) - Upvalue1 ) * 0.05
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PreloadAsync( Upvalue2 )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Number2
local Clock = os.clock( )
local Number = 60
local Connect = Upvalue1.Heartbeat:Connect( function( Argument1 )
    Number = Number + ( 1 / math.max( Argument1, 0.004166666666666667 ) - Number ) * 0.05
end )
Number2 = 0

while #Upvalue2 > 0 do
    local Number3
    local Remove = table.remove( Upvalue2, 1 )
    Number2 = Number2 + 1
    Number3 = 1

    while Number3 <= #Remove do
        local Clock2 = os.clock( )

        while true do
            local Flag

            if Upvalue3:GetAttribute( "Onboarding" ) == false then
                if Upvalue3:GetAttribute( "InWardrobe" ) == true then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
            if not Flag or not ( Number < 30 ) or not ( os.clock( ) - Clock2 < 10 ) then
                break
            end

            task.wait( 0.5 )
        end

        local Flag2

        if Upvalue3:GetAttribute( "Onboarding" ) == false then
            if Upvalue3:GetAttribute( "InWardrobe" ) == true then
                Flag2 = false
            else
                Flag2 = true
            end
        else
            Flag2 = false
        end

        local Number4 = if Flag2 then 20 else #Remove
        local Flag3
        local Number5 = Number3 + Number4 - 1
        local Move = table.move( Remove, Number3, math.min( Number5, #Remove ), 1, { } )
        pcall( function()
            Upvalue4:PreloadAsync( Move )
        end )
        Number3 = Number3 + Number4

        if Upvalue3:GetAttribute( "Onboarding" ) == false then
            if Upvalue3:GetAttribute( "InWardrobe" ) == true then
                Flag3 = false
            else
                Flag3 = true
            end
        else
            Flag3 = false
        end
        if Flag3 then
            task.wait( 0.2 )
        else
            task.wait( )
        end
    end
end

Connect:Disconnect( )
Upvalue5 = false
print( ( "[Chargement] en fond : %d lot(s) finis en %.1f s" ):format( Number2, os.clock( ) - Clock ) )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in List, nil, nil do
    table.insert( Upvalue1, Value )
end
if Upvalue2 or #Upvalue1 == 0 then
    return
end
Upvalue2 = true
task.spawn( function()
    local Number2
    local Clock = os.clock( )
    local Number = 60
    local Connect = Upvalue3.Heartbeat:Connect( function( Argument1 )
        Number = Number + ( 1 / math.max( Argument1, 0.004166666666666667 ) - Number ) * 0.05
    end )
    Number2 = 0

    while #Upvalue1 > 0 do
        local Number3
        local Remove = table.remove( Upvalue1, 1 )
        Number2 = Number2 + 1
        Number3 = 1

        while Number3 <= #Remove do
            local Clock2 = os.clock( )

            while true do
                local Flag

                if Upvalue4:GetAttribute( "Onboarding" ) == false then
                    if Upvalue4:GetAttribute( "InWardrobe" ) == true then
                        Flag = false
                    else
                        Flag = true
                    end
                else
                    Flag = false
                end
                if not Flag or not ( Number < 30 ) or not ( os.clock( ) - Clock2 < 10 ) then
                    break
                end

                task.wait( 0.5 )
            end

            local Flag2

            if Upvalue4:GetAttribute( "Onboarding" ) == false then
                if Upvalue4:GetAttribute( "InWardrobe" ) == true then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = false
            end

            local Number4 = if Flag2 then 20 else #Remove
            local Flag3
            local Number5 = Number3 + Number4 - 1
            local Move = table.move( Remove, Number3, math.min( Number5, #Remove ), 1, { } )
            pcall( function()
                Upvalue5:PreloadAsync( Move )
            end )
            Number3 = Number3 + Number4

            if Upvalue4:GetAttribute( "Onboarding" ) == false then
                if Upvalue4:GetAttribute( "InWardrobe" ) == true then
                    Flag3 = false
                else
                    Flag3 = true
                end
            else
                Flag3 = false
            end
            if Flag3 then
                task.wait( 0.2 )
            else
                task.wait( )
            end
        end
    end

    Connect:Disconnect( )
    Upvalue2 = false
    print( ( "[Chargement] en fond : %d lot(s) finis en %.1f s" ):format( Number2, os.clock( ) - Clock ) )
end )
return
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1[ Upvalue2 ] = Upvalue1[ Upvalue2 ] + 1

if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
    return
end

Upvalue3.statuts[ Argument2.Name ] = ( Upvalue3.statuts[ Argument2.Name ] or 0 ) + 1

if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue3.echecs < 12 then
    local Echecs = Upvalue3.echecs
    local Name = Argument2.Name
    table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PreloadAsync( Upvalue2, function( Argument1, Argument2 )
    Upvalue3[ Upvalue4 ] = Upvalue3[ Upvalue4 ] + 1

    if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
        return
    end

    Upvalue5.statuts[ Argument2.Name ] = ( Upvalue5.statuts[ Argument2.Name ] or 0 ) + 1

    if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue5.echecs < 12 then
        local Echecs = Upvalue5.echecs
        local Name = Argument2.Name
        table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
    end
end )
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
pcall( function()
    Upvalue1:PreloadAsync( Upvalue2, function( Argument1, Argument2 )
        Upvalue3[ Upvalue4 ] = Upvalue3[ Upvalue4 ] + 1

        if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
            return
        end

        Upvalue5.statuts[ Argument2.Name ] = ( Upvalue5.statuts[ Argument2.Name ] or 0 ) + 1

        if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue5.echecs < 12 then
            local Echecs = Upvalue5.echecs
            local Name = Argument2.Name
            table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
        end
    end )
end )

if os.clock( ) - Clock > 4 then
    local Lents = Upvalue5.lents
    table.insert( Lents, ( "lot %d : %.1f s" ):format( Upvalue4, os.clock( ) - Clock ) )
end

Upvalue6 = Upvalue6 + #Upvalue2
Upvalue7 = Upvalue7 - 1
Upvalue8[ Upvalue4 ] = nil
local Captured = Upvalue9 + ( Upvalue10 - Upvalue9 ) * Upvalue6 / Upvalue11
local Min = math.min( Captured + ( Upvalue10 - Upvalue9 ) * 100 / Upvalue11 + 0.03, Upvalue10 )
local Clamp = math.clamp( Captured, 0, 1 )

if Upvalue12 < Clamp then
    local Clock2 = os.clock( )
    Upvalue12 = Clamp
    Upvalue13 = Clock2
end

local Number
local Min2 = Min or Clamp
Number = not ( Clamp >= 1 ) and 0.97 or 1
Upvalue14 = math.max( Upvalue12, ( math.min( Min2, Number ) ) )
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]
Upvalue2[ Key ] = Entry
Upvalue3[ Key ] = 0
Upvalue4 = Upvalue4 + 1
task.spawn( function()
    local Clock = os.clock( )
    pcall( function()
        Upvalue5:PreloadAsync( Entry, function( Argument1, Argument2 )
            Upvalue3[ Key ] = Upvalue3[ Key ] + 1

            if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
                return
            end

            Upvalue6.statuts[ Argument2.Name ] = ( Upvalue6.statuts[ Argument2.Name ] or 0 ) + 1

            if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue6.echecs < 12 then
                local Echecs = Upvalue6.echecs
                local Name = Argument2.Name
                table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
            end
        end )
    end )

    if os.clock( ) - Clock > 4 then
        local Lents = Upvalue6.lents
        table.insert( Lents, ( "lot %d : %.1f s" ):format( Key, os.clock( ) - Clock ) )
    end

    Upvalue7 = Upvalue7 + #Entry
    Upvalue4 = Upvalue4 - 1
    Upvalue2[ Key ] = nil
    local Captured = Upvalue8 + ( Upvalue9 - Upvalue8 ) * Upvalue7 / Upvalue10
    local Min = math.min( Captured + ( Upvalue9 - Upvalue8 ) * 100 / Upvalue10 + 0.03, Upvalue9 )
    local Clamp = math.clamp( Captured, 0, 1 )

    if Upvalue11 < Clamp then
        local Clock2 = os.clock( )
        Upvalue11 = Clamp
        Upvalue12 = Clock2
    end

    local Number
    local Min2 = Min or Clamp
    Number = not ( Clamp >= 1 ) and 0.97 or 1
    Upvalue13 = math.max( Upvalue11, ( math.min( Min2, Number ) ) )
end )
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local Number3, Number4
local Max = math.max( #List, 1 )
local Number = 0
local Clock = os.clock( )
local Value1 = Upvalue1( List )
local Table = { }
local Table2 = { }
local Number2 = 0

local function Lancer( Key )
    local Entry = Value1[ Key ]
    Table[ Key ] = Entry
    Table2[ Key ] = 0
    Number2 = Number2 + 1
    task.spawn( function()
        local Clock = os.clock( )
        pcall( function()
            Upvalue2:PreloadAsync( Entry, function( Argument1, Argument2 )
                Table2[ Key ] = Table2[ Key ] + 1

                if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
                    return
                end

                Upvalue3.statuts[ Argument2.Name ] = ( Upvalue3.statuts[ Argument2.Name ] or 0 ) + 1

                if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue3.echecs < 12 then
                    local Echecs = Upvalue3.echecs
                    local Name = Argument2.Name
                    table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
                end
            end )
        end )

        if os.clock( ) - Clock > 4 then
            local Lents = Upvalue3.lents
            table.insert( Lents, ( "lot %d : %.1f s" ):format( Key, os.clock( ) - Clock ) )
        end

        Number = Number + #Entry
        Number2 = Number2 - 1
        Table[ Key ] = nil
        local Captured = Argument2 + ( Argument3 - Argument2 ) * Number / Max
        local Min = math.min( Captured + ( Argument3 - Argument2 ) * 100 / Max + 0.03, Argument3 )
        local Clamp = math.clamp( Captured, 0, 1 )

        if Upvalue4 < Clamp then
            local Clock2 = os.clock( )
            Upvalue4 = Clamp
            Upvalue5 = Clock2
        end

        local NumberInner
        local Min2 = Min or Clamp
        NumberInner = not ( Clamp >= 1 ) and 0.97 or 1
        Upvalue6 = math.max( Upvalue4, ( math.min( Min2, NumberInner ) ) )
    end )
end

Number3 = 1
Number4 = Number2

while true do
    if not ( Number3 <= #Value1 ) and not ( Number4 > 0 ) then
        break
    end
    if not ( os.clock( ) - Upvalue7 <= Upvalue8 ) or not ( os.clock( ) - Clock <= Argument4 ) then
        break
    end
    while Number4 < 4 do
        if not ( Number3 <= #Value1 ) then
            break
        end

        local Swap = Number3
        local Entry = Value1[ Number3 ]
        Table[ Number3 ] = Entry
        Table2[ Number3 ] = 0
        Number2 = Number4 + 1
        task.spawn( function()
            local Clock = os.clock( )
            pcall( function()
                Upvalue2:PreloadAsync( Entry, function( Argument1, Argument2 )
                    Table2[ Swap ] = Table2[ Swap ] + 1

                    if Argument2 ~= Enum.AssetFetchStatus.Success and tostring( Argument1 ) == "" then
                        return
                    end

                    Upvalue3.statuts[ Argument2.Name ] = ( Upvalue3.statuts[ Argument2.Name ] or 0 ) + 1

                    if Argument2 ~= Enum.AssetFetchStatus.Success and #Upvalue3.echecs < 12 then
                        local Echecs = Upvalue3.echecs
                        local Name = Argument2.Name
                        table.insert( Echecs, Name .. " " .. tostring( Argument1 ) )
                    end
                end )
            end )

            if os.clock( ) - Clock > 4 then
                local Lents = Upvalue3.lents
                table.insert( Lents, ( "lot %d : %.1f s" ):format( Swap, os.clock( ) - Clock ) )
            end

            Number = Number + #Entry
            Number2 = Number2 - 1
            Table[ Swap ] = nil
            local Captured = Argument2 + ( Argument3 - Argument2 ) * Number / Max
            local Min = math.min( Captured + ( Argument3 - Argument2 ) * 100 / Max + 0.03, Argument3 )
            local Clamp = math.clamp( Captured, 0, 1 )

            if Upvalue4 < Clamp then
                local Clock2 = os.clock( )
                Upvalue4 = Clamp
                Upvalue5 = Clock2
            end

            local NumberInner
            local Min2 = Min or Clamp
            NumberInner = not ( Clamp >= 1 ) and 0.97 or 1
            Upvalue6 = math.max( Upvalue4, ( math.min( Min2, NumberInner ) ) )
        end )
        Number3 = Number3 + 1
        Number4 = Number2
    end

    task.wait( 0.05 )
end

local Count = #Value1 - Number3 + 1

if Count > 0 then
    Upvalue9( table.move( Value1, Number3, #Value1, 1, { } ) )
end
if Number4 > 0 or Count > 0 then
    local Value2
    local Table3 = { }
    Value2 = nil

    for Key, Value in Table, nil, nil do
        local Table4 = { }
        local Min = math.min( 3, #Value )
        local J = 1

        for J = 1, Min do
            local Text
            local Entry2 = Value[ J ]

            if typeof( Entry2 ) ~= "Instance" or not Entry2:GetFullName( ) then
                Text = tostring( Entry2 )
            else
                Text = Entry2:GetFullName( )
            end

            table.insert( Table4, Text )
        end

        table.insert( Table3, ( "lot %d (%d réponses reçues) : %s" ):format( Key, Table2[ Key ] or 0, table.concat( Table4, ", " ) ) )

        if #Table3 >= 6 then
            break
        end
    end

    local Concat2
    local Clock2 = os.clock( ) - Clock

    if #Table3 > 0 then
        local Concat = table.concat( Table3, " ; " )

        if Concat then
            Concat2 = Concat
        else
            Concat2 = "-"
        end
    else
        Concat2 = "-"
    end

    print( ( "[Chargement] budget de %.0f s atteint : %d lot(s) encore en route, %d en fond (l'écran n'attend plus) | %s" ):format( Clock2, Number4, Count, Concat2 ) )
end
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local Clock = os.clock( )
Number = not Upvalue1 and 12 or 30

while os.clock( ) - Clock < Number do
    local Character = Upvalue2.Character

    if Character and Character:GetAttribute( "OutfitApplied" ) ~= nil then
        break
    end

    task.wait( 0.1 )
end

Upvalue3 = true
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:RequestStreamAroundAsync( Upvalue2, Upvalue3 )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = List[ 2 ] < List2[ 2 ] and true or false
return Flag
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if not game:IsLoaded( ) then
    game.Loaded:Wait( )
end

local Clock = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "jeu", Clock - Upvalue2 ) )
Upvalue3.jeu = math.floor( ( Clock - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock
local Clamp = math.clamp( 0.08, 0, 1 )

if Upvalue4 < Clamp then
    local Clock2 = os.clock( )
    Upvalue4 = Clamp
    Upvalue5 = Clock2
end

local Number = not ( Clamp >= 1 ) and 0.97 or 1
local Wait
Upvalue6 = math.max( Upvalue4, ( math.min( 0.15, Number ) ) )
Upvalue7 = "Spawning"
local Character = Upvalue8.Character

if Character then
    Wait = Character
else
    Wait = Upvalue8.CharacterAdded:Wait( )
end

local HumanoidRootPart = Wait:WaitForChild( "HumanoidRootPart", 15 )

if not HumanoidRootPart then
    Upvalue9 = true
    return
end

local Clock3 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "perso", Clock3 - Upvalue2 ) )
Upvalue3.perso = math.floor( ( Clock3 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock3
local Flag = false
task.spawn( function()
    local Number
    local Clock = os.clock( )
    Number = not Upvalue10 and 12 or 30

    while os.clock( ) - Clock < Number do
        local Character = Upvalue8.Character

        if Character and Character:GetAttribute( "OutfitApplied" ) ~= nil then
            break
        end

        task.wait( 0.1 )
    end

    Flag = true
end )
local Clamp2 = math.clamp( 0.15, 0, 1 )

if Upvalue4 < Clamp2 then
    local Clock4 = os.clock( )
    Upvalue4 = Clamp2
    Upvalue5 = Clock4
end

local Number2 = not ( Clamp2 >= 1 ) and 0.97 or 1
Upvalue6 = math.max( Upvalue4, ( math.min( 0.25, Number2 ) ) )

if Upvalue8:GetAttribute( "DataLoaded" ) ~= true then
    Upvalue7 = "Loading your data"
    local Clock5 = os.clock( )

    while Upvalue8:GetAttribute( "DataLoaded" ) ~= true do
        if not ( os.clock( ) - Clock5 < 120 ) or not Upvalue8.Parent then
            break
        end

        task.wait( 0.1 )
    end

    local Clock6 = os.clock( )
    table.insert( Upvalue1, ( "%s %.1f s" ):format( "données", Clock6 - Upvalue2 ) )
    Upvalue3[ "données" ] = math.floor( ( Clock6 - Upvalue2 ) * 10 + 0.5 ) / 10
    Upvalue2 = Clock6
end

local MapSpawn = Upvalue8:GetAttribute( "MapSpawn" )
local Clock7 = os.clock( )

while true do
    if typeof( MapSpawn ) ~= "CFrame" and os.clock( ) - Clock7 < 3 then
        task.wait( 0.1 )
        MapSpawn = Upvalue8:GetAttribute( "MapSpawn" )
        continue
    end
    if Upvalue8:GetAttribute( "TutoReady" ) ~= nil or not ( os.clock( ) - Clock7 < 20 ) then
        break
    end

    task.wait( 0.1 )
    MapSpawn = Upvalue8:GetAttribute( "MapSpawn" )
end

local Position = typeof( MapSpawn ) == "CFrame" and MapSpawn.Position or HumanoidRootPart.Position
Upvalue7 = "Loading the city"
pcall( function()
    Upvalue8:RequestStreamAroundAsync( Position, Upvalue11 )
end )
local Clock8 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "streaming", Clock8 - Upvalue2 ) )
Upvalue3.streaming = math.floor( ( Clock8 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock8
local Clamp3 = math.clamp( 0.25, 0, 1 )

if Upvalue4 < Clamp3 then
    local Clock9 = os.clock( )
    Upvalue4 = Clamp3
    Upvalue5 = Clock9
end

local Number3 = not ( Clamp3 >= 1 ) and 0.97 or 1
Upvalue6 = math.max( Upvalue4, ( math.min( 0.32, Number3 ) ) )
Upvalue7 = "Loading textures"
local Value1, Value2 = Upvalue12( )
local SPAWN_CHARACTER = workspace:FindFirstChild( "SPAWN_CHARACTER" )

if Upvalue8:GetAttribute( "NeedsGender" ) == true and Upvalue8:GetAttribute( "InTutorial" ) ~= nil then
    SPAWN_CHARACTER = nil
end

local PlayerGui = Upvalue8:FindFirstChildOfClass( "PlayerGui" )
local Table = { }
local Success, Result = pcall( require, Upvalue13:WaitForChild( "Screens", 10 ) )
local Table2 = { }

if not Success or not PlayerGui then
    local Children2 = PlayerGui and PlayerGui:GetChildren( ) or { }
    local Value3 = nil

    for Key2, Value4 in Children2, nil, nil do
        if Value4:IsA( "ScreenGui" ) then
            table.insert( Table2, Value4 )
        end
    end
else
    for Key, Value in Result.All( PlayerGui ) do
        table.insert( Table2, Value.obj )
    end
end

local Value5 = nil

for Key3, Value6 in Table2, nil, nil do
    if Value6 ~= Upvalue14 then
        local Enabled

        if Value6:IsA( "LayerCollector" ) then
            Enabled = Value6.Enabled
        else
            Enabled = Value6.Visible
        end
        if Enabled then
            Upvalue15( Value6, Value2 )
        else
            table.insert( Table, Value6 )
        end
    end
end
if SPAWN_CHARACTER then
    for Key4, Value7 in SPAWN_CHARACTER:GetDescendants( ) do
        if Value7:IsA( "BasePart" ) then
            Upvalue16( Value7, Value2 )
        end
    end
end

local Number7
local Table3 = { }
Number7 = 0

for Key5, Value8 in workspace:GetDescendants( ) do
    if Value8:IsA( "BasePart" ) and not Value8:IsA( "Terrain" ) and not Value8:IsDescendantOf( Wait ) then
        local Magnitude = ( Value8.Position - Position ).Magnitude

        if Magnitude < 220 + Value8.Size.Magnitude / 2 then
            table.insert( Table3, { Value8, Magnitude } )
        end
    end

    local Number8 = Number7 + 1

    if Number8 % 4000 == 0 then
        task.wait( )
        Number7 = Number8
    else
        Number7 = Number8
    end
end

local Value9
table.sort( Table3, function( List, List2 )
    local Flag = List[ 2 ] < List2[ 2 ] and true or false
    return Flag
end )
Value9 = nil

for Key6, Value10 in Table3, nil, nil do
    Upvalue16( Value10[ 1 ], Value2 )
end

local Value11, Number6
Value11 = nil
Number6 = 0

for Key7, Value12 in Value1, nil, nil do
    if typeof( Value12 ) == "Instance" then
        Number6 = Number6 + 1
    end
end

local Clock10 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "liste", Clock10 - Upvalue2 ) )
Upvalue3.liste = math.floor( ( Clock10 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock10
local Clock11 = os.clock( )
Upvalue17( Value1, 0.32, 0.9, Upvalue18 )
local Clock12 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "monde", Clock12 - Upvalue2 ) )
Upvalue3.monde = math.floor( ( Clock12 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock12

if not Flag then
    Upvalue7 = "Dressing up"
end
while not Flag do
    if not ( os.clock( ) - Upvalue19 < Upvalue20 ) then
        break
    end

    task.wait( 0.1 )
end

local Value15
local Clock13 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "reste de la tenue", Clock13 - Upvalue2 ) )
Upvalue3[ "reste de la tenue" ] = math.floor( ( Clock13 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock13
local Value13, Value14 = Upvalue12( )
Value14( Wait )
local WeaponVisuals = Upvalue13:FindFirstChild( "WeaponVisuals" )
local Table4 = { Upvalue8:FindFirstChildOfClass( "Backpack" ), Wait }
Value15 = nil

for Key8, Value16 in Table4, nil, nil do
    local Children = Value16 and Value16:GetChildren( ) or { }
    local Value23 = nil

    for Key11, Value24 in Children, nil, nil do
        if Value24:IsA( "Tool" ) then
            local FoundChild
            Value14( Value24 )

            if WeaponVisuals then
                local Weapon2
                local Weapon = Value24:GetAttribute( "Weapon" )
                Weapon2 = if Weapon then Weapon else Value24.Name
                FoundChild = WeaponVisuals:FindFirstChild( Weapon2 )
            else
                FoundChild = WeaponVisuals
            end
            if FoundChild then
                Value14( FoundChild )
            end
        end
    end
end

local Value17
Upvalue17( Value13, 0.9, 1, 15 )
local Clock14 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "perso et armes", Clock14 - Upvalue2 ) )
Upvalue3[ "perso et armes" ] = math.floor( ( Clock14 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock14
local Table5 = { }
local Statuts = Upvalue21.statuts
Value17 = nil

for Key9, Value18 in Statuts, nil, nil do
    table.insert( Table5, Key9 .. " " .. Value18 )
end

local Concat5
local Concat = table.concat( Upvalue1, ", " )
local Count = #Value1 + #Value13
local Concat2 = table.concat( Table5, ", " )

if #Upvalue21.lents > 0 then
    local Concat3 = table.concat( Upvalue21.lents, ", " )

    if Concat3 then
        Concat5 = Concat3
    else
        Concat5 = "aucun"
    end
else
    Concat5 = "aucun"
end

local Concat6

if #Upvalue21.echecs > 0 then
    local Concat4 = table.concat( Upvalue21.echecs, " ; " )

    if Concat4 then
        Concat6 = Concat4
    else
        Concat6 = "aucun"
    end
else
    Concat6 = "aucun"
end

local Number4
print( ( "[Chargement] étapes : %s | liste : %d (dont %d objets) | assets : %s | lots lents : %s | échecs : %s" ):format( Concat, Count, Number6, Concat2, Concat5, Concat6 ) )
local Count2 = #Value1 + #Value13
local Clock15 = os.clock( ) - Clock11
print( ( "[Chargement] %d fichiers préchargés en %.1f s (monde à %d studs, perso, armes, interface) ; écran parti après %.1f s" ):format( Count2, Clock15, 220, os.clock( ) - Upvalue19 ) )
local Clock16 = os.clock( )
Number4 = 0

while Number4 < 0.5 do
    if Upvalue8:GetAttribute( "Onboarding" ) == false or not ( os.clock( ) - Upvalue19 < Upvalue20 ) then
        break
    end
    if os.clock( ) - Clock16 > 1 and Upvalue7 ~= "Opening the wardrobe" then
        Upvalue7 = "Opening the wardrobe"
    end

    local Flag2
    local Min = math.min( task.wait( 0.1 ), 0.15 )

    if Upvalue8:GetAttribute( "Onboarding" ) == true then
        if Upvalue8:GetAttribute( "InWardrobe" ) == true then
            Flag2 = not Upvalue8.GameplayPaused
        else
            Flag2 = false
        end
    else
        Flag2 = false
    end

    local Number5 = Flag2 and Number4 + Min or 0
    Number4 = Number5
end
if os.clock( ) - Clock16 > 1 then
    print( ( "[Chargement] arrivée dans la garde-robe attendue %.1f s" ):format( os.clock( ) - Clock16 ) )
end

local Clock17 = os.clock( )
table.insert( Upvalue1, ( "%s %.1f s" ):format( "garde-robe", Clock17 - Upvalue2 ) )
Upvalue3[ "garde-robe" ] = math.floor( ( Clock17 - Upvalue2 ) * 10 + 0.5 ) / 10
Upvalue2 = Clock17
Upvalue22 = #Value1 + #Value13

if not Upvalue23 then
    Upvalue23 = true
    local Clock18 = os.clock( ) - Upvalue19
    local Flag3 = false
    task.spawn( function()
        local ChargementStats
        local Remotes = Upvalue13:FindFirstChild( "Remotes" )

        if Remotes then
            ChargementStats = Remotes:WaitForChild( "ChargementStats", 15 )
        else
            ChargementStats = Remotes
        end
        if not ChargementStats or not ChargementStats:IsA( "RemoteEvent" ) then
            return
        end

        local M
        local Success, Result = pcall( function()
            return game:GetService( "Stats" ):GetTotalMemoryUsageMb( )
        end )
        local Success2, Result2 = pcall( function()
            return UserSettings( ):GetService( "UserGameSettings" ).SavedQualityLevel.Value
        end )
        local FireServer = ChargementStats.FireServer
        local Table = { e = Upvalue3, t = Clock18, d = Upvalue24( ) }
        M = Success and Result or nil
        local Q
        Table.m = M
        Q = Success2 and Result2 or nil
        local Cap
        Table.q = Q
        Table.f = Upvalue21.statuts.Failure or 0
        Table.n = Upvalue22
        Table.a0 = Upvalue25
        Cap = Flag3 == true and true or false
        local S
        Table.cap = Cap
        S = Flag3 and Upvalue7 or nil
        Table.s = S
        pcall( FireServer, ChargementStats, Table )
    end )
end

local Value21
Upvalue9 = true
local Value19, Value20 = Upvalue12( )
Value21 = nil

for Key10, Value22 in Table, nil, nil do
    if Value22.Parent then
        Upvalue15( Value22, Value20 )
    end
end

Upvalue26( ( Upvalue27( Value19 ) ) )
print( ( "[Chargement] menus : %d fichiers mis en file (en fond)" ):format( #Value19 ) )
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = true
]]
