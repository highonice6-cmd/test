-- StarterPlayer.StarterPlayerScripts.NetBeatClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Players = game:GetService( "Players" )
local CollectionService = game:GetService( "CollectionService" )
local Beat = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "Beat" )
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService( "HttpService" )

local function Bmix( Argument1 )
    local Bxor = bit32.bxor( Argument1, ( bit32.lshift( Argument1, 13 ) ) )
    local Bxor2 = bit32.bxor( Bxor, ( bit32.rshift( Bxor, 17 ) ) )
    return ( bit32.bxor( Bxor2, ( bit32.lshift( Bxor2, 5 ) ) ) )
end

local function Bkey( Amount, Amount2 )
    local Bxor5
    local Result = Amount % 4294967296
    local Bxor = bit32.bxor( Result, Amount2 % 4294967296, 1540483477 )
    local Bxor2 = bit32.bxor( Bxor, ( bit32.lshift( Bxor, 13 ) ) )
    local Bxor3 = bit32.bxor( Bxor2, ( bit32.rshift( Bxor2, 17 ) ) )
    local Bxor4 = bit32.bxor( Bxor3, ( bit32.lshift( Bxor3, 5 ) ) )
    Bxor5 = if Bxor4 == 0 then 625341585 else Bxor4
    local Bxor9
    local Bxor6 = bit32.bxor( Bxor5, ( bit32.lshift( Bxor5, 13 ) ) )
    local Bxor7 = bit32.bxor( Bxor6, ( bit32.rshift( Bxor6, 17 ) ) )
    local Bxor8 = bit32.bxor( Bxor7, ( bit32.lshift( Bxor7, 5 ) ) )
    Bxor9 = if Bxor8 == 0 then 625341585 else Bxor8
    local Bxor13
    local Bxor10 = bit32.bxor( Bxor9, ( bit32.lshift( Bxor9, 13 ) ) )
    local Bxor11 = bit32.bxor( Bxor10, ( bit32.rshift( Bxor10, 17 ) ) )
    local Bxor12 = bit32.bxor( Bxor11, ( bit32.lshift( Bxor11, 5 ) ) )
    Bxor13 = if Bxor12 == 0 then 625341585 else Bxor12
    local Bxor17
    local Bxor14 = bit32.bxor( Bxor13, ( bit32.lshift( Bxor13, 13 ) ) )
    local Bxor15 = bit32.bxor( Bxor14, ( bit32.rshift( Bxor14, 17 ) ) )
    local Bxor16 = bit32.bxor( Bxor15, ( bit32.lshift( Bxor15, 5 ) ) )
    Bxor17 = if Bxor16 == 0 then 625341585 else Bxor16
    return Bxor17
end

local function Bstream( Argument1, Amount )
    local Bxor5
    local Bxor = bit32.bxor( Argument1, Amount % 4294967296 )
    local Bxor2 = bit32.bxor( Bxor, ( bit32.lshift( Bxor, 13 ) ) )
    local Bxor3 = bit32.bxor( Bxor2, ( bit32.rshift( Bxor2, 17 ) ) )
    local Bxor4 = bit32.bxor( Bxor3, ( bit32.lshift( Bxor3, 5 ) ) )
    Bxor5 = if Bxor4 == 0 then 1831565813 else Bxor4

    local function Callback()
        local Bxor = bit32.bxor( Bxor5, ( bit32.lshift( Bxor5, 13 ) ) )
        local Bxor2 = bit32.bxor( Bxor, ( bit32.rshift( Bxor, 17 ) ) )
        Bxor5 = bit32.bxor( Bxor2, ( bit32.lshift( Bxor2, 5 ) ) )
        return ( bit32.band( Bxor5, 255 ) )
    end

    return Callback
end

local function Bsum( Create, Argument2 )
    local Bxor
    local I = 0
    Bxor = Argument2

    for I = 0, 187 do
        local Bxor2 = bit32.bxor( Bxor, buffer.readu8( Create, I ) + I * 256 )
        local Bxor3 = bit32.bxor( Bxor2, ( bit32.lshift( Bxor2, 13 ) ) )
        local Bxor4 = bit32.bxor( Bxor3, ( bit32.rshift( Bxor3, 17 ) ) )
        local Bxor5 = bit32.bxor( Bxor4, ( bit32.lshift( Bxor4, 5 ) ) )

        if Bxor5 == 0 then
            Bxor = 1
        else
            Bxor = Bxor5
        end
    end

    return Bxor
end

local Random2 = Random.new( )

local function Bencode( Argument1, Amount, Code, List, Argument5, Argument6 )
    local Create = buffer.create( 192 )
    buffer.writeu32( Create, 0, Amount )
    buffer.writeu16( Create, 4, Code )
    buffer.writeu16( Create, 6, Argument5 )
    buffer.writeu16( Create, 8, Argument6 )
    local Min = math.min( #List, 177 )
    buffer.writeu8( Create, 10, Min )

    if Min > 0 then
        buffer.writestring( Create, 11, List, Min )
    end

    local Min2 = Min + 11
    local I = Min2

    for I = Min2, 187 do
        buffer.writeu8( Create, I, ( Random2:NextInteger( 0, 255 ) ) )
    end

    local Bxor5
    buffer.writeu32( Create, 188, ( Bsum( Create, Argument1 ) ) )
    local Bxor = bit32.bxor( Argument1, Amount % 4294967296 )
    local Bxor2 = bit32.bxor( Bxor, ( bit32.lshift( Bxor, 13 ) ) )
    local Bxor3 = bit32.bxor( Bxor2, ( bit32.rshift( Bxor2, 17 ) ) )
    local Bxor4 = bit32.bxor( Bxor3, ( bit32.lshift( Bxor3, 5 ) ) )
    Bxor5 = if Bxor4 == 0 then 1831565813 else Bxor4

    local function Callback()
        local Bxor = bit32.bxor( Bxor5, ( bit32.lshift( Bxor5, 13 ) ) )
        local Bxor2 = bit32.bxor( Bxor, ( bit32.rshift( Bxor, 17 ) ) )
        Bxor5 = bit32.bxor( Bxor2, ( bit32.lshift( Bxor2, 5 ) ) )
        return ( bit32.band( Bxor5, 255 ) )
    end

    local I2 = 4

    for I2 = 4, 191 do
        local Readu8 = buffer.readu8( Create, I2 )
        buffer.writeu8( Create, I2, ( bit32.bxor( Readu8, Callback( ) ) ) )
    end

    return Create
end

local function Fit( List, Name, Amount )
    if type( List ) == "string" then
        local Number = Name ~= "path" and 50 or 100
        return List:sub( 1, Number )
    end
    if type( List ) == "number" or type( List ) == "boolean" then
        return List
    end
    if type( List ) ~= "table" or not ( ( Amount or 0 ) < 2 ) then
        return tostring( List ):sub( 1, 50 )
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Key ) == "string" or type( Key ) == "number" then
            Table[ Key ] = Fit( Value, Key, ( Amount or 0 ) + 1 )
        end
    end

    return Table
end

local Table = { }
local Number = 0
local Number2 = 0
local Value1 = nil

local function OnSync( SyncName, Argument2 )
    if SyncName == "k" and type( Argument2 ) == "number" then
        Value1 = Value1 or Argument2
        return
    end
    if SyncName == "a" and type( Argument2 ) == "number" and Number2 < Argument2 then
        Number2 = Argument2
    end
end

