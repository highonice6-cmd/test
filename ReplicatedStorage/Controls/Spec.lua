-- ReplicatedStorage.Controls.Spec
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    Order = {
        "LookSens",
        "AimSens",
        "InvertY",
        "AimAssist",
        "Vibration",
        "Deadzone"
    },
    Tabs = {
        { name = "Camera", keys = { "LookSens", "AimSens" } },
        { name = "Keyboard", keys = { }, keybinds = "kbm" },
        {
            name = "Controller",
            keys = {
                "InvertY",
                "AimAssist",
                "AimAssistStrength",
                "Vibration",
                "Deadzone",
                "PadSprint"
            },
            bindings = true,
            keybinds = "pad"
        },
        {
            name = "Touch",
            keys = {
                "ButtonsMoveCamera",
                "TouchOpacity",
                "InteractButton",
                "HoldToAim",
                "FireAims",
                "HudButtonsTop"
            },
            touch = true
        },
        {
            name = "Graphics",
            keys = {
                "Potato",
                "LightPlayers",
                "NoShadows",
                "NoTrees",
                "NoRoad",
                "NoSky",
                "Saturation",
                "Stretch"
            }
        },
        {
            name = "Crosshair",
            preview = true,
            keys = {
                "XhMode",
                "XhShape",
                "XhColor",
                "XhLength",
                "XhThickness",
                "XhGap",
                "XhRotation",
                "XhOpacity",
                "XhDot",
                "XhDotSize",
                "XhOutline",
                "XhDynamic",
                "XhCombatOnly",
                "XhHitmarkerOn",
                "XhHitmarker"
            }
        },
        {
            name = "Audio",
            keys = {
                "VolWeapons",
                "VolVehicles",
                "VolEffects",
                "VolMusic",
                "HitSound",
                "KillStreakSound",
                "EnemyGunSounds"
            }
        },
        { name = "HUD", keys = { "Compass", "KillStreakLogo", "PartyInvites" } },
        { name = "Codes", keys = { }, codes = true }
    },
    LookSens = {
        kind = "num",
        min = 1,
        max = 10,
        step = 0.5,
        default = 5,
        label = "Camera Sensitivity"
    },
    AimSens = {
        kind = "num",
        min = 0.3,
        max = 1,
        step = 0.05,
        default = 0.7,
        label = "Aim Sensitivity",
        percent = true
    },
    InvertY = { kind = "bool", default = false, label = "Invert Vertical Axis" },
    AimAssist = { kind = "bool", default = true, label = "Aim Assist" },
    AimAssistStrength = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Aim Assist Strength",
        percent = true
    },
    Vibration = { kind = "bool", default = true, label = "Vibration" },
    Deadzone = {
        kind = "num",
        min = 0.03,
        max = 0.3,
        step = 0.01,
        default = 0.1,
        label = "Stick Deadzone",
        percent = true
    },
    PadSprint = {
        kind = "choice",
        default = "Toggle",
        label = "Sprint Mode",
        options = { "Toggle", "Hold" },
        labels = { "Toggle", "Hold" }
    },
    NoShadows = { kind = "bool", default = false, label = "No Shadows" },
    NoTrees = { kind = "bool", default = false, label = "No Trees" },
    NoRoad = { kind = "bool", default = false, label = "No Road" },
    NoSky = { kind = "bool", default = false, label = "No Sky" },
    Potato = { kind = "bool", default = false, label = "Potato Graphics" },
    PotatoAutoDone = { kind = "bool", default = false, label = "Potato Auto" },
    LightPlayers = { kind = "bool", default = false, label = "Optimize Players" },
    LightPlayersAutoDone = { kind = "bool", default = false, label = "Optimize Players Auto" },
    Saturation = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 0,
        label = "Saturation",
        percent = true,
        slider = true
    },
    Stretch = {
        kind = "num",
        min = 0.75,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Stretched Resolution",
        percent = true,
        slider = true
    },
    XhMode = {
        kind = "choice",
        default = "Classic",
        label = "Crosshair",
        options = { "Classic", "Custom" },
        labels = { "Classic", "Custom" }
    },
    XhShape = {
        kind = "choice",
        default = "Cross",
        label = "Shape",
        options = { "Cross", "T", "Circle", "Square", "Dot" }
    },
    XhColor = {
        kind = "color",
        default = "FFFFFF",
        label = "Color",
        palette = {
            "FFFFFF",
            "00FF66",
            "00E5FF",
            "FFEE00",
            "FF3B3B",
            "FF00E6",
            "FF8C00",
            "8A5CFF",
            "000000",
            "A0A0A0"
        }
    },
    XhLength = {
        kind = "num",
        min = 1,
        max = 30,
        step = 1,
        default = 4,
        label = "Length / Size"
    },
    XhThickness = {
        kind = "num",
        min = 1,
        max = 8,
        step = 1,
        default = 2,
        label = "Thickness"
    },
    XhGap = {
        kind = "num",
        min = 0,
        max = 30,
        step = 1,
        default = 3,
        label = "Center Gap"
    },
    XhRotation = {
        kind = "num",
        min = 0,
        max = 45,
        step = 1,
        default = 0,
        label = "Rotation",
        slider = true,
        unit = "°"
    },
    XhOpacity = {
        kind = "num",
        min = 0.1,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Opacity",
        percent = true
    },
    XhDot = { kind = "bool", default = true, label = "Center Dot" },
    XhDotSize = {
        kind = "num",
        min = 1,
        max = 10,
        step = 1,
        default = 2,
        label = "Dot Size"
    },
    XhOutline = { kind = "bool", default = true, label = "Black Outline" },
    XhDynamic = { kind = "bool", default = true, label = "Dynamic Spread" },
    XhCombatOnly = { kind = "bool", default = true, label = "Lines Only In Combat" },
    XhHitmarker = {
        kind = "num",
        min = 0.5,
        max = 1.5,
        step = 0.05,
        default = 1,
        label = "Hitmarker Size",
        percent = true
    },
    XhHitmarkerOn = { kind = "bool", default = true, label = "Hitmarker" },
    VolWeapons = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Weapons",
        percent = true
    },
    VolVehicles = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Vehicles",
        percent = true
    },
    VolEffects = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Sound Effects",
        percent = true
    },
    VolMusic = {
        kind = "num",
        min = 0,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Music",
        percent = true
    },
    FireMovesCamera = { kind = "bool", default = true, label = "Fire Button Moves Camera" },
    ButtonsMoveCamera = { kind = "bool", default = true, label = "Buttons Move Camera" },
    TouchOpacity = {
        kind = "num",
        min = 0.2,
        max = 1,
        step = 0.05,
        default = 1,
        label = "Buttons Opacity",
        percent = true,
        slider = true
    },
    InteractButton = { kind = "bool", default = true, label = "Interact Button" },
    HoldToAim = { kind = "bool", default = false, label = "Hold to Aim" },
    FireAims = { kind = "bool", default = true, label = "Fire Button Aims" },
    HudButtonsTop = { kind = "bool", default = false, label = "Menu Buttons Top Right" },
    Compass = { kind = "bool", default = true, label = "Compass" },
    KillStreakSound = { kind = "bool", default = true, label = "Killstreak Sound" },
    KillStreakLogo = { kind = "bool", default = true, label = "Killstreak Logo" },
    EnemyGunSounds = { kind = "bool", default = true, label = "Enemy Custom Gun Sounds" },
    PartyInvites = { kind = "bool", default = true, label = "Party Invites" },
    DiverTank = { kind = "bool", default = true, label = "Diver Oxygen Tank" },
    HitSound = {
        kind = "choice",
        default = 1,
        label = "Hitmarker Sound",
        options = { 1, 2, 3 },
        labels = { "Hitmarker 1", "Hitmarker 2", "Hitmarker 3" }
    },
    Binds = { kind = "binds", label = "Key Bindings" },
    MobileLayout = { kind = "layout", label = "Touch Buttons" },
    Rebind = {
        kbm = {
            max = 2,
            actions = {
                "MoveForward",
                "MoveBack",
                "MoveLeft",
                "MoveRight",
                "Roll",
                "Fire",
                "Aim",
                "Reload",
                "Sprint",
                "Crouch",
                "Shoulder",
                "Interact",
                "Inventory",
                "Attachments",
                "CursorMode",
                "Dance",
                "Slot1",
                "Slot2",
                "Slot3",
                "Slot4",
                "Slot5",
                "DriveBrake",
                "DriveWheelie",
                "VehicleLock",
                "VehicleRepair",
                "HideUI",
                "Shop",
                "HudMenu",
                "Effects"
            },
            ctx = {
                Sprint = "Foot",
                Crouch = "Foot",
                Shoulder = "Foot",
                Dance = "Foot",
                Roll = "Foot",
                DriveBrake = "Car",
                DriveWheelie = "Car",
                VehicleLock = "Car",
                VehicleRepair = "Car"
            },
            reserved = {
                "Escape",
                "Slash",
                "F9",
                "F11",
                "F12",
                "F2",
                "F4",
                "F6",
                "F7",
                "F8",
                "Print",
                "Menu",
                "LeftSuper",
                "RightSuper",
                "LeftMeta",
                "RightMeta",
                "Unknown"
            },
            footReserved = { }
        },
        pad = {
            max = 1,
            actions = {
                "Fire",
                "Aim",
                "Reload",
                "Crouch",
                "Sprint",
                "Shoulder",
                "Interact",
                "HotbarPrev",
                "HotbarNext",
                "Inventory",
                "Attachments",
                "TopbarFocus",
                "PadMenu",
                "Dance",
                "CursorMode",
                "DriveBrake",
                "DriveAim",
                "DriveFire",
                "DriveSwap",
                "DriveWheelie",
                "VehicleLock",
                "VehicleRepair"
            },
            ctx = {
                Fire = "Foot",
                Aim = "Foot",
                Crouch = "Foot",
                Sprint = "Foot",
                Shoulder = "Foot",
                HotbarPrev = "Foot",
                Dance = "Foot",
                HotbarNext = "Foot",
                DriveBrake = "Car",
                DriveAim = "Car",
                DriveFire = "Car",
                DriveSwap = "Car",
                DriveWheelie = "Car",
                VehicleLock = "Car",
                VehicleRepair = "Car"
            },
            buttons = {
                "ButtonA",
                "ButtonB",
                "ButtonX",
                "ButtonY",
                "ButtonL1",
                "ButtonR1",
                "ButtonL2",
                "ButtonR2",
                "ButtonL3",
                "ButtonR3",
                "ButtonSelect",
                "DPadUp",
                "DPadDown",
                "DPadLeft",
                "DPadRight"
            },
            footReserved = { "ButtonA" },
            carReserved = { "ButtonL2", "ButtonR2" }
        },
        mouse = { "MouseButton1", "MouseButton2", "MouseButton3" }
    }
}
local Success, Result = pcall( function()
    return require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ClanShared" ) )
end )

