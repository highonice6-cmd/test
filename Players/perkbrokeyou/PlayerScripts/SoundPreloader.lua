-- Players.perkbrokeyou.PlayerScripts.SoundPreloader
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local StarterPack = game:GetService( "StarterPack" )
local LocalPlayer = Players.LocalPlayer
local WeaponData = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "WeaponData" ) )
local Parent2 = Instance.new( "Folder" )
Parent2.Name = "SoundCache"
Parent2.Parent = Parent
local Table = { }
local Table2 = { }

local function AddSound( Sound )
    if Sound.SoundId == "" or Table2[ Sound.SoundId ] then
        return
    end
    Table2[ Sound.SoundId ] = true
    table.insert( Table, Sound )
    return
end

local function AddId( Text )
    local SoundId = "rbxassetid://" .. Text

    if Table2[ SoundId ] then
        return
    end

    local Sound = Instance.new( "Sound" )
    Sound.SoundId = SoundId
    Sound.Volume = 0
    Sound.Parent = Parent2

    if Sound.SoundId ~= "" then
        if Table2[ Sound.SoundId ] then
            return
        end

        Table2[ Sound.SoundId ] = true
        table.insert( Table, Sound )
    end
end

local function Scan( Object )
    if not Object then
        return
    end
    for Key, Value in Object:GetDescendants( ) do
        if Value:IsA( "Sound" ) and Value.SoundId ~= "" then
            if not Table2[ Value.SoundId ] then
                Table2[ Value.SoundId ] = true
                table.insert( Table, Value )
            end
        end
    end
end

Scan( ReplicatedStorage )
Scan( Parent )
Scan( StarterPack )
Scan( workspace )
Scan( LocalPlayer:WaitForChild( "Backpack", 10 ) )

local function Collect( List, Amount )
    if Amount > 3 then
        return
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        if type( Value ) ~= "number" or not ( Value > 1000000 ) or Key == "Overlay" then
            if type( Value ) == "table" then
                Collect( Value, Amount + 1 )
            end
        else
            local SoundId = "rbxassetid://" .. Value

            if not Table2[ SoundId ] then
                local Sound = Instance.new( "Sound" )
                Sound.SoundId = SoundId
                Sound.Volume = 0
                Sound.Parent = Parent2

                if Sound.SoundId ~= "" then
                    if not Table2[ Sound.SoundId ] then
                        Table2[ Sound.SoundId ] = true
                        table.insert( Table, Sound )
                    end
                end
            end
        end
    end
end

Value1 = nil

for Key, Value in WeaponData, nil, nil do
    if type( Value ) == "table" and Value.Sounds then
        Collect( Value.Sounds, 0 )
    end
    if type( Value ) == "table" and Value.RocketSounds then
        Collect( Value.RocketSounds, 0 )
    end
end

local Value2

local function CollectKeys( List, Amount, Argument3 )
    if Amount > 7 then
        return
    end

    local Value1 = nil

    for Key, Value in List, nil, nil do
        local Flag

        if Argument3 then
            Flag = Argument3
        elseif type( Key ) == "string" then
            if Key:find( "Sound" ) == nil then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if type( Key ) ~= "string" or not Key:find( "Desactive" ) then
            if Key ~= "Id" or type( Value ) ~= "number" or not ( Value > 1000000 ) then
                if not Flag or type( Value ) ~= "string" then
                    if not Flag or type( Value ) ~= "number" or not ( Value > 1000000 ) then
                        if type( Value ) == "table" then
                            CollectKeys( Value, Amount + 1, Flag )
                        end
                    else
                        local SoundId3 = "rbxassetid://" .. Value

                        if not Table2[ SoundId3 ] then
                            local Sound3 = Instance.new( "Sound" )
                            Sound3.SoundId = SoundId3
                            Sound3.Volume = 0
                            Sound3.Parent = Parent2

                            if Sound3.SoundId ~= "" then
                                if not Table2[ Sound3.SoundId ] then
                                    Table2[ Sound3.SoundId ] = true
                                    table.insert( Table, Sound3 )
                                end
                            end
                        end
                    end
                else
                    local Match = Value:match( "rbxassetid://(%d+)" )

                    if Match then
                        local SoundId2 = "rbxassetid://" .. Match

                        if not Table2[ SoundId2 ] then
                            local Sound2 = Instance.new( "Sound" )
                            Sound2.SoundId = SoundId2
                            Sound2.Volume = 0
                            Sound2.Parent = Parent2

                            if Sound2.SoundId ~= "" then
                                if not Table2[ Sound2.SoundId ] then
                                    Table2[ Sound2.SoundId ] = true
                                    table.insert( Table, Sound2 )
                                end
                            end
                        end
                    end
                end
            else
                local SoundId = "rbxassetid://" .. Value

                if not Table2[ SoundId ] then
                    local Sound = Instance.new( "Sound" )
                    Sound.SoundId = SoundId
                    Sound.Volume = 0
                    Sound.Parent = Parent2

                    if Sound.SoundId ~= "" then
                        if not Table2[ Sound.SoundId ] then
                            Table2[ Sound.SoundId ] = true
                            table.insert( Table, Sound )
                        end
                    end
                end
            end
        end
    end