Beat.OnClientEvent:Connect( OnSync )
task.spawn( function()
    local TimeSync = Beat.Parent:WaitForChild( "TimeSync", 60 )

    if not TimeSync or not TimeSync:IsA( "RemoteEvent" ) then
        return
    end

    TimeSync.OnClientEvent:Connect( OnSync )

    while not Value1 do
        pcall( function()
            TimeSync:FireServer( "k" )
        end )
        task.wait( 2 )
    end
end )
local Stats = game:GetService( "Stats" )

local function Cut( List, Amount )
    local Total, Value1

    if type( List ) ~= "string" then
        return nil
    end
    if #List <= Amount then
        return List
    end

    Total = Amount + 1

    while Total > 1 do
        local Byte = List:byte( Total )

        if not Byte or not ( Byte >= 128 ) or not ( Byte < 192 ) then
            Value1 = List
            break
        end

        Total = Total - 1
    end

    Value1 = List
    return Value1:sub( 1, Total - 1 )
end

local function Fnv( List )
    local Number
    local Count = #List
    local I = 1
    Number = 2166136261

    for I = 1, Count do
        local Bxor = bit32.bxor( Number, string.byte( List, I ) )
        Number = ( bit32.lshift( Bxor, 24 ) + Bxor * 403 ) % 4294967296
    end

    return string.format( "%08x", Number )
end

local function LookPrint( Object )
    local Table = { }

    for Key, Value in Object:GetDescendants( ) do
        if not Value:FindFirstAncestorWhichIsA( "Tool" ) then
            if Value:IsA( "Shirt" ) then
                table.insert( Table, "S" .. Value.ShirtTemplate )
            elseif Value:IsA( "Pants" ) then
                table.insert( Table, "P" .. Value.PantsTemplate )
            elseif Value:IsA( "ShirtGraphic" ) then
                table.insert( Table, "G" .. Value.Graphic )
            elseif Value:IsA( "MeshPart" ) then
                local Name = Value.Name
                local MeshId = Value.MeshId
                table.insert( Table, "M" .. Name .. "|" .. MeshId .. "|" .. Value.TextureID )
            elseif Value:IsA( "SpecialMesh" ) then
                local MeshId2 = Value.MeshId
                table.insert( Table, "H" .. MeshId2 .. "|" .. Value.TextureId )
            elseif Value:IsA( "Decal" ) and Value.Name == "face" and Value.Parent and Value.Parent.Name == "Head" then
                table.insert( Table, "F" .. Value.Texture )
            end
        end
    end

    table.sort( Table )
    return Fnv( table.concat( Table, "\n" ) )
end

local function ToolsPrint( Self )
    local Value1
    local Table = { }
    local Table2 = { Self.Character, Self:FindFirstChildOfClass( "Backpack" ) }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value then
            for Key2, Value2 in Value:GetChildren( ) do
                if Value2:IsA( "Tool" ) and Value2:GetAttribute( "Weapon" ) ~= nil then
                    local Text = tostring( Value2:GetAttribute( "Weapon" ) )
                    table.insert( Table, Text .. "|" .. tostring( Value2:GetAttribute( "Mods" ) or "" ) )
                end
            end
        end
    end

    table.sort( Table )
    return Fnv( table.concat( Table, "\n" ) )
end

local Flag = false
local Value2 = nil
task.spawn( function()
    local Success, Result = pcall( function()
        return require( ReplicatedStorage:WaitForChild( "GamePasses", 30 ) )
    end )
    Flag = Success
    Value2 = Result
end )

local function PassPrint( Self, Argument2 )
    local Value1
    local Table = { }
    local ById = Argument2.ById
    Value1 = nil

    for Key, Value in ById, nil, nil do
        if type( Value ) == "table" then
            if type( Value.Attr ) == "string" then
                Table[ Value.Attr ] = true
            end
            if type( Value.Grants ) == "table" then
                local Value6
                local Grants = Value.Grants
                Value6 = nil

                for Key3, Value7 in Grants, nil, nil do
                    Table[ Value7 ] = true
                end
            end
        end
    end

    local Value2
    local Table2 = { }
    Value2 = nil

    for Value3 in Table, nil, nil do
        if Self:GetAttribute( Value3 ) == true then
            table.insert( Table2, Value3 )
        end
    end

    local Value4
    table.sort( Table2 )
    local Table3 = { }
    local Table4 = { "KillFX", "TracerFX", "SkyFX", "KillMsg" }
    Value4 = nil

    for Key2, Value5 in Table4, nil, nil do
        table.insert( Table3, ( tostring( Self:GetAttribute( Value5 ) ) ) )
    end

    local Concat = table.concat( Table2, "," )
    return Fnv( Concat .. "|" .. table.concat( Table3, "," ) )
end

local Value3 = nil
task.spawn( function()
    local Success, Result = pcall( function()
        return require( ReplicatedStorage:WaitForChild( "CarCustom", 60 ) )
    end )

    if Success and type( Result ) == "table" then
        Value3 = Result
    end
end )

local function C255( Argument1 )
    local Floor = math.floor( Argument1.R * 255 + 0.5 )
    local Floor2 = math.floor( Argument1.G * 255 + 0.5 )
    return Floor .. "," .. Floor2 .. "," .. math.floor( Argument1.B * 255 + 0.5 )
end

local function H4( List )
    table.sort( List )
    return ( string.sub( Fnv( table.concat( List, "\n" ) ), -4 ) )
end

