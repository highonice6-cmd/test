-- ReplicatedStorage.Screens
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Players = game:GetService( "Players" )
local Table = {
    MAP = {
        BetaReveal = { "Beta", "Reveal" },
        BetaNotice = { "Beta", "Notice" },
        BetaRollTimer = { "BetaRoll", "RollTimer" },
        BetaIntermission = { "BetaRoll", "Intermission" },
        BetaRoundBoard = { "BetaRoll", "RoundBoard" },
        Wardrobe = { "Wardrobe", "Menu" },
        WardrobeFade = { "Wardrobe", "Fade" },
        GenderChoice = { "Wardrobe", "GenderChoice" },
        CrewHUD = { "HUDButtons", "Frame" },
        ShopHUD = { "HUDButtons", "Frame" },
        CrewMenu = { "Crew", "Menu" },
        CrewInvite = { "Crew", "Invite" },
        ClanMenu = { "Clan", "Menu" },
        ClanInvite = { "Clan", "Invite" },
        ClanCard = { "Clan", "Card" },
        ShopMenu = { "Shop", "Menu" },
        VehicleCrateMenu = { "Cases", "CarMenu" },
        CaseMenu = { "Cases", "Menu" },
        CaseToast = { "Cases", "Toast" },
        CarLiftMenu = { "Cases", "CarLift" },
        CarGarage = { "Cases", "Garage" },
        CaseFX = { "CasesFX", "Weapon" },
        VehicleCrateFX = { "CasesFX", "Car" },
        ScopePreload = { "Scope", "Preload" },
        ThermalGrain = { "Scope", "Thermal" },
        ScopeOverlay = { "Scope", "Overlay" },
        RegionNotice = { "Notices", "Region" },
        Notifications = { "Notices", "Toasts" },
        AntiCheatNotice = { "Notices", "AntiCheat" },
        ModNotice = { "Notices", "Moderation" },
        AdminPanel = { "AdminTools", "Panel" },
        HideUIButton = { "AdminTools", "HideUI" },
        ArmoryOpen = { "Armory", "Button" },
        Armory = { "Armory", "Menu" },
        GamepadSelection = { "Gamepad", "Selection" },
        GamepadHints = { "Gamepad", "Hints" },
        CaseFXLive = { "CasesFX", "CaseFXLive" },
        VehicleCrateFXLive = { "CasesFX", "VehicleCrateFXLive" },
        CaseToastLive = { "Cases", "CaseToastLive" }
    }
}
local GROUPS = { }
local MAP = Table.MAP
Value1 = nil

for Key, Value in MAP, nil, nil do
    GROUPS[ Value[ 1 ] ] = true
end

Table.GROUPS = GROUPS

local function RootOf( Argument1 )
    if Argument1 then
        return Argument1
    end

    local LocalPlayer2
    local LocalPlayer = Players.LocalPlayer
    LocalPlayer2 = if LocalPlayer then LocalPlayer:WaitForChild( "PlayerGui" ) else LocalPlayer
    return LocalPlayer2
end

function Table.Find( Name, Object )
    local PlayerGui

    if Object then
        PlayerGui = Object
    else
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
        else
            PlayerGui = LocalPlayer
        end
    end
    if not PlayerGui then
        return nil
    end

    local Entry = Table.MAP[ Name ]

    if not Entry then
        return PlayerGui:FindFirstChild( Name )
    end

    local FoundChild3
    local FoundChild = PlayerGui:FindFirstChild( Entry[ 1 ] )

    if FoundChild then
        local FoundChild2 = FoundChild:FindFirstChild( Entry[ 2 ] )

        if FoundChild2 then
            FoundChild3 = FoundChild2
        else
            FoundChild3 = nil
        end
    else
        FoundChild3 = nil
    end

    return FoundChild3
