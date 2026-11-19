-- Players.perkbrokeyou.PlayerScripts.UiClickSoundClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Parent = game:GetService( "SoundService" )
local ContentProvider = game:GetService( "ContentProvider" )
local UserInputService = game:GetService( "UserInputService" )
local Parent2 = Instance.new( "Folder" )
Parent2.Name = "UiClick"
Parent2.Parent = Parent

local function MakeVoices( Name, Text, Volume, List )
    local Table = { }
    local I = 1

    for I = 1, List do
        local Sound = Instance.new( "Sound" )
        Sound.Name = Name
        Sound.SoundId = "rbxassetid://" .. Text
        Sound.Volume = Volume
        Sound.Parent = Parent2
        Table[ I ] = Sound
    end

    return Table
end

local Voices = MakeVoices( "UiClick", 137311458463482, 0.25, 3 )
local Voices2 = MakeVoices( "UiHover", 125193401074160, 1, 3 )
task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, Voices )
    pcall( ContentProvider.PreloadAsync, ContentProvider, Voices2 )
end )

local function Player( Argument1, Argument2, Argument3 )
    local Number = 1
    local Number2 = -1

    local function Callback()
        local Clock = os.clock( )

        if Clock - Number2 < Argument3 then
            return
        end
        Number2 = Clock
        local Entry = Argument1[ Number ]
        Number = Number % #Argument1 + 1
        Entry.TimePosition = Argument2
        Entry:Play( )
        return
    end

    return Callback
end

local Number = 1
local Number2 = -1
local Number3 = 0.04
local Number4 = 0.025

local function Callback()
    local Clock = os.clock( )

    if Clock - Number2 < Number3 then
        return
    end
    Number2 = Clock
    local Entry = Voices[ Number ]
    Number = Number % #Voices + 1
    Entry.TimePosition = Number4
    Entry:Play( )
    return
end

local Number5 = 1
local Number6 = -1
local Number7 = 0.05
local Number8 = 0.03

local function Callback2()
    local Clock = os.clock( )

    if Clock - Number6 < Number7 then
        return
    end
    Number6 = Clock
    local Entry = Voices2[ Number5 ]
    Number5 = Number5 % #Voices2 + 1
    Entry.TimePosition = Number8
    Entry:Play( )
    return
end

local function Hover()
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
        return
    end
    if UserInputService:IsMouseButtonPressed( Enum.UserInputType.MouseButton1 ) then
        return
    end
    Callback2( )
    return
end

local CheckMenus = nil
local Class = setmetatable( { }, { __mode = "k" } )

local function Hook( Value )
    if Value:IsA( "GuiButton" ) and not Class[ Value ] then
        local Hotbar = Value:FindFirstAncestor( "Hotbar" )

        if Hotbar and Hotbar.Parent and Hotbar.Parent.Name == "Inventory" then
            return
        end

        local Inventory
        Class[ Value ] = true
        local Parent = Value.Parent

        if Parent then
            if Value.Parent.Name == "Cases" then
                local Parent2 = Value.Parent.Parent

                if Parent2 then
                    if Value.Parent.Parent.Name == "Window" then
                        Inventory = Value:FindFirstAncestor( "Inventory" )
                    else
                        Inventory = false
                    end
                else
                    Inventory = Parent2
                end
            else
                Inventory = false
            end
        else
            Inventory = Parent
        end

        Value.Activated:Connect( function( Argument1 )
            if Inventory and Argument1 then
                if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
                    return
                end
            end

            task.defer( function()
                if not CheckMenus or not CheckMenus( ) then
                    Callback( )
                end
            end )
        end )

        if Value.Name ~= "InvisPadding" then
            Value.MouseEnter:Connect( Hover )
            Value.SelectionGained:Connect( Callback2 )
        end
    end
end

local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )

for Key, Value in PlayerGui:GetDescendants( ) do
    Hook( Value )
end

local Value1
PlayerGui.DescendantAdded:Connect( Hook )
local Table = {
    "BetaNotice",
    "GenderChoice",
    "ModNotice",
    "Armory",
    "Inventory",
    "SettingsMenu",
    "EffectsMenu",
    "ModEditor",
    "Wardrobe",
    "PlayerProfile",
    "ControlsMenu",
    "CaseMenu",
    "VehicleCrateMenu"
}
local Table2 = { }
local Sound = Instance.new( "Sound" )
Sound.Name = "UiMenu"
Sound.SoundId = "rbxassetid://" .. 116190157794575
Sound.Volume = 0.13
Sound.Parent = Parent2
Table2[ 1 ] = Sound
local Sound2 = Instance.new( "Sound" )
Sound2.Name = "UiMenu"
Sound2.SoundId = "rbxassetid://" .. 116190157794575
Sound2.Volume = 0.13
Sound2.Parent = Parent2
Table2[ 2 ] = Sound2
task.spawn( function()
    pcall( ContentProvider.PreloadAsync, ContentProvider, Table2 )
end )
local Number9 = 1