if Success and Result and Result.Enabled( ) then
    table.insert( Table.Rebind.kbm.actions, "Clan" )
end

Table.TouchLayout = { max = 40, size = { 0.5, 1.6 }, opacity = { 0.2, 1 }, step = 0.05 }
function Table.CleanLayout( List )
    if type( List ) ~= "table" then
        return nil
    end

    local Value1, Number
    local TouchLayout = Table.TouchLayout
    local TableInner = { }
    Value1 = nil
    Number = 0

    for Key, Value in List, nil, nil do
        if TouchLayout.max <= Number then
            break
        end
        if type( Key ) == "string" and #Key <= 60 and Key:match( "^[%w_]+%.[%w_]+$" ) and type( Value ) == "table" then
            local Table2 = { }
            local Number2 = tonumber( Value.x )
            local Number3 = tonumber( Value.y )

            if Value.h == "L" or Value.h == "C" or Value.h == "R" then
                if Number2 and Number3 and Number2 == Number2 and Number3 == Number3 then
                    Table2.h = Value.h
                    Table2.x = math.round( math.clamp( Number2, -3, 3 ) * 1000 ) / 1000
                    Table2.y = math.round( math.clamp( Number3, 0, 1 ) * 1000 ) / 1000
                end
            end

            local Value2
            local Table3 = { s = TouchLayout.size, o = TouchLayout.opacity }
            Value2 = nil

            for Key2, Value3 in Table3, nil, nil do
                local Number4 = tonumber( Value[ Key2 ] )

                if Number4 and Number4 == Number4 then
                    local Round = math.round( Number4 / TouchLayout.step ) * TouchLayout.step
                    local Item = Value3[ 1 ]
                    local Round2 = math.round( math.clamp( Round, Item, Value3[ 2 ] ) * 100 ) / 100

                    if math.abs( Round2 - 1 ) > 0.001 then
                        Table2[ Key2 ] = Round2
                    end
                end
            end
            if Value.m == "t" or Value.m == "h" then
                Table2.m = Value.m
            end
            if next( Table2 ) then
                TableInner[ Key ] = Table2
                Number = Number + 1
            end
        end
    end

    return TableInner