end
function Table.Get( Name, Amount, Object )
    local PlayerGui

    if Object then
        PlayerGui = Object
    else
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
        else
            PlayerGui = LocalPlayer
        end
    end

    local Number = Amount or math.huge
    local Entry = Table.MAP[ Name ]

    if not Entry then
        return PlayerGui:WaitForChild( Name, Number )
    end

    local Child3
    local Child = PlayerGui:WaitForChild( Entry[ 1 ], Number )

    if Child then
        local Child2 = Child:WaitForChild( Entry[ 2 ], Number )

        if Child2 then
            Child3 = Child2
        else
            Child3 = nil
        end
    else
        Child3 = nil
    end

    return Child3
end

local function Resolve( Argument1 )
    if typeof( Argument1 ) == "string" then
        return Table.Find( Argument1 )
    end
    return Argument1
end

local Class = setmetatable( { }, { __mode = "k" } )

local function IsLayer( Key )
    local Entry2
    local Entry = Class[ Key ]

    if Entry == nil then
        local IsA = Key:IsA( "LayerCollector" )
        Class[ Key ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end

    return Entry2
end

function Table.IsShown( Key )
    local Find

    if typeof( Key ) == "string" then
        Find = Table.Find( Key )
    else
        Find = Key
    end
    if not Find then
        return false
    end

    local Entry2
    local Entry = Class[ Find ]

    if Entry == nil then
        local IsA = Find:IsA( "LayerCollector" )
        Class[ Find ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end
    if Entry2 then
        return Find.Enabled
    end
    return Find.Visible
end
function Table.SetShown( ShownName, Argument2 )
    local Find

    if typeof( ShownName ) == "string" then
        Find = Table.Find( ShownName )
    else
        Find = ShownName
    end
    if not Find then
        return
    end

    local Visible = Argument2 == true and true or false
    local Entry2
    local Entry = Class[ Find ]

    if Entry == nil then
        local IsA = Find:IsA( "LayerCollector" )
        Class[ Find ] = IsA
        Entry2 = IsA
    else
        Entry2 = Entry
    end
    if Entry2 then
        if Find.Enabled ~= Visible then
            Find.Enabled = Visible
            return
        end
    elseif Find.Visible ~= Visible then
        Find.Visible = Visible
    end
end
function Table.ShownChanged( Self )
    local Text = not Self:IsA( "LayerCollector" ) and "Visible" or "Enabled"
    return Self:GetPropertyChangedSignal( Text )
end
local Table2 = { CheatMenu = true, ModMenu = true }
function Table.All( Object )
    local PlayerGui

    if Object then
        PlayerGui = Object
    else
        local LocalPlayer = Players.LocalPlayer

        if LocalPlayer then
            PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
        else
            PlayerGui = LocalPlayer
        end
    end

    local Table = { }

    if not PlayerGui then
        return Table
    end
    for Key, Value in PlayerGui:GetChildren( ) do
        if Value:IsA( "ScreenGui" ) and not Table2[ Value.Name ] then
            if GROUPS[ Value.Name ] then
                for Key2, Value2 in Value:GetChildren( ) do
                    if Value2:IsA( "GuiObject" ) then
                        local Name
                        local Table2Inner = { }
                        local Screen = Value2:GetAttribute( "Screen" )
                        Name = if Screen then Screen else Value2.Name
                        Table2Inner.name = Name
                        Table2Inner.obj = Value2
                        table.insert( Table, Table2Inner )
                    end
                end
            else
                table.insert( Table, { name = Value.Name, obj = Value } )
            end
        end
    end

    return Table
end
function Table.NameOf( Object )
    local Parent = Object

    while Parent do
        if not Parent.Parent then
            break
        end
        if Parent.Parent:IsA( "ScreenGui" ) and GROUPS[ Parent.Parent.Name ] then
            local Screen2
            local Screen = Parent:GetAttribute( "Screen" )
            Screen2 = if Screen then Screen else Parent.Name
            return Screen2
        end
        if Parent:IsA( "ScreenGui" ) then
            return Parent.Name
        end

        Parent = Parent.Parent
    end

    return nil
end
return Table
