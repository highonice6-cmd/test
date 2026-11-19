-- StarterPlayer.StarterPlayerScripts.RankedHubClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LocalPlayer = Players.LocalPlayer
local Ranked = workspace:WaitForChild( "Ranked", 60 )

if not Ranked then
    return
end

local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Table = {
    {
        nom = "Accueil_Ranked",
        texte = "TELEPORT TO RANKED HUB",
        remote = "AllerRanked",
        lieu = "Ranked"
    },
    {
        nom = "Retour_Gunshop",
        texte = "EXIT",
        remote = "RetourGunshop",
        lieu = "the Gun Shop"
    },
    {
        nom = "Pad_Ranked_1v1",
        ouvrir = true,
        mode = "1v1",
        kind = "ranked",
        lieu = "Ranked"
    },
    {
        nom = "Pad_Ranked_2v2",
        ouvrir = true,
        mode = "2v2",
        kind = "ranked",
        lieu = "Ranked"
    },
    {
        nom = "Pad_Ranked_5v5",
        ouvrir = true,
        mode = "5v5",
        kind = "ranked",
        lieu = "Ranked"
    },
    {
        nom = "Pad_Casual_1v1",
        ouvrir = true,
        mode = "1v1",
        kind = "unranked",
        lieu = "Ranked"
    },
    {
        nom = "Pad_Casual_2v2",
        ouvrir = true,
        mode = "2v2",
        kind = "unranked",
        lieu = "Ranked"
    },
    {
        nom = "Pad_Casual_5v5",
        ouvrir = true,
        mode = "5v5",
        kind = "unranked",
        lieu = "Ranked"
    }
}
local RankedHub = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "RankedHub", 600 )

