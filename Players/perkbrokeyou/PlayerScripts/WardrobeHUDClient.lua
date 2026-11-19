-- Players.perkbrokeyou.PlayerScripts.WardrobeHUDClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local StarterGui = game:GetService( "StarterGui" )
local ProximityPromptService = game:GetService( "ProximityPromptService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local Table = {
    Wardrobe = true,
    WardrobeFade = true,
    GenderChoice = true,
    BetaNotice = true,
    Notifications = true,
    SettingsMenu = true,
    GamepadSelection = true,
    GamepadHints = true,
    ModNotice = true,
    AntiCheatNotice = true,
    ScopePreload = true,
    ItemRender = true,
    BetaReveal = true,
    CrewInvite = true,
    ClanInvite = true,
    TitleScreen = true
}
local Table2 = {
    RegionNotice = true,
    CaseToast = true,
    CaseFX = true,
    DeathScreen = true,
    ThermalGrain = true,
    ScopeOverlay = true,
    BetaRoundBoard = true,
    BetaIntermission = true,
    VehicleRepair = true,
    VehicleCrateFX = true,
    VehicleCrateMenu = true,
    CaseMenu = true,
    DanceMenu = true,
    EmoteWheel = true,
    EffectsMenu = true,
    ShopMenu = true,
    CrewMenu = true,
    Armory = true,
    PlayerProfile = true,
    AltHint = true
}
local Table3 = {
    ShopMenu = true,
    EffectsMenu = true,
    CrewMenu = true,
    ClanMenu = true,
    PlayerProfile = true,
    EmoteWheel = true,
    Armory = true,
    Stash = true,
    Pawn = true,
    Repair = true,
    ATM = true,
    ItemShop = true,
    CommunityPack = true,
    CaseMenu = true,
    VehicleCrateMenu = true,
    CarGarage = true,
    CarLiftMenu = true
}
local Table4 = { "Shop", "Wardrobe" }
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Table5 = { }

for Key, Value in Screens.All( StarterGui ) do
    if not Table[ Value.name ] then
        Table5[ Value.name ] = true
    end
end

local Flag = false
local Table6 = { }
local Value1 = nil
local Table7 = { }

local function Hotbar()
    local Inventory2
    local Inventory = PlayerGui:FindFirstChild( "Inventory" )
    Inventory2 = if Inventory then Inventory:FindFirstChild( "Hotbar" ) else Inventory
    return Inventory2
end

local function Apply()
    for Key, Value in Screens.All( PlayerGui ) do
        local Obj = Value.obj
        local Name = Value.name

        if Table5[ Name ] and Name ~= "Inventory" then
            local Flag2
            local IsShown = Screens.IsShown( Obj )
            Flag2 = Table6[ Obj ] == nil and true or false

            if Flag2 then
                local IsShown2 = if IsShown then not Table3[ Name ] else IsShown
                Table6[ Obj ] = IsShown2
            end
            if IsShown then
                if not Table2[ Name ] then
                    if not Flag2 or not Table3[ Name ] then
                        Table6[ Obj ] = true
                    end
                end

                Screens.SetShown( Obj, false )
            end
        end
    end

    local Hotbar
    local Inventory = PlayerGui:FindFirstChild( "Inventory" )

    if Inventory then
        Hotbar = Inventory:FindFirstChild( "Hotbar" )
    else
        Hotbar = Inventory
    end
    if Hotbar then
        if Value1 == nil then
            Value1 = Hotbar.Visible
        end
        if Hotbar.Visible then
            Value1 = true
            Hotbar.Visible = false
        end
    end

    local Value1Inner
    pcall( function()
        if ProximityPromptService.Enabled then
            ProximityPromptService.Enabled = false
        end
    end )
    Value1Inner = nil

    for Key2, Value2 in Table4, nil, nil do
        local IconInner
        local GetIcon = Icon.getIcon

        if GetIcon then
            IconInner = Icon.getIcon( Value2 )
        else
            IconInner = GetIcon
        end
        if IconInner then
            if Table7[ IconInner ] == nil then
                local Flag = IconInner.isEnabled ~= false and true or false
                Table7[ IconInner ] = Flag
            end
            if IconInner.isEnabled ~= false then
                IconInner:setEnabled( false )
            end
        end
    end
end

local function Restore()
    local Value1Inner = nil

    for Key, Value in Table6, nil, nil do
        if Key.Parent then
            Screens.SetShown( Key, Value )
        end
    end

    local Hotbar
    table.clear( Table6 )
    local Inventory = PlayerGui:FindFirstChild( "Inventory" )

    if Inventory then
        Hotbar = Inventory:FindFirstChild( "Hotbar" )
    else
        Hotbar = Inventory
    end
    if Hotbar and Value1 ~= nil then
        Hotbar.Visible = Value1
    end

    local Value2
    Value1 = nil
    Value2 = nil

    for Key2, Value3 in Table7, nil, nil do
        if Value3 then
            Key2:setEnabled( true )
        end
    end

    table.clear( Table7 )
    local Character = LocalPlayer.Character
    pcall( function()
        local Enabled
        local NotCaptured = not ( Character and Character:GetAttribute( "Downed" ) )

        if NotCaptured then
            if ClientState.BetaRollLock == true then
                Enabled = false
            else
                Enabled = true
            end
        else
            Enabled = NotCaptured
        end

        ProximityPromptService.Enabled = Enabled
    end )
end

RunService:BindToRenderStep( "WardrobeHUD", Enum.RenderPriority.Last.Value, function()
    local FlagInner

    if ClientState.WardrobeOpen == true then
        FlagInner = true
    elseif ClientState.IntroCinematic == true then
        FlagInner = true
    elseif ClientState.ChristmasIntro == true then
        FlagInner = true
    else
        FlagInner = false
    end
    if FlagInner then
        if not Flag then
            Flag = true
        end

        Apply( )

        if ClientState.FistsSelected then
            ClientState.FistsSelected = false
            return
        end
    elseif Flag then
        Flag = false
        Restore( )
    end
end )