end

local function FromModule( Weapons, Argument2, Key, Argument4 )
    local Success, Result = pcall( function()
        return require( Weapons:WaitForChild( Argument2, 10 ) )
    end )

    if Success and type( Result ) == "table" then
        local Entry = Key and Result[ Key ] or Result

        if type( Entry ) == "table" then
            CollectKeys( Entry, 0, Argument4 )
        end
    end
end

local Weapons = ReplicatedStorage:WaitForChild( "Weapons" )
FromModule( ReplicatedStorage:WaitForChild( "VehicleSystem" ), "Config" )
FromModule( Weapons, "Config" )
FromModule( Weapons, "PainSounds", "Voices", true )
local Table3 = { }
Value2 = nil

for Key2, Value3 in Table3, nil, nil do
    local SoundId = "rbxassetid://" .. Value3

    if not Table2[ SoundId ] then
        local Sound = Instance.new( "Sound" )
        Sound.SoundId = SoundId
        Sound.Volume = 0
        Sound.Parent = Parent2

        if Sound.SoundId ~= "" then
            if not Table2[ Sound.SoundId ] then
                Table2[ Sound.SoundId ] = true
                table.insert( Table, Sound )
            end
        end
    end
end

local Table4 = {
    1837830084,
    112720519011313,
    9119562636,
    9113692661,
    138076087172612,
    1843025542
}
task.spawn( function()
    local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
    local Get = Screens.Get( "VehicleCrateMenu", 60 )

    if Get then
        local function Load()
            if not Screens.IsShown( Get ) then
                return
            end

            local Value1
            local Table = { }
            Value1 = nil

            for Key, Value in Table4, nil, nil do
                local SoundId = "rbxassetid://" .. Value

                if not Table2[ SoundId ] then
                    Table2[ SoundId ] = true
                    local Sound = Instance.new( "Sound" )
                    Sound.SoundId = SoundId
                    Sound.Volume = 0
                    Sound.Parent = Parent2
                    table.insert( Table, Sound )
                end
            end
            if #Table > 0 then
                pcall( ContentProvider.PreloadAsync, ContentProvider, Table )
            end
        end

        Screens.ShownChanged( Get ):Connect( Load )
        Load( )
        return
    end
    return
end )

local function OnNew( Object )
    if Object:IsA( "Sound" ) and Object.SoundId ~= "" and not Table2[ Object.SoundId ] then
        Table2[ Object.SoundId ] = true
        task.spawn( pcall, ContentProvider.PreloadAsync, ContentProvider, { Object } )
    end
end

workspace.DescendantAdded:Connect( OnNew )
Parent.DescendantAdded:Connect( OnNew )
local Clock = os.clock( )
local Count = #Table
local I = 1

for I = 1, Count, 25 do
    local PreloadAsync = ContentProvider.PreloadAsync
    local Total = I + 25 - 1
    pcall( PreloadAsync, ContentProvider, table.move( Table, I, math.min( Total, #Table ), 1, { } ) )
end

print( ( "[Sons] %d sons préchargés en %.1f s" ):format( #Table, os.clock( ) - Clock ) )
local Table5 = { }
task.spawn( function()
    local Success, Result = pcall( require, game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ModCatalog" ) )

    if not Success then
        return
    end

    local Value1
    local Table = { }
    local Skins = Result.Skins
    Value1 = nil

    for Key, Value in Skins, nil, nil do
        if not Value.Hidden then
            local Table2 = { Value.Texture, Value.Mask }

            if type( Value.Flow ) == "table" then
                local Value2
                local Flow = Value.Flow
                Value2 = nil

                for Key2, Value3 in Flow, nil, nil do
                    table.insert( Table2, Value3.Image )
                end
            else
                table.insert( Table2, Value.Flow )
            end

            local Value4 = nil

            for Key3, Value5 in Table2, nil, nil do
                if type( Value5 ) == "string" and not Table[ Value5 ] then
                    Table[ Value5 ] = true
                    local Texture = Instance.new( "Texture" )
                    Texture.Texture = Value5
                    table.insert( Table5, Texture )
                end
            end
        end
    end
    if #Table5 > 0 then
        local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
        pcall( PreloadAsync, game:GetService( "ContentProvider" ), Table5 )
    end
end )