if RankedHub then
    RankedHub.Enabled = true
    local Use = RankedHub:WaitForChild( "Use" )
    local Label = Use:WaitForChild( "Key" ):WaitForChild( "Label" )
    local Text = Use:WaitForChild( "Text" )
    Use.Visible = false

    local function InteractKeys()
        local Actions2
        local Actions = Controls.Actions
        Actions2 = if Actions then Controls.Actions.Interact else Actions
        local Keys
        local Table = { }
        local Table2 = { }
        Keys = Actions2 and Actions2.keys or { }
        local Value1 = nil

        for Key, Value in Keys, nil, nil do
            table.insert( Table, Value )
        end

        local Pad = Actions2 and Actions2.pad or { }
        local Value2 = nil

        for Key2, Value3 in Pad, nil, nil do
            table.insert( Table2, Value3 )
        end

        local Table3 = if #Table == 0 then { Enum.KeyCode.E } else Table
        local Table4 = if #Table2 == 0 then { Enum.KeyCode.ButtonX } else Table2
        return Table3, Table4
    end

    local function KeyText()
        local LastInputType = UserInputService:GetLastInputType( )

        if LastInputType == Enum.UserInputType.Touch or Controls.TouchMode( ) then
            return "TAP"
        end

        local Value1, Value2 = InteractKeys( )

        if LastInputType.Name:find( "Gamepad" ) then
            return ( Value2[ 1 ].Name:gsub( "^Button", "" ) )
        end

        local Result2
        local KeyName = Controls.KeyName
        local Success, Result = pcall( KeyName, Value1[ 1 ].Name, true )
        Result2 = Success and Result or Value1[ 1 ].Name
        return Result2
    end

    local function Modele( Name )
        local Pads2
        local Pads = Ranked:FindFirstChild( "Pads" )
        Pads2 = if Pads then Pads:FindFirstChild( Name ) else Pads
        return Pads2
    end

    local function SolDe( Object )
        local Dalle

        if Object then
            Dalle = Object:FindFirstChild( "Dalle" )
        else
            Dalle = Object
        end

        local Dalle2 = if Dalle then Dalle:FindFirstChild( "Sol" ) else Dalle
        return Dalle2
    end

    local function CarreActuel()
        if Ranked:GetAttribute( "Enabled" ) == false then
            return nil
        end
        if LocalPlayer:GetAttribute( "InTutorial" ) ~= nil then
            return nil
        end

        local HumanoidRootPart
        local Character = LocalPlayer.Character

        if Character then
            HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end

        local Humanoid

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
            return nil
        end

        local Value1 = nil

        for Key, Value in Table, nil, nil do
            local FoundChild
            local Nom = Value.nom
            local Pads = Ranked:FindFirstChild( "Pads" )

            if Pads then
                FoundChild = Pads:FindFirstChild( Nom )
            else
                FoundChild = Pads
            end

            local Dalle

            if FoundChild then
                Dalle = FoundChild:FindFirstChild( "Dalle" )
            else
                Dalle = FoundChild
            end

            local Sol

            if Dalle then
                Sol = Dalle:FindFirstChild( "Sol" )
            else
                Sol = Dalle
            end
            if Sol then
                local PointToObjectSpace = Sol.CFrame:PointToObjectSpace( HumanoidRootPart.Position )

                if math.abs( PointToObjectSpace.X ) <= Sol.Size.X / 2 + 0.3 and math.abs( PointToObjectSpace.Z ) <= Sol.Size.Z / 2 + 0.3 and PointToObjectSpace.Y >= -1 then
                    if PointToObjectSpace.Y <= 7 then
                        return Value
                    end
                end
            end
        end

        return nil
    end

    local Value1 = nil
    local Flag = false

    local function Partir()
        if Flag or not Use.Visible or not Value1 then
            return
        end
        if Value1.ouvrir then
            return
        end

        local FoundChild = Ranked:FindFirstChild( Value1.remote )

        if not FoundChild then
            return
        end

        local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

        if CombatUntil and workspace:GetServerTimeNow( ) < CombatUntil then
            Notify.Error( "You can't go to " .. Value1.lieu .. " during a fight" )
            return
        end

        Flag = true
        local Success, Result = pcall( FoundChild.InvokeServer, FoundChild )
        Flag = false

        if Success and type( Result ) == "string" then
            Notify.Error( Result )
        end
    end

    Use.Activated:Connect( Partir )
    UserInputService.InputBegan:Connect( function( Argument1, Argument2 )
        if Argument2 or not Use.Visible then
            return
        end

        local Value1, Value2 = InteractKeys( )

        if table.find( Value1, Argument1.KeyCode ) or table.find( Value2, Argument1.KeyCode ) then
            Partir( )
        end
    end )

    local function OuvrirFenetre( Argument1 )
        local RankedModes
        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if PlayerGui then
            RankedModes = PlayerGui:FindFirstChild( "RankedModes" )
        else
            RankedModes = PlayerGui
        end

        local OuvrirDepuisPad

        if RankedModes then
            OuvrirDepuisPad = RankedModes:FindFirstChild( "OuvrirDepuisPad" )
        else
            OuvrirDepuisPad = RankedModes
        end
        if OuvrirDepuisPad then
            OuvrirDepuisPad:Fire( Argument1 and Argument1.mode, Argument1 and Argument1.kind )
        end
    end

    local Value2 = nil
    local Number = 0
    RunService.Heartbeat:Connect( function( Argument1 )
        Number = Number + Argument1

        if Number < 0.1 then
            return
        end

        local Value2Inner
        Number = 0
        local CarreActuel2 = CarreActuel( )

        if not CarreActuel2 or not CarreActuel2.ouvrir then
            Value2 = nil
            Value2Inner = CarreActuel2
        else
            if Value2 ~= CarreActuel2 then
                local RankedModes
                Value2 = CarreActuel2
                local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

                if PlayerGui then
                    RankedModes = PlayerGui:FindFirstChild( "RankedModes" )
                else
                    RankedModes = PlayerGui
                end

                local OuvrirDepuisPad

                if RankedModes then
                    OuvrirDepuisPad = RankedModes:FindFirstChild( "OuvrirDepuisPad" )
                else
                    OuvrirDepuisPad = RankedModes
                end
                if OuvrirDepuisPad then
                    local Mode = if CarreActuel2 then CarreActuel2.mode else CarreActuel2
                    local Kind = if CarreActuel2 then CarreActuel2.kind else CarreActuel2
                    OuvrirDepuisPad:Fire( Mode, Kind )
                end
            end

            Value2Inner = nil
        end

        Value1 = Value2Inner

        if Value2Inner then
            Label.Text = KeyText( )

            if Text.Text ~= Value2Inner.texte then
                Text.Text = Value2Inner.texte
            end
        end

        local Visible = Value2Inner ~= nil and true or false

        if Use.Visible ~= Visible then
            Use.Visible = Visible
        end
    end )
    local Table2 = { "Wardrobe", "Armory", "CaseMenu", "VehicleCrateMenu" }

    local function SceneOpen()
        if ClientState.FixedCamera or ClientState.WardrobeOpen or ClientState.CaseRolling then
            return true
        end
        if LocalPlayer:GetAttribute( "InWardrobe" ) == true or LocalPlayer:GetAttribute( "Onboarding" ) == true then
            return true
        end
        if LocalPlayer:GetAttribute( "InTutorial" ) ~= nil then
            return true
        end

        local PlayerGui = LocalPlayer:FindFirstChildOfClass( "PlayerGui" )

        if not PlayerGui then
            return false
        end

        local Value1 = nil

        for Key, Value in Table2, nil, nil do
            local Success, Result = pcall( function()
                return Screens.IsShown( Screens.Find( Value, PlayerGui ) )
            end )

            if Success then
                if Result then
                    return true
                end
            end
        end

        return false
    end

    local Table3 = { }

    local function Cacher( Key, Argument2 )
        local Entry3
        local Entry = Table3[ Key ]
        Entry3 = if Entry then Entry else { }

        for Key2, Value in Key:GetDescendants( ) do
            if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
                local LocalTransparencyModifier = not Argument2 and 0 or 1
                Value.LocalTransparencyModifier = LocalTransparencyModifier
            elseif Value:IsA( "Beam" ) or Value:IsA( "ParticleEmitter" ) or Value:IsA( "Light" ) or Value:IsA( "SurfaceGui" ) or Value:IsA( "BillboardGui" ) then
                if Argument2 then
                    if Entry3[ Value ] == nil then
                        Entry3[ Value ] = Value.Enabled
                    end

                    Value.Enabled = false
                elseif Entry3[ Value ] ~= nil then
                    Value.Enabled = Entry3[ Value ]
                end
            end
        end

        local Entry2 = if not Argument2 or not Entry3 then nil else Entry3
        Table3[ Key ] = Entry2
    end

    local Number2 = 0
    RunService.Heartbeat:Connect( function( Argument1 )
        Number2 = Number2 + Argument1

        if Number2 < 0.05 then
            return
        end

        local Value2
        Number2 = 0
        local SceneOpen2 = SceneOpen( )
        Value2 = nil

        for Value in Table3, nil, nil do
            if not SceneOpen2 or not Value:IsDescendantOf( workspace ) then
                if Value.Parent then
                    Cacher( Value, false )
                else
                    Table3[ Value ] = nil
                end
            end
        end
        if SceneOpen2 then
            local Value3 = nil

            for Key, Value4 in Table, nil, nil do
                local FoundChild
                local Nom = Value4.nom
                local Pads = Ranked:FindFirstChild( "Pads" )

                if Pads then
                    FoundChild = Pads:FindFirstChild( Nom )
                else
                    FoundChild = Pads
                end
                if FoundChild and not Table3[ FoundChild ] then
                    Cacher( FoundChild, true )
                end
            end
        end
    end )
    return
end
return