end
function Table.ValidInput( InputName, Argument2 )
    local Rebind = Table.Rebind

    if type( Argument2 ) ~= "string" then
        return false
    end
    if InputName == "kbm" then
        if table.find( Rebind.mouse, Argument2 ) then
            return true
        end
        if table.find( Rebind.kbm.reserved, Argument2 ) then
            return false
        end
        if Argument2:find( "^Button" ) or Argument2:find( "^DPad" ) or Argument2:find( "^Thumbstick" ) or Argument2:find( "^Mouse" ) or Argument2:find( "^Gamepad" ) then
            return false
        end

        local Success2
        local Success, Result = pcall( function()
            return Enum.KeyCode[ Argument2 ]
        end )

        if Success then
            if typeof( Result ) == "EnumItem" then
                Success2 = true
            else
                Success2 = false
            end
        else
            Success2 = Success
        end

        return Success2
    end
    if InputName ~= "pad" then
        return false
    end

    local Flag
    Flag = table.find( Rebind.pad.buttons, Argument2 ) ~= nil and true or false
    return Flag
end
function Table.AllowedFor( ForName, ForName2, Argument3 )
    local Entry = Table.Rebind[ ForName ]

    if not Entry or not table.find( Entry.actions, ForName2 ) then
        return false
    end

    local Entry2 = Entry.ctx[ ForName2 ] or "Both"

    if Entry2 ~= "Car" then
        local FootReserved2
        local FootReserved = Entry.footReserved
        FootReserved2 = if FootReserved then FootReserved else { }

        if table.find( FootReserved2, Argument3 ) then
            return false
        end
    end
    if Entry2 ~= "Foot" then
        local CarReserved2
        local CarReserved = Entry.carReserved
        CarReserved2 = if CarReserved then CarReserved else { }

        if table.find( CarReserved2, Argument3 ) then
            return false
        end
    end

    return Table.ValidInput( ForName, Argument3 )
end
function Table.CleanBinds( List )
    if type( List ) ~= "table" then
        return nil
    end

    local Value1
    local TableInner = { kbm = { }, pad = { } }
    local Table2 = { "kbm", "pad" }
    Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Entry = Table.Rebind[ Value ]
        local Entry2 = List[ Value ]

        if type( Entry2 ) == "table" then
            local Value2
            local Actions = Entry.actions
            Value2 = nil

            for Key2, Value3 in Actions, nil, nil do
                local Entry3 = Entry2[ Value3 ]

                if type( Entry3 ) == "table" then
                    local Table3 = { }
                    local Max = Entry.max
                    local K = 1

                    for K = 1, Max do
                        local Entry4 = Entry3[ K ]

                        if Table.AllowedFor( Value, Value3, Entry4 ) and not table.find( Table3, Entry4 ) then
                            table.insert( Table3, Entry4 )
                        end
                    end
                    if #Table3 > 0 or Entry3[ 1 ] == nil then
                        TableInner[ Value ][ Value3 ] = Table3
                    end
                end
            end
        end
    end

    return TableInner
end
return Table