local function MenuSound( Argument1 )
    local PlaybackSpeed
    local Entry = Table2[ Number9 ]
    Number9 = Number9 % #Table2 + 1
    PlaybackSpeed = not Argument1 and 1 or 1.25
    Entry.PlaybackSpeed = PlaybackSpeed
    Entry.TimePosition = 0.02
    Entry:Play( )
end

local Screens = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) )
local Table3 = { }
local Table4 = { }
Value1 = nil

for Key2, Value2 in Table, nil, nil do
    Table4[ Value2 ] = true
end

local function RefreshAll()
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        Table3[ Value ] = Screens.Find( Value, PlayerGui )
    end
end

local Class2 = setmetatable( { }, { __mode = "k" } )

local function WatchGroup( GroupName )
    if Class2[ GroupName ] then
        return
    end
    Class2[ GroupName ] = true
    GroupName.ChildAdded:Connect( RefreshAll )
    GroupName.ChildRemoved:Connect( RefreshAll )
    return
end

local function RefreshGui( GuiName )
    if Screens.GROUPS[ GuiName.Name ] and GuiName.Parent == PlayerGui then
        if not Class2[ GuiName ] then
            Class2[ GuiName ] = true
            GuiName.ChildAdded:Connect( RefreshAll )
            GuiName.ChildRemoved:Connect( RefreshAll )
        end
    end
    if Table4[ GuiName.Name ] or Screens.GROUPS[ GuiName.Name ] then
        local Value1 = nil

        for Key, Value in Table, nil, nil do
            Table3[ Value ] = Screens.Find( Value, PlayerGui )
        end
    end
end

PlayerGui.ChildAdded:Connect( RefreshGui )
PlayerGui.ChildRemoved:Connect( RefreshGui )

for Key3, Value3 in PlayerGui:GetChildren( ) do
    if Screens.GROUPS[ Value3.Name ] then
        if not Class2[ Value3 ] then
            Class2[ Value3 ] = true
            Value3.ChildAdded:Connect( RefreshAll )
            Value3.ChildRemoved:Connect( RefreshAll )
        end
    end
end

local Value4 = nil

for Key4, Value5 in Table, nil, nil do
    Table3[ Value5 ] = Screens.Find( Value5, PlayerGui )
end

local function Attached( Argument1 )
    local Flag
    local Parent = Argument1.Parent

    if Parent == PlayerGui then
        Flag = true
    elseif Parent == nil then
        Flag = false
    elseif Parent.Parent == PlayerGui then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local Class3 = setmetatable( { }, { __mode = "k" } )

local function IsOpen( Key, Name )
    if not Key or not Screens.IsShown( Key ) then
        return false
    end
    if Name ~= "Inventory" then
        return true
    end

    local Entry2
    local Entry = Class3[ Key ]

    if not Entry or Entry.Parent ~= Key then
        local Window = Key:FindFirstChild( "Window" )
        Class3[ Key ] = Window
        Entry2 = Window
    else
        Entry2 = Entry
    end

    local Flag = if Entry2 == nil then false else Entry2.Visible
    return Flag
end

local Table5 = { }

CheckMenus = function()
    local Value1, Flag
    Value1 = nil
    Flag = false

    for Key, Value in Table, nil, nil do
        local Entry2
        local Entry = Table3[ Value ]

        if Entry then
            local Flag2
            local Parent = Entry.Parent

            if Parent == PlayerGui then
                Flag2 = true
            elseif Parent == nil then
                Flag2 = false
            elseif Parent.Parent == PlayerGui then
                Flag2 = true
            else
                Flag2 = false
            end
            if Flag2 then
                Entry2 = Entry
            else
                local Find = Screens.Find( Value, PlayerGui )
                Table3[ Value ] = Find
                Entry2 = Find
            end
        else
            Entry2 = Entry
        end

        local Open

        if not Entry2 or not Screens.IsShown( Entry2 ) then
            Open = false
        elseif Value == "Inventory" then
            local Entry4
            local Entry3 = Class3[ Entry2 ]

            if not Entry3 or Entry3.Parent ~= Entry2 then
                local Window = Entry2:FindFirstChild( "Window" )
                Class3[ Entry2 ] = Window
                Entry4 = Window
            else
                Entry4 = Entry3
            end
            if Entry4 == nil then
                Open = false
            else
                Open = Entry4.Visible
            end
        else
            Open = true
        end

        local Entry5 = Table5[ Value ]

        if not Entry5 or Entry5.gui ~= Entry2 then
            Table5[ Value ] = { gui = Entry2, open = Open }
        elseif Entry5.open ~= Open then
            local PlaybackSpeed
            Entry5.open = Open
            local Entry6 = Table2[ Number9 ]
            Number9 = Number9 % #Table2 + 1
            PlaybackSpeed = not Open and 1 or 1.25
            Entry6.PlaybackSpeed = PlaybackSpeed
            Entry6.TimePosition = 0.02
            Entry6:Play( )
            Flag = true
        end
    end

    return Flag
end

CheckMenus( )
game:GetService( "RunService" ).Heartbeat:Connect( CheckMenus )