local function CarPrint( Self, List )
    local PAINT_PARTS2
    local Table = { }

    if List then
        local PAINT_PARTS = List.PAINT_PARTS

        if PAINT_PARTS then
            PAINT_PARTS2 = List.PAINT_PARTS[ Self.Name ]
        else
            PAINT_PARTS2 = PAINT_PARTS
        end
    else
        PAINT_PARTS2 = List
    end
    if PAINT_PARTS2 then
        local Value1 = nil

        for Key, Value in PAINT_PARTS2, nil, nil do
            Table[ Value ] = true
        end
    else
        local Value3 = nil

        for Key2, Value2 in Self:GetDescendants( ) do
            if Value2:IsA( "BasePart" ) and Value2.Name:sub( 1, 4 ) == "Body" then
                local Magnitude = Value2.Size.Magnitude

                if Value3 and not ( Value3.Size.Magnitude < Magnitude ) then
                    if Magnitude ~= Value3.Size.Magnitude or not ( Value2.Name < Value3.Name ) then
                        continue
                    end
                end

                Value3 = Value2
            end
        end
        if Value3 then
            Table[ Value3.Name ] = true
        end
    end

    local RIM_PREFIX = List and List.RIM_PREFIX or "Jente"
    local BRAKE_PREFIX = List and List.BRAKE_PREFIX or "Plaquette"
    local HEADLIGHT_PREFIX = List and List.HEADLIGHT_PREFIX or "FrontLights"
    local Table2 = { }
    local Table3 = { }
    local Table4 = { }
    local Table5 = { }
    local Table6 = { }

    for Key3, Value4 in Self:GetDescendants( ) do
        if Value4:IsA( "BasePart" ) and Value4.Name:sub( 1, #HEADLIGHT_PREFIX ) ~= HEADLIGHT_PREFIX and Value4:GetAttribute( "LitColor" ) == nil and Value4:GetAttribute( "LitMaterial" ) == nil then
            if Table[ Value4.Name ] then
                local TextureID
                local Color = Value4.Color
                local Floor = math.floor( Color.R * 255 + 0.5 )
                local Floor2 = math.floor( Color.G * 255 + 0.5 )
                local Text2 = Floor .. "," .. Floor2 .. "," .. math.floor( Color.B * 255 + 0.5 )
                local Name = Value4.Material.Name
                TextureID = Value4:IsA( "MeshPart" ) and Value4.TextureID or ""
                table.insert( Table2, Value4.Name .. "|" .. Text2 .. "|" .. Name .. "|" .. TextureID )
                local Table8 = { }

                for Key5, Value6 in Value4:GetChildren( ) do
                    if Value6:IsA( "Texture" ) and Value6.Name == "CC_Wrap" then
                        table.insert( Table8, ( tostring( Value6.Texture ) ) )
                    end
                end

                table.sort( Table8 )
                table.insert( Table3, Value4.Name .. "|" .. table.concat( Table8, "," ) )
            elseif Value4.Name:sub( 1, #RIM_PREFIX ) == RIM_PREFIX then
                local CC_Rim = Value4:FindFirstChild( "CC_Rim" )
                local Table9 = { }

                if CC_Rim then
                    for Key6, Value7 in CC_Rim:GetDescendants( ) do
                        if Value7:IsA( "MeshPart" ) or Value7:IsA( "SpecialMesh" ) then
                            table.insert( Table9, Value7.MeshId )
                        end
                    end
                end

                local Text3
                table.sort( Table9 )
                Text3 = not CC_Rim and "0" or "1"
                table.insert( Table4, Value4.Name .. "|" .. Text3 .. "|" .. table.concat( Table9, "," ) )
            elseif Value4.Name:sub( 1, #BRAKE_PREFIX ) == BRAKE_PREFIX then
                local Color2 = Value4.Color
                local Floor3 = math.floor( Color2.R * 255 + 0.5 )
                local Floor4 = math.floor( Color2.G * 255 + 0.5 )
                local Text4 = Floor3 .. "," .. Floor4 .. "," .. math.floor( Color2.B * 255 + 0.5 )
                table.insert( Table5, Value4.Name .. "|" .. Text4 .. "|" .. Value4.Material.Name )
            end
        end
    end

    local CC_Spoiler = Self:FindFirstChild( "CC_Spoiler", true )

    if CC_Spoiler then
        table.insert( Table6, "1" )

        for Key4, Value5 in CC_Spoiler:GetDescendants( ) do
            if Value5:IsA( "MeshPart" ) then
                local MeshId = Value5.MeshId
                table.insert( Table6, MeshId .. "|" .. Value5.TextureID )
            end
        end
    end

    local Text
    local Table7 = { }
    Text = not Self:FindFirstChild( "CC_Underglow" ) and "0" or "1"
    Table7[ 1 ] = Text .. "|" .. tostring( Self:GetAttribute( "NeonRainbow" ) )
    table.sort( Table2 )
    local Sub = string.sub( Fnv( table.concat( Table2, "\n" ) ), -4 )
    table.sort( Table3 )
    local Sub2 = string.sub( Fnv( table.concat( Table3, "\n" ) ), -4 )
    table.sort( Table4 )
    local Sub3 = string.sub( Fnv( table.concat( Table4, "\n" ) ), -4 )
    table.sort( Table5 )
    local Sub4 = string.sub( Fnv( table.concat( Table5, "\n" ) ), -4 )
    table.sort( Table6 )
    local Sub5 = string.sub( Fnv( table.concat( Table6, "\n" ) ), -4 )
    table.sort( Table7 )
    return Sub .. Sub2 .. Sub3 .. Sub4 .. Sub5 .. string.sub( Fnv( table.concat( Table7, "\n" ) ), -4 )
end

local function OwnCar( Player, Object )
    local Humanoid
    local Character = Player.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end

    local Character2 = if Humanoid then Humanoid.SeatPart else Humanoid
    local Model

    if Character2 then
        Model = Character2:FindFirstAncestorWhichIsA( "Model" )
    else
        Model = Character2
    end
    while Model do
        if Object:HasTag( Model, "Vehicle" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end
    if not Model or tonumber( Model:GetAttribute( "OwnerId" ) ) ~= Player.UserId or Model:GetAttribute( "InGarage" ) ~= nil then
        return nil
    end
    return Model
end

local function MeleePrint( Self )
    local Value1
    local Table = { }
    local Table2 = { Self.Character, Self:FindFirstChildOfClass( "Backpack" ) }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        if Value then
            for Key2, Value2 in Value:GetChildren( ) do
                if Value2:IsA( "Tool" ) and Value2:GetAttribute( "Melee" ) ~= nil then
                    local Table3 = { }

                    for Key3, Value3 in Value2:GetDescendants( ) do
                        if Value3:IsA( "BasePart" ) then
                            local Table4 = { }

                            for Key4, Value4 in Value3:GetChildren( ) do
                                if Value4:IsA( "Texture" ) then
                                    table.insert( Table4, ( tostring( Value4.Texture ) ) )
                                elseif Value4:IsA( "SpecialMesh" ) then
                                    local MeshId2 = Value4.MeshId
                                    table.insert( Table4, "M" .. MeshId2 .. "|" .. Value4.TextureId )
                                end
                            end

                            local Text5
                            table.sort( Table4 )
                            local Name = Value3.Name
                            local Color = Value3.Color
                            local Floor = math.floor( Color.R * 255 + 0.5 )
                            local Floor2 = math.floor( Color.G * 255 + 0.5 )
                            local Text3 = Floor .. "," .. Floor2 .. "," .. math.floor( Color.B * 255 + 0.5 )
                            local Name2 = Value3.Material.Name

                            if Value3:IsA( "MeshPart" ) then
                                local MeshId = Value3.MeshId
                                local Text4 = MeshId .. "|" .. Value3.TextureID

                                if Text4 then
                                    Text5 = Text4
                                else
                                    Text5 = ""
                                end
                            else
                                Text5 = ""
                            end

                            table.insert( Table3, Name .. "|" .. Text3 .. "|" .. Name2 .. "|" .. Text5 .. "|" .. table.concat( Table4, "," ) )
                        end
                    end

                    table.sort( Table3 )
                    local Text = tostring( Value2:GetAttribute( "Melee" ) )
                    local Text2 = tostring( Value2:GetAttribute( "Mods" ) or "" )
                    table.insert( Table, Text .. "|" .. Text2 .. "|" .. table.concat( Table3, ";" ) )
                end
            end
        end
    end

    table.sort( Table )
    return Fnv( table.concat( Table, "\n" ) )
end

local function WearId( Self )
    if Self:IsA( "Shirt" ) then
        return Self.ShirtTemplate
    end
    if Self:IsA( "Pants" ) then
        return Self.PantsTemplate
    end
    if Self:IsA( "ShirtGraphic" ) then
        return Self.Graphic
    end
    if not Self:IsA( "Accessory" ) then
        return ""
    end

    local Handle = Self:FindFirstChild( "Handle" )

    if Handle and Handle:IsA( "MeshPart" ) then
        return Handle.MeshId
    end

    local SpecialMesh

    if Handle then
        SpecialMesh = Handle:FindFirstChildOfClass( "SpecialMesh" )
    else
        SpecialMesh = Handle
    end

    local MeshId = SpecialMesh and SpecialMesh.MeshId or ""
    return MeshId
end

local Number3 = 0

local function Sample()
    local N
    Number3 = Number3 + 1
    local Character = LocalPlayer.Character
    local Table = {
        f = math.floor( ( workspace:GetRealPhysicsFPS( ) ) ),
        m = math.floor( ( Stats:GetTotalMemoryUsageMb( ) ) )
    }

    if Character then
        local Count = #Character:GetChildren( )

        if Count then
            N = Count
        else
            N = 0
        end
    else
        N = 0
    end

    Table.n = N

    if Number3 % 2 == 0 then
        Table.x = true

        if Character then
            local K
            local Success, Result = pcall( LookPrint, Character )
            K = Success and Result or nil
            Table.k = K
        end

        local W
        local Success2, Result2 = pcall( ToolsPrint, LocalPlayer )
        W = Success2 and Result2 or nil
        Table.w = W

        if Flag and type( Value2 ) == "table" and type( Value2.ById ) == "table" then
            local G
            local Success3, Result3 = pcall( PassPrint, LocalPlayer, Value2 )
            G = Success3 and Result3 or nil
            Table.g = G
        end

        local V
        local AssetRev = LocalPlayer:GetAttribute( "AssetRev" )
        V = type( AssetRev ) == "number" and AssetRev or nil
        local E
        Table.v = V
        local Success4, Result4 = pcall( MeleePrint, LocalPlayer )
        E = Success4 and Result4 or nil
        Table.e = E

        if Value3 then
            local Success5, Result5 = pcall( OwnCar, LocalPlayer, CollectionService )

            if Success5 and Result5 then
                local R
                local Success6, Result6 = pcall( CarPrint, Result5, Value3 )
                R = Success6 and Result6 or nil
                Table.r = R
            end
        end

        local Success7, Result7 = pcall( HttpService.JSONEncode, HttpService, Table )

        if Success7 and #Result7 > 177 then
            Table.r = nil
            Table.e = nil
        end

        return Table
    end
    local NameTag

    if Character then
        NameTag = Character:FindFirstChild( "NameTag" )
    else
        NameTag = Character
    end

    local Nom

    if NameTag then
        Nom = NameTag:FindFirstChild( "Nom" )
    else
        Nom = NameTag
    end
    if Nom and Nom:IsA( "TextLabel" ) then
        local ContentText = Nom.ContentText ~= "" and Nom.ContentText or Nom.Text
        Table.a = Cut( ContentText, 32 )
    end

    local B = Cut( LocalPlayer.DisplayName, 32 )
    local C = Cut( LocalPlayer.Name, 32 )
    Table.b = B
    Table.c = C
    return Table
end

task.spawn( function()
    while not Value1 do
        pcall( function()
            Beat:FireServer( "k" )
        end )
        local Clock = os.clock( )

        while not Value1 do
            if not ( os.clock( ) - Clock < 1 ) then
                break
            end

            task.wait( 0.1 )
        end
    end

    local Flag, Number2Inner
    local Bkey2 = Bkey( LocalPlayer.UserId, Value1 )
    local NextInteger = Random2:NextInteger( 1, 100000 )
    Flag = false
    Number2Inner = 0

    while true do
        local Value2
        local NextInteger2 = NextInteger + 1
        Value2 = nil

        for Value in Table, nil, nil do
            if Value <= Number2 then
                Table[ Value ] = nil
            end
        end

        local Item, Table2

        if NextInteger2 % 7 == 0 then
            local Success, Result = pcall( Sample )

            if Success then
                Table2 = { code = 1, extra = Result }
                Item = 0
            else
                Table2 = nil
                Item = 0
            end
        else
            local Value3
            local TableInner = { }
            Value3 = nil

            for Value4 in Table, nil, nil do
                table.insert( TableInner, Value4 )
            end
            if #TableInner > 0 then
                table.sort( TableInner )
                local NotFlag = not Flag

                if NotFlag then
                    Item = TableInner[ 1 ]
                else
                    local NumberInner = Number2Inner + 1
                    Item = TableInner[ ( NumberInner - 1 ) % #TableInner + 1 ]
                    Number2Inner = NumberInner
                end

                Table2 = Table[ Item ]
                Flag = NotFlag
            else
                Table2 = nil
                Item = 0
            end
        end

        local Text

        if not Table2 or Table2.extra == nil then
            Text = ""
        else
            local Result3
            local Success2, Result2 = pcall( function()
                return HttpService:JSONEncode( Fit( Table2.extra ) )
            end )
            Result3 = Success2 and type( Result2 ) == "string" and Result2 or ""
            Text = Result3
        end

        local Code = Table2 and Table2.code or 0
        pcall( function()
            Beat:FireServer( ( Bencode( Bkey2, NextInteger2, Code, Text, math.min( Number, 65535 ), ( math.min( Item, 65535 ) ) ) ) )
        end )
        task.wait( 0.3 )
        NextInteger = NextInteger2
    end
end )
local Table2 = { }
local Number4 = 0

local function Report( Amount, Argument2, Argument3 )
    local Value1 = Argument3 or Amount

    if Table2[ Value1 ] then
        return
    end
    if Amount == 7701 then
        if Number4 >= 12 then
            return
        end

        Number4 = Number4 + 1
    end

    Table2[ Value1 ] = true
    Number = Number + 1
    Table[ Number ] = { code = Amount, extra = Argument2 }
end

local Number5 = 0
task.spawn( function()
    local Success, Result = pcall( function()
        return require( ReplicatedStorage:WaitForChild( "KillEffects", 60 ) )
    end )
    local KillFX = ReplicatedStorage:WaitForChild( "KillFX", 60 )

    if not Success or type( Result ) ~= "table" or type( Result.Effects ) ~= "table" or not KillFX then
        return
    end

    local Value1

    local function Shape( Self )
        local Number
        local Table = { }
        Number = 0

        for Key, Value in Self:GetDescendants( ) do
            Number = Number + 1

            if Value:IsA( "ParticleEmitter" ) then
                local Name = Value.Name
                table.insert( Table, Name .. "=" .. tostring( Value.Texture ) )
            end
        end

        table.sort( Table )
        local ClassName = Self.ClassName
        return ClassName .. "|" .. Number .. "|" .. table.concat( Table, "," )
    end

    local TableInner = { }
    local Effects = Result.Effects
    Value1 = nil

    for Key, Value in Effects, nil, nil do
        local Match

        if type( Value.Template ) == "string" then
            Match = Value.Template:match( "([^%.]+)$" )
        else
            Match = false
        end
        if Match then
            TableInner[ Match ] = Key
        end
    end

    local Table2Inner = { }

    local function ShapeOf( Name )
        if not Table2Inner[ Name ] then
            local FoundChild = KillFX:FindFirstChild( Name )

            if FoundChild then
                Table2Inner[ Name ] = Shape( FoundChild )
            end
        end

        return Table2Inner[ Name ]
    end

    local Class = setmetatable( { }, { __mode = "k" } )

    local function Check( Key )
        if Number5 >= 6 or Class[ Key ] then
            return
        end

        local Name = Result.Effects[ Key.Name ] and Key.Name or TableInner[ Key.Name ]

        if Name then
            Class[ Key ] = true
            task.defer( function()
                if not Table2Inner[ Name ] then
                    local FoundChild = KillFX:FindFirstChild( Name )

                    if FoundChild then
                        Table2Inner[ Name ] = Shape( FoundChild )
                    end
                end

                local Entry = Table2Inner[ Name ]

                if not Entry or not Key.Parent or Shape( Key ) ~= Entry then
                    return
                end

                Number5 = Number5 + 1
                local TableInner = { n = Name, i = Number5 }
                local Text = "fx" .. Number5 or 7314

                if Table2[ Text ] then
                    return
                end
                Table2[ Text ] = true
                Number = Number + 1
                Table[ Number ] = { code = 7314, extra = TableInner }
                return
            end )
            return
        end
        return
    end

    local Class2 = setmetatable( { }, { __mode = "k" } )

    local function Hook( Key )
        if not Key or Class2[ Key ] then
            return
        end
        Class2[ Key ] = true
        Key.ChildAdded:Connect( Check )
        return
    end

    if workspace then
        if not Class2[ workspace ] then
            Class2[ workspace ] = true
            workspace.ChildAdded:Connect( Check )
        end
    end

    local FX = workspace:FindFirstChild( "FX" )

    if FX then
        if not Class2[ FX ] then
            Class2[ FX ] = true
            FX.ChildAdded:Connect( Check )
        end
    end

    workspace.ChildAdded:Connect( function( Key )
        if Key.Name == "FX" and Key then
            if Class2[ Key ] then
                return
            end

            Class2[ Key ] = true
            Key.ChildAdded:Connect( Check )
        end
    end )
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        if not Class2[ CurrentCamera ] then
            Class2[ CurrentCamera ] = true
            CurrentCamera.ChildAdded:Connect( Check )
        end
    end

    workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( function()
        local CurrentCamera = workspace.CurrentCamera

        if CurrentCamera then
            if Class2[ CurrentCamera ] then
                return
            end

            Class2[ CurrentCamera ] = true
            CurrentCamera.ChildAdded:Connect( Check )
        end
    end )
end )
local Table3 = {
    number = true,
    string = true,
    boolean = true,
    Vector2 = true,
    Vector3 = true,
    Color3 = true,
    CFrame = true,
    UDim = true,
    UDim2 = true,
    EnumItem = true,
    NumberRange = true
}

local function Plain( Argument1 )
    local Text2

    if Table3[ typeof( Argument1 ) ] then
        local Text = tostring( Argument1 )

        if Text then
            Text2 = Text
        else
            Text2 = "<" .. typeof( Argument1 ) .. ">"
        end
    else
        Text2 = "<" .. typeof( Argument1 ) .. ">"
    end

    return Text2
end

local function Sig( List, Amount )
    local Value1
    local Number = Amount or 0
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Text5

        if type( Value ) == "table" then
            local Text2

            if Number < 4 then
                local Text = "{" .. Sig( Value, Number + 1 ) .. "}"

                if Text then
                    Text2 = Text
                else
                    Text2 = "{}"
                end
            else
                Text2 = "{}"
            end

            Text5 = Text2
        elseif Table3[ typeof( Value ) ] then
            local Text3 = tostring( Value )

            if Text3 then
                Text5 = Text3
            else
                Text5 = "<" .. typeof( Value ) .. ">"
            end
        else
            Text5 = "<" .. typeof( Value ) .. ">"
        end

        local Text6

        if Table3[ typeof( Key ) ] then
            local Text4 = tostring( Key )

            if Text4 then
                Text6 = Text4
            else
                Text6 = "<" .. typeof( Key ) .. ">"
            end
        else
            Text6 = "<" .. typeof( Key ) .. ">"
        end

        table.insert( Table, Text6 .. "=" .. Text5 )
    end

    table.sort( Table )
    return table.concat( Table, ";" )
end

local function DeepFreeze( List, Amount )
    if Amount > 5 then
        return
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Value ) == "table" then
            DeepFreeze( Value, Amount + 1 )
        end
    end
    if not table.isfrozen( List ) then
        table.freeze( List )
    end
end

local function AllFrozen( List, Amount )
    if not table.isfrozen( List ) then
        return false
    end
    if Amount > 5 then
        return true
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Value ) == "table" then
            if not AllFrozen( Value, Amount + 1 ) then
                return false
            end
        end
    end

    return true
end

local Table4 = { }
local Success, Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
end )

if Success and type( Result ) == "table" then
    local Value4 = nil

    for Key, Value in Result, nil, nil do
        if type( Value ) == "table" then
            local Value5
            local Table5 = { "Ammo", "Bloom", "Damage", "Fire", "Handling", "Recoil" }
            Value5 = nil

            for Key2, Value6 in Table5, nil, nil do
                local Entry = Value[ Value6 ]

                if type( Entry ) == "table" then
                    DeepFreeze( Entry, 0 )
                    table.insert( Table4, { t = Entry, s = Sig( Entry ), name = tostring( Key ) .. "." .. Value6 } )
                end
            end
        end
    end
end

local Number6
local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
local Success2, Result2 = pcall( function()
    return require( Weapons:WaitForChild( "Config" ) )
end )
local Success3, Result3 = pcall( function()
    return require( Weapons:WaitForChild( "ClientState" ) )
end )
local ModCatalog = ReplicatedStorage:FindFirstChild( "ModCatalog", true )
local Success4, Result4 = pcall( function()
    return ModCatalog and require( ModCatalog )
end )

if not Success4 or type( Result4 ) ~= "table" or type( Result4.Items ) ~= "table" then
    Number6 = 1
else
    local Value7
    local Items = Result4.Items
    Value7 = nil
    Number6 = 1

    for Key3, Value8 in Items, nil, nil do
        if type( Value8 ) == "table" and type( Value8.SpreadScale ) == "number" and Value8.SpreadScale < 1 then
            Number6 = Number6 * Value8.SpreadScale
        end
    end
end

local Number8
local Number7 = Number6 * 0.9

local function SpreadCheck()
    if Success2 and type( Result2 ) == "table" and type( Result2.Global ) == "table" then
        local BloomRef
        local Config = Weapons:FindFirstChild( "Config" )

        if Config then
            BloomRef = Weapons.Config:GetAttribute( "BloomRef" )
        else
            BloomRef = Config
        end

        local BloomScale = Result2.Global.BloomScale

        if type( BloomRef ) == "number" and BloomScale ~= BloomRef then
            local Text = "Config.Global.BloomScale " .. tostring( BloomScale ) .. " (server " .. BloomRef .. ")"

            if not Table2[ 7501 ] then
                Table2[ 7501 ] = true
                Number = Number + 1
                Table[ Number ] = { code = 7501, extra = Text }
            end
        end
    end
    if Success3 and type( Result3 ) == "table" then
        local SpreadMultiplier = Result3.SpreadMultiplier

        if type( SpreadMultiplier ) == "number" and SpreadMultiplier < Number7 then
            local Text2 = "ClientState.SpreadMultiplier " .. tostring( SpreadMultiplier )

            if Table2[ 7501 ] then
                return
            end

            Table2[ 7501 ] = true
            Number = Number + 1
            Table[ Number ] = { code = 7501, extra = Text2 }
        end
    end
end

local Table6 = { RecoilPitch = true, RecoilYaw = true }
local Value9 = nil
local Value10 = nil

if not Success3 or type( Result3 ) ~= "table" then
    Number8 = Number
else
    local Value11 = nil
    Number8 = Number

    for Value12 in Table6, nil, nil do
        if rawget( Result3, Value12 ) ~= nil then
            rawset( Result3, Value12, nil )
            local Text = "ClientState." .. Value12 .. " written"

            if not Table2[ 7503 ] then
                Table2[ 7503 ] = true
                Number = Number8 + 1
                Table[ Number ] = { code = 7503, extra = Text }
                Number8 = Number
            end
        end
    end
    if getmetatable( Result3 ) == nil then
        setmetatable( Result3, {
            __newindex = function( Argument1, Key, Argument3 )
                if not Table6[ Key ] then
                    rawset( Argument1, Key, Argument3 )
                    return
                end

                local Text = "ClientState." .. tostring( Key ) .. " written"

                if Table2[ 7503 ] then
                    return
                end
                Table2[ 7503 ] = true
                Number8 = Number8 + 1
                Table[ Number8 ] = { code = 7503, extra = Text }
                return
            end
        } )
    end

    task.spawn( function()
        if type( Result3.RecoilKey ) ~= "function" then
            return
        end

        Value10 = Result3.RecoilKey( )
        local Clock = os.clock( )

        while not rawget( Result3, Value10 ) do
            if not ( os.clock( ) - Clock < 60 ) then
                break
            end

            task.wait( 0.5 )
        end

        Value9 = rawget( Result3, Value10 )
    end )
end

local Value13

local function RecoilCheck()
    if not Success3 or type( Result3 ) ~= "table" then
        return
    end

    local Value1 = nil

    for Value in Table6, nil, nil do
        if rawget( Result3, Value ) ~= nil then
            rawset( Result3, Value, nil )
            local Text = "ClientState." .. Value .. " written (raw)"

            if not Table2[ 7503 ] then
                Table2[ 7503 ] = true
                Number8 = Number8 + 1
                Table[ Number8 ] = { code = 7503, extra = Text }
            end
        end
    end
    if Value9 and rawget( Result3, Value10 ) ~= Value9 then
        if not Table2[ 7503 ] then
            Table2[ 7503 ] = true
            Number8 = Number8 + 1
            Table[ Number8 ] = { code = 7503, extra = "recoil function replaced" }
        end
    end
    if Value9 then
        local Success, Result = pcall( Value9, 0, 0 )

        if Success and Result ~= true then
            if Table2[ 7503 ] then
                return
            end

            Table2[ 7503 ] = true
            Number8 = Number8 + 1
            Table[ Number8 ] = { code = 7503, extra = "recoil function hooked" }
        end
    end
end

local RunService = game:GetService( "RunService" )
local Table7 = { look = nil, pos = nil, cam = nil }
local Table8 = { g = 0, h = 0, t0 = 0, maxAng = 0 }
local Number9 = 0

local function NearestHeadAngle( Pos, Look )
    local Number2
    local Number = math.huge

    local function Consider( Object )
        local Head

        if Object then
            Head = Object:FindFirstChild( "Head" )
        else
            Head = Object
        end
        if not Head then
            return
        end

        local Position = Head.Position - Pos
        local Magnitude = Position.Magnitude

        if Magnitude > 2 and Magnitude < 1000 then
            local Acos = math.acos( ( math.clamp( Look:Dot( Position / Magnitude ), -1, 1 ) ) )

            if Acos < Number then
                Number = Acos
            end
        end
    end

    Number2 = Number

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer then
            local Head2
            local Character = Value.Character

            if Character then
                Head2 = Character:FindFirstChild( "Head" )
            else
                Head2 = Character
            end
            if Head2 then
                local Position2 = Head2.Position - Pos
                local Magnitude2 = Position2.Magnitude

                if Magnitude2 > 2 and Magnitude2 < 1000 then
                    Number = math.acos( ( math.clamp( Look:Dot( Position2 / Magnitude2 ), -1, 1 ) ) )

                    if Number < Number2 then
                        Number2 = Number
                    end
                end
            end
        end
    end
    if RunService:IsStudio( ) then
        for Key2, Value2 in CollectionService:GetTagged( "GunBot" ) do
            local Head

            if Value2 then
                Head = Value2:FindFirstChild( "Head" )
            else
                Head = Value2
            end
            if Head then
                local Position = Head.Position - Pos
                local Magnitude = Position.Magnitude

                if Magnitude > 2 and Magnitude < 1000 then
                    Number = math.acos( ( math.clamp( Look:Dot( Position / Magnitude ), -1, 1 ) ) )

                    if Number < Number2 then
                        Number2 = Number
                    end
                end
            end
        end
    end

    return Number2
end

local function CamExcused()
    if not Success3 or type( Result3 ) ~= "table" then
        return true
    end

    local Flag

    if Result3.FixedCamera == nil then
        if Result3.WardrobeOpen == true then
            Flag = true
        elseif Result3.WardrobeFocusX == nil then
            if Result3.RobloxCamera == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = true
        end
    else
        Flag = true
    end

    return Flag
end

RunService:BindToRenderStep( "NetBeatCamEnd", Enum.RenderPriority.Last.Value, function()
    local Cam = workspace.CurrentCamera

    if Cam then
        local CFrame = Cam.CFrame
        local Look = CFrame.LookVector
        local Pos = CFrame.Position
        Table7.look = Look
        Table7.pos = Pos
        Table7.cam = Cam
        return
    end
    Table7.look = nil
    return
end )
RunService:BindToRenderStep( "NetBeatCamStart", Enum.RenderPriority.First.Value, function()
    local CurrentCamera = workspace.CurrentCamera
    local Look = Table7.look
    local Pos = Table7.pos
    Table7.look = nil

    if CurrentCamera and Look and CurrentCamera == Table7.cam then
        local Flag

        if not Success3 or type( Result3 ) ~= "table" then
            Flag = true
        elseif Result3.FixedCamera == nil then
            if Result3.WardrobeOpen == true then
                Flag = true
            elseif Result3.WardrobeFocusX == nil then
                if Result3.RobloxCamera == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = true
            end
        else
            Flag = true
        end
        if not Flag then
            local Humanoid
            local Character = LocalPlayer.Character

            if Character then
                Humanoid = LocalPlayer.Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid = Character
            end
            if not Humanoid or Humanoid.Health <= 0 then
                return
            end

            local CFrame = CurrentCamera.CFrame
            local Acos = math.acos( ( math.clamp( Look:Dot( CFrame.LookVector ), -1, 1 ) ) )

            if Acos == Acos then
                if not ( Acos <= 0.005235987755982988 ) or not ( ( CFrame.Position - Pos ).Magnitude < 0.05 ) then
                    local T0 = os.clock( )

                    if Success3 and type( Result3 ) == "table" and Result3.Spectating == true then
                        Number9 = T0 + 2
                    end
                    if T0 - Table8.t0 > 20 then
                        Table8.t0 = T0
                        Table8.g = 0
                        Table8.h = 0
                        Table8.maxAng = 0
                        Table8.sp = nil
                    end
                    if T0 < Number9 then
                        Table8.sp = true
                    end

                    local Flag2 = Table8.sp == true and true or false
                    Table8.g = Table8.g + 1
                    Table8.maxAng = math.max( Table8.maxAng, Acos )
                    local NearestHeadAngle2 = NearestHeadAngle( CFrame.Position, CFrame.LookVector )

                    if NearestHeadAngle2 < 0.026179938779914945 and NearestHeadAngle2 < NearestHeadAngle( Pos, Look ) - 0.008726646259971648 then
                        Table8.h = Table8.h + 1
                    end
                    if Table8.h >= 6 then
                        local Text = not Flag2 and "n" or "sn"
                        local Text2 = not Flag2 and "last" or "slast"

                        if ( Table8[ Text ] or 0 ) < 3 and T0 - ( Table8[ Text2 ] or -math.huge ) >= 30 then
                            local Sp
                            Table8[ Text ] = ( Table8[ Text ] or 0 ) + 1
                            Table8[ Text2 ] = T0
                            local TableInner = {
                                h = Table8.h,
                                g = Table8.g,
                                a = math.floor( math.deg( Table8.maxAng ) * 10 ) / 10
                            }
                            Sp = if Flag2 then 1 else nil
                            local Text3
                            TableInner.sp = Sp
                            Text3 = not Flag2 and "7704h" or "7704sh"
                            local Text4 = Text3 .. Table8[ Text ] or 7704

                            if Table2[ Text4 ] then
                                return
                            end
                            Table2[ Text4 ] = true
                            Number8 = Number8 + 1
                            Table[ Number8 ] = { code = 7704, extra = TableInner }
                            return
                        end
                    elseif Table8.g >= 30 then
                        local Sp2
                        local Table2Inner = {
                            h = Table8.h,
                            g = Table8.g,
                            a = math.floor( math.deg( Table8.maxAng ) * 10 ) / 10
                        }
                        Sp2 = if Flag2 then 1 else nil
                        local Text5
                        Table2Inner.sp = Sp2
                        Text5 = not Flag2 and "7704g" or "7704sg"
                        local Text6 = Text5 or 7704

                        if Table2[ Text6 ] then
                            return
                        end

                        Table2[ Text6 ] = true
                        Number8 = Number8 + 1
                        Table[ Number8 ] = { code = 7704, extra = Table2Inner }
                    end

                    return
                end
            end

            return
        end
    end
end )
local Table9 = {
    {
        FireRate = 600,
        RPM = 600,
        Recoil = 1.2,
        RecoilX = 0.6,
        RecoilY = 1.1,
        Spread = 1.5,
        BulletSpread = 1.5,
        Damage = 28,
        HeadshotMultiplier = 2,
        MagSize = 30,
        Ammo = 30,
        MaxAmmo = 30,
        ClipSize = 30,
        ReloadTime = 2.2,
        Range = 900,
        Automatic = true,
        NoRecoil = false,
        InfiniteAmmo = false,
        Firerate = 0.1,
        Cooldown = 0.1
    },
    {
        WalkSpeed = 16,
        JumpPower = 50,
        JumpHeight = 7.2,
        Stamina = 100,
        MaxStamina = 100,
        StaminaDrain = 20,
        Health = 100,
        GodMode = false,
        FlySpeed = 0,
        CanFly = false
    }
}
local Table10 = { }
Value13 = nil

for Key4, Value14 in Table9, nil, nil do
    Table10[ Key4 ] = Sig( Value14 )
end

local Value15 = nil
task.spawn( function()
    local PlayerScripts2
    local PlayerScripts = LocalPlayer:WaitForChild( "PlayerScripts", 30 )
    PlayerScripts2 = if PlayerScripts then PlayerScripts:WaitForChild( "ClientAntiCheat", 30 ) else PlayerScripts
    Value15 = PlayerScripts2
end )
local Table11 = {
    Highlight = true,
    BillboardGui = true,
    BoxHandleAdornment = true,
    SphereHandleAdornment = true,
    CylinderHandleAdornment = true,
    ConeHandleAdornment = true,
    LineHandleAdornment = true,
    SelectionBox = true,
    SelectionSphere = true
}

local function OnTop( Self )
    if Self:IsA( "Highlight" ) then
        local Flag = Self.DepthMode == Enum.HighlightDepthMode.AlwaysOnTop and true or false
        return Flag
    end
    if Self:IsA( "BillboardGui" ) then
        return Self.AlwaysOnTop
    end
    if Self:IsA( "HandleAdornment" ) then
        return Self.AlwaysOnTop
    end

    local IsA2
    local IsA = Self:IsA( "SelectionBox" )
    IsA2 = if IsA then IsA else Self:IsA( "SelectionSphere" )
    return IsA2
end

local function RelPath( Tag, Argument2 )
    local Parent
    local Table = { }
    Parent = Tag

    while Parent do
        if Parent == Argument2 then
            break
        end

        table.insert( Table, 1, Parent.Name )
        Parent = Parent.Parent
    end

    return table.concat( Table, "/" )
end

local function SuspectESP( Argument1, Argument2, Tag )
    if not Table11[ Tag.ClassName ] or CollectionService:HasTag( Tag, "OwnFX" ) then
        return
    end
    task.delay( 1, function()
        if Tag.Parent and Tag:IsDescendantOf( Argument2 ) and Argument1.Character == Argument2 and not CollectionService:HasTag( Tag, "OwnFX" ) and OnTop( Tag ) then
            local RelPath2 = RelPath( Tag, Argument2 )
            local TableInner = { uid = Argument1.UserId, path = RelPath2, class = Tag.ClassName }
            local Text = "7701:" .. Argument1.UserId .. ":" .. RelPath2 or 7701

            if Table2[ Text ] then
                return
            end
            if Number4 >= 12 then
                return
            end

            Number4 = Number4 + 1
            Table2[ Text ] = true
            Number8 = Number8 + 1
            Table[ Number8 ] = { code = 7701, extra = TableInner }
        end
    end )
    return
end

local function WatchChar( Argument1, Object )
    if Argument1 == LocalPlayer or not Object then
        return
    end
    for Key, Value in Object:GetDescendants( ) do
        if Table11[ Value.ClassName ] then
            if not CollectionService:HasTag( Value, "OwnFX" ) then
                task.delay( 1, function()
                    if Value.Parent and Value:IsDescendantOf( Object ) and Argument1.Character == Object and not CollectionService:HasTag( Value, "OwnFX" ) and OnTop( Value ) then
                        local RelPath2 = RelPath( Value, Object )
                        local TableInner = { uid = Argument1.UserId, path = RelPath2, class = Value.ClassName }
                        local Text = "7701:" .. Argument1.UserId .. ":" .. RelPath2 or 7701

                        if Table2[ Text ] then
                            return
                        end
                        if Number4 >= 12 then
                            return
                        end

                        Number4 = Number4 + 1
                        Table2[ Text ] = true
                        Number8 = Number8 + 1
                        Table[ Number8 ] = { code = 7701, extra = TableInner }
                    end
                end )
            end
        end
    end

    Object.DescendantAdded:Connect( function( Tag )
        if Table11[ Tag.ClassName ] then
            if CollectionService:HasTag( Tag, "OwnFX" ) then
                return
            end

            task.delay( 1, function()
                if Tag.Parent and Tag:IsDescendantOf( Object ) and Argument1.Character == Object and not CollectionService:HasTag( Tag, "OwnFX" ) and OnTop( Tag ) then
                    local RelPath2 = RelPath( Tag, Object )
                    local TableInner = { uid = Argument1.UserId, path = RelPath2, class = Tag.ClassName }
                    local Text = "7701:" .. Argument1.UserId .. ":" .. RelPath2 or 7701

                    if Table2[ Text ] then
                        return
                    end
                    if Number4 >= 12 then
                        return
                    end

                    Number4 = Number4 + 1
                    Table2[ Text ] = true
                    Number8 = Number8 + 1
                    Table[ Number8 ] = { code = 7701, extra = TableInner }
                end
            end )
        end
    end )
end

local function WatchPlayer( Argument1 )
    if Argument1 == LocalPlayer then
        return
    end
    if Argument1.Character then
        WatchChar( Argument1, Argument1.Character )
    end

    Argument1.CharacterAdded:Connect( function( Object )
        WatchChar( Argument1, Object )
    end )
end

for Key5, Value16 in Players:GetPlayers( ) do
    if Value16 ~= LocalPlayer then
        if Value16.Character then
            WatchChar( Value16, Value16.Character )
        end

        Value16.CharacterAdded:Connect( function( Object )
            WatchChar( Value16, Object )
        end )
    end
end

Players.PlayerAdded:Connect( WatchPlayer )
task.spawn( function()
    while true do
        task.wait( 5 )
        local BBLocked = LocalPlayer:GetAttribute( "BBLocked" )

        if type( BBLocked ) ~= "number" or not ( BBLocked > 0 ) then
        else
            task.wait( 5 )
            local TableInner = {
                n = math.min( LocalPlayer:GetAttribute( "BBLocked" ) or BBLocked, 9999 ),
                on = math.min( LocalPlayer:GetAttribute( "BBLockedOn" ) or 0, 9999 )
            }

            if Table2[ 7702 ] then
                return
            end
            Table2[ 7702 ] = true
            Number8 = Number8 + 1
            Table[ Number8 ] = { code = 7702, extra = TableInner }
            return
        end
    end
end )

local function SealOf( List, Amount )
    local Result = Amount % 1000003
    local Count = #List
    local I = 1

    for I = 1, Count do
        Result = ( Result * 31 + string.byte( List, I ) ) % 1000003
    end

    return Result + 1
end

local Table12 = { "BasePart", "Accessory", "Model", "Clothing", "ShirtGraphic" }
local Class = setmetatable( { }, { __mode = "k" } )
local Number10 = 0

local function SkinClass( Object )
    local Value1 = nil

    for Key, Value in Table12, nil, nil do
        if Object:IsA( Value ) then
            return true
        end
    end

    return false
end

local function InFolder( Object, Name )
    local IsDescendantOf
    local FoundChild = workspace:FindFirstChild( Name )

    if FoundChild == nil then
        IsDescendantOf = false
    else
        IsDescendantOf = Object:IsDescendantOf( FoundChild )
    end

    return IsDescendantOf
end

local function Legit( Self, Argument2 )
    if Self:IsDescendantOf( Argument2 ) or Self:IsDescendantOf( workspace.CurrentCamera ) then
        return true
    end

    local IsDescendantOf
    local FX = workspace:FindFirstChild( "FX" )

    if FX == nil then
        IsDescendantOf = false
    else
        IsDescendantOf = Self:IsDescendantOf( FX )
    end
    if not IsDescendantOf then
        local IsDescendantOf2
        local ClientHitboxes = workspace:FindFirstChild( "ClientHitboxes" )

        if ClientHitboxes == nil then
            IsDescendantOf2 = false
        else
            IsDescendantOf2 = Self:IsDescendantOf( ClientHitboxes )
        end
        if not IsDescendantOf2 then
            local IsDescendantOf3
            local HoodLocal = workspace:FindFirstChild( "HoodLocal" )

            if HoodLocal == nil then
                IsDescendantOf3 = false
            else
                IsDescendantOf3 = Self:IsDescendantOf( HoodLocal )
            end
            if not IsDescendantOf3 then
                local Model = Self:FindFirstAncestorWhichIsA( "Model" )

                while Model do
                    if CollectionService:HasTag( Model, "Vehicle" ) or Players:GetPlayerFromCharacter( Model ) then
                        return true
                    end

                    Model = Model:FindFirstAncestorWhichIsA( "Model" )
                end

                return false
            end
        end
    end

    return true
end

local function TopOf( Argument1 )
    local Parent = Argument1

    while Parent.Parent do
        if Parent.Parent == workspace or Parent.Parent:IsA( "Folder" ) then
            break
        end

        Parent = Parent.Parent
    end

    return Parent
end

task.spawn( function()
    -- Could not structure function #72
end )

local function NamecallRatio()
    local Number
    local GetService = game.GetService
    local I = 1
    Number = math.huge

    for I = 1, 3 do
        local Clock = os.clock( )
        local J = 1

        for J = 1, 400 do
            game:GetService( "Workspace" )
        end

        local Clock2 = os.clock( ) - Clock
        local Clock3 = os.clock( )
        local J2 = 1

        for J2 = 1, 400 do
            GetService( game, "Workspace" )
        end

        Number = math.min( Number, Clock2 / math.max( os.clock( ) - Clock3, 1e-06 ) )
    end

    return Number
end

task.spawn( function()
    local Number, Number3, Number4
    local Clock = os.clock( )
    Number = 0
    Number3 = 0
    Number4 = 0

    while true do
        local Value1
        task.wait( 2 )
        local Clock2 = os.clock( )
        local Clock3 = Clock2 - Clock
        local Number2 = Number + 1
        Value1 = nil

        for Key, Value in Table4, nil, nil do
            if AllFrozen( Value.t, 0 ) then
                if Number2 % 5 == 2 then
                    if Sig( Value.t ) ~= Value.s then
                        local Text2 = Value.name .. " changed"

                        if Table2[ 7501 ] then
                            break
                        end
                        Table2[ 7501 ] = true
                        Number8 = Number8 + 1
                        Table[ Number8 ] = { code = 7501, extra = Text2 }
                        break
                    end
                end
            else
                local Text = Value.name .. " unlocked"

                if Table2[ 7501 ] then
                    break
                end
                Table2[ 7501 ] = true
                Number8 = Number8 + 1
                Table[ Number8 ] = { code = 7501, extra = Text }
                break
            end
        end

        local Value2 = nil

        for Key2, Value3 in Table9, nil, nil do
            if Sig( Value3 ) ~= Table10[ Key2 ] then
                local Text3 = "bait " .. Key2

                if Table2[ 7502 ] then
                    break
                end
                Table2[ 7502 ] = true
                Number8 = Number8 + 1
                Table[ Number8 ] = { code = 7502, extra = Text3 }
                break
            end
        end

        SpreadCheck( )
        RecoilCheck( )

        if Value15 then
            if Value15.Parent == nil then
                if not Table2[ 7601 ] then
                    Table2[ 7601 ] = true
                    Number8 = Number8 + 1
                    Table[ Number8 ] = { code = 7601, extra = "removed" }
                end
            elseif Value15.Enabled then
                local T = Value15:GetAttribute( "t" )

                if not ( Clock3 < 3 ) or type( T ) ~= "number" or not ( Clock2 - T > 6 ) then
                    Number3 = 0
                else
                    Number3 = Number3 + 1
                end
                if Number3 >= 2 then
                    if not Table2[ 7601 ] then
                        Table2[ 7601 ] = true
                        Number8 = Number8 + 1
                        Table[ Number8 ] = { code = 7601, extra = "stopped" }
                    end
                end
            elseif not Table2[ 7601 ] then
                Table2[ 7601 ] = true
                Number8 = Number8 + 1
                Table[ Number8 ] = { code = 7601, extra = "disabled" }
            end
        end
        if Number2 % 10 == 0 then
            local NamecallRatio2 = NamecallRatio( )

            if NamecallRatio2 > 3 then
                Number4 = Number4 + 1
            else
                Number4 = 0
            end
            if Number4 >= 3 then
                local Floor = math.floor( NamecallRatio2 * 10 ) / 10

                if not Table2[ 7801 ] then
                    Table2[ 7801 ] = true
                    Number8 = Number8 + 1
                    Table[ Number8 ] = { code = 7801, extra = Floor }
                end
            end
        end

        Clock = Clock2
        Number = Number2
    end
end )
