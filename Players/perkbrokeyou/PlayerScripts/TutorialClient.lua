-- Players.perkbrokeyou.PlayerScripts.TutorialClient
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
local TweenService = game:GetService( "TweenService" )
local UserInputService = game:GetService( "UserInputService" )
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild( "PlayerGui" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Tutorial = ReplicatedStorage:WaitForChild( "Tutorial" )
local Config = require( Tutorial:WaitForChild( "Config" ) )
local Remote = Tutorial:WaitForChild( "Remote" )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local Success, Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
end )
local TutorialGui = PlayerGui:WaitForChild( "TutorialGui", math.huge )
local Objective = TutorialGui:WaitForChild( "Objective" )
local Banner = TutorialGui:WaitForChild( "Banner" )
local Pointer = TutorialGui:WaitForChild( "Pointer" )
local Warn = TutorialGui:WaitForChild( "Warn" )
local Fade = TutorialGui:WaitForChild( "Fade" )
local Table = { }
local Table2 = { }

for Index, Value in ipairs( Config.Steps ) do
    Table[ Value.Id ] = Index
    Table2[ Value.Id ] = Value
end

local Value2
local Fights = Config.Fights

local function Money( Argument1 )
    local Gsub
    local Text = tostring( ( math.floor( Argument1 ) ) )

    while true do
        Gsub, Gsub2 = Text:gsub( "^(%d+)(%d%d%d)", "%1,%2" )

        if Gsub2 == 0 then
            break
        end

        Text = Gsub
    end

    return "$" .. Gsub
end

local function KeyText( Argument1 )
    local Text

    if not UserInputService.TouchEnabled or UserInputService.KeyboardEnabled then
        if not UserInputService.GamepadEnabled or UserInputService.KeyboardEnabled then
            Text = "[E]"
        else
            Text = "[X]"
        end
    else
        Text = "TAP"
    end

    return ( Argument1:gsub( "%[E%]", Text ):gsub( "<b>", "<font color=\"#FFD25A\"><b>" ):gsub( "</b>", "</b></font>" ) )
end

local function StationPos()
    local FoundChild
    local CaseStations = workspace:FindFirstChild( "CaseStations" )

    if CaseStations then
        FoundChild = CaseStations:FindFirstChild( Config.CaseStation )
    else
        FoundChild = CaseStations
    end
    if FoundChild then
        local Pad = FoundChild:FindFirstChild( "Pad", true )

        if Pad then
            FoundChild = Pad
        else
            FoundChild = FoundChild.PrimaryPart
        end
    end
    if not FoundChild or not FoundChild:IsA( "BasePart" ) then
        return Config.CaseStationPos
    end
    return FoundChild.Position - Vector3.new( 0, FoundChild.Size.Y / 2, 0 )
end

local CFrame2 = Config.ShopBox.CFrame
local Size = Config.ShopBox.Size / 2

local function InShop( Argument1 )
    local Flag
    local PointToObjectSpace = CFrame2:PointToObjectSpace( Argument1 )

    if math.abs( PointToObjectSpace.X ) <= Size.X then
        if math.abs( PointToObjectSpace.Y ) <= Size.Y then
            if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end

local function Step()
    return LocalPlayer:GetAttribute( "InTutorial" )
end

local function OnMap()
    local Flag

    if LocalPlayer:GetAttribute( "Onboarding" ) == false then
        if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = false
        elseif ClientState.IntroCinematic == true then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end

    return Flag
end

local function Rolling()
    local Flag = ClientState.CaseRolling == true and true or false
    return Flag
end

local Flag = false

local function GuideActive()
    local Flag2

    if LocalPlayer:GetAttribute( "StashGuide" ) == true then
        local NotCaptured = not Flag

        if NotCaptured then
            local FlagInner = ClientState.CaseRolling == true and true or false
            Flag2 = not FlagInner
        else
            Flag2 = NotCaptured
        end
    else
        Flag2 = false
    end

    return Flag2
end

local function SafePos()
    local Interactions2
    local Interactions = workspace:FindFirstChild( "Interactions" )
    Interactions2 = if Interactions then Interactions else workspace
    local GradientCylinder
    local RondBleu = Interactions2:FindFirstChild( "RondBleu" )

    if RondBleu then
        GradientCylinder = RondBleu:FindFirstChild( "GradientCylinder" )
    else
        GradientCylinder = RondBleu
    end
    if GradientCylinder and GradientCylinder:IsA( "BasePart" ) then
        return GradientCylinder.Position
    end

    local Position2

    if RondBleu then
        local Position = RondBleu:GetPivot( ).Position

        if Position then
            Position2 = Position
        else
            Position2 = Vector3.new( -69.5, 18.200000762939453, 885.9000244140625 )
        end
    else
        Position2 = Vector3.new( -69.5, 18.200000762939453, 885.9000244140625 )
    end

    return Position2
end

local function Refresh()
    local InTutorial2
    local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )
    InTutorial2 = if InTutorial then Table2[ InTutorial ] else InTutorial
    local Enabled

    if InTutorial2 == nil then
        local Visible = Banner.Visible

        if Visible then
            Enabled = Visible
        elseif LocalPlayer:GetAttribute( "StashGuide" ) == true then
            local NotCaptured = not Flag

            if NotCaptured then
                local FlagInner

                if ClientState.CaseRolling == true then
                    FlagInner = true
                else
                    FlagInner = false
                end

                Enabled = not FlagInner
            else
                Enabled = NotCaptured
            end
        else
            Enabled = false
        end
    else
        if LocalPlayer:GetAttribute( "Onboarding" ) == false then
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                Enabled = false
            elseif ClientState.IntroCinematic == true then
                Enabled = false
            else
                Enabled = true
            end
        else
            Enabled = false
        end
        if not Enabled then
            local Visible = Banner.Visible

            if Visible then
                Enabled = Visible
            elseif LocalPlayer:GetAttribute( "StashGuide" ) == true then
                local NotCaptured = not Flag

                if NotCaptured then
                    if ClientState.CaseRolling == true then
                        FlagInner = true
                    else
                        FlagInner = false
                    end

                    Enabled = not FlagInner
                else
                    Enabled = NotCaptured
                end
            else
                Enabled = false
            end
        end
    end

    TutorialGui.Enabled = Enabled

    if not InTutorial2 then
        Objective.Visible = false
        return
    end

    local Visible2
    local Step = Objective.Badge.Step
    Step.Text = ( "%d/%d" ):format( Table[ InTutorial ], #Config.Steps )
    local Title = Objective.Title
    Title.Text = InTutorial2.Title
    local Desc = Objective.Desc
    Desc.Text = KeyText( InTutorial2.Desc )
    local Entry = Fights[ InTutorial ]
    local Bar = Objective.Bar
    Visible2 = Entry ~= nil and true or false
    local Visible3
    Bar.Visible = Visible2
    local Desc2 = Objective.Desc

    if InTutorial2.Desc == "" then
        Visible3 = false
    elseif Entry == nil then
        Visible3 = true
    else
        Visible3 = false
    end

    Desc2.Visible = Visible3

    if Entry then
        local Min2, Text

        if Entry.Kills then
            local Number = tonumber( LocalPlayer:GetAttribute( "TutoKills" ) ) or 0
            local Min = math.min( Number, Entry.Kills )
            Min2 = Min / Entry.Kills
            Text = ( "%d / %d KILLS" ):format( Min, Entry.Kills )
        elseif tonumber( LocalPlayer:GetAttribute( "TutoKillGoal" ) ) then
            local Max = math.max( 1, ( tonumber( LocalPlayer:GetAttribute( "TutoKillGoal" ) ) ) )
            local Min3 = math.min( tonumber( LocalPlayer:GetAttribute( "TutoKills" ) ) or 0, Max )
            Min2 = Min3 / Max
            Text = ( "KILL %d PEOPLE  (%d/%d)" ):format( Max, Min3, Max )
        else
            local Number2 = tonumber( LocalPlayer:GetAttribute( "TutoCash" ) ) or 0
            local Min4 = math.min( Number2, Config.CashGoal )
            Min2 = Min4 / Config.CashGoal
            local Money2 = Money( Min4 )
            Text = Money2 .. " / " .. Money( Config.CashGoal )
        end

        TweenService:Create( Objective.Bar.Fill, TweenInfo.new( 0.35, Enum.EasingStyle.Quad ), { Size = UDim2.fromScale( Min2, 1 ) } ):Play( )
        Objective.Bar.Amount.Text = Text
    end
end

local Table3 = {
    "InTutorial",
    "TutoCash",
    "TutoKills",
    "TutoKillGoal",
    "Onboarding",
    "InWardrobe",
    "StashGuide"
}
Value2 = nil

for Key, Value3 in Table3, nil, nil do
    LocalPlayer:GetAttributeChangedSignal( Value3 ):Connect( Refresh )
end

local Number = 0
local Position = Banner.Position

local function ShowBanner( Text, Text2, Amount )
    Number = Number + 1
    local Title = Banner.Title
    local Sub = Banner.Sub
    Title.Text = Text
    Sub.Text = Text2
    Banner.Position = Position
    Banner.Pop.Scale = 0.55
    Banner.Visible = true
    TutorialGui.Enabled = true
    TweenService:Create( Banner.Pop, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
    task.delay( Amount or 3.2, function()
        if Number ~= Number then
            return
        end

        TweenService:Create( Banner, TweenInfo.new( 0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { Position = Position - UDim2.fromScale( 0, 0.4 ) } ):Play( )
        task.wait( 0.4 )

        if Number == Number then
            Banner.Visible = false
            Refresh( )
            return
        end
        return
    end )
end

local function WaitNotRolling( Amount )
    local Clock = os.clock( )

    while true do
        local Flag = ClientState.CaseRolling == true and true or false

        if not Flag or not ( os.clock( ) - Clock < ( Amount or 20 ) ) then
            break
        end

        task.wait( 0.1 )
    end
end

local Number2 = 0
local Table4 = {
    roll1 = "STAY IN THE SHOP — GET YOUR GUN",
    roll2 = "STAY IN THE SHOP — UPGRADE YOUR GUN",
    fight1 = "STAY AROUND THE GUN SHOP",
    fight2 = "STAY AROUND THE GUN SHOP"
}

local function ShowWarn( WarnName )
    Number2 = Number2 + 1
    Warn.Text = Table4[ WarnName ] or "STAY AROUND THE GUN SHOP"
    Warn.Pop.Scale = 1.3
    Warn.Visible = true
    TutorialGui.Enabled = true
    TweenService:Create( Warn.Pop, TweenInfo.new( 0.25, Enum.EasingStyle.Back ), { Scale = 1 } ):Play( )
    task.delay( 2.6, function()
        if Number2 == Number2 then
            Warn.Visible = false
        end
    end )
end

local ProximityPromptService = game:GetService( "ProximityPromptService" )
local Class = setmetatable( { }, { __mode = "k" } )
ProximityPromptService.PromptShown:Connect( function( Key )
    if LocalPlayer:GetAttribute( "InTutorial" ) and Key.Name == "CarryPrompt" then
        Key.Enabled = false
        Class[ Key ] = true
    end
end )
LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( function()
    if LocalPlayer:GetAttribute( "InTutorial" ) then
        return
    end

    local Value1 = nil

    for Value in Class, nil, nil do
        Class[ Value ] = nil

        if Value.Parent then
            Value.Enabled = true
        end
    end
end )

local function FaceCamera()
    task.defer( function()
        if ClientState.FaceCamera then
            pcall( ClientState.FaceCamera )
        end
    end )
end

local function DoFade()
    TutorialGui.Enabled = true
    TweenService:Create( Fade, TweenInfo.new( 0.35 ), { BackgroundTransparency = 0 } ):Play( )
    task.delay( 1.1, function()
        TweenService:Create( Fade, TweenInfo.new( 0.6 ), { BackgroundTransparency = 1 } ):Play( )
    end )
end

local Inventory = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "Inventory" ) )

local function ToBar( Argument1 )
    local Success, Result = pcall( Inventory.Layout )

    if not Success or type( Result ) ~= "table" then
        return
    end

    local Value1, Value2
    Value1 = nil

    for Key, Value in Result, nil, nil do
        if typeof( Value ) == "Instance" then
            if Value:GetAttribute( "Weapon" ) == Argument1 then
                Value2 = Key
                break
            end
        end

        Value2 = nil
    end
    if not Value2 or Value2 <= Inventory.HOTBAR then
        return
    end

    local Value3
    local HOTBAR = Inventory.HOTBAR
    local I = 1
    Value3 = nil

    for I = 1, HOTBAR do
        local Entry = Result[ I ]

        if I ~= Inventory.FISTS and Entry and Inventory.IsWeapon( Entry ) then
            Value3 = I
            break
        end

        Value3 = nil
    end
    if not Value3 then
        local HOTBAR2 = Inventory.HOTBAR
        local I2 = 1

        for I2 = 1, HOTBAR2 do
            if I2 ~= Inventory.FISTS and not Result[ I2 ] then
                Value3 = I2
                break
            end
        end
    end
    if Value3 then
        pcall( Inventory.Move, Value2, Value3 )
    end
end

local function EquipRolled( RolledName )
    local Entry = Config.Rolls[ RolledName ]

    if not Entry then
        return
    end

    local Character, Humanoid
    local Clock = os.clock( )

    while true do
        Character = LocalPlayer.Character

        if Character then
            Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
        else
            Humanoid = Character
        end
        if Humanoid and Humanoid.Health > 0 and not Character:GetAttribute( "Downed" ) then
            local Flag

            if LocalPlayer:GetAttribute( "Onboarding" ) == false then
                if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                    Flag = false
                elseif ClientState.IntroCinematic == true then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = false
            end
            if Flag then
                break
            end
        end

        task.wait( 0.25 )

        if os.clock( ) - Clock > 15 then
            break
        end
    end
    if not Humanoid or Humanoid.Health <= 0 or LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        return
    end

    ToBar( Entry.Weapon )
    task.wait( 0.2 )
    local Tool = Character:FindFirstChildOfClass( "Tool" )

    if Tool and Tool:GetAttribute( "Weapon" ) == Entry.Weapon then
        return
    end

    local Children
    local Backpack = LocalPlayer:FindFirstChildOfClass( "Backpack" )
    Children = Backpack and Backpack:GetChildren( ) or { }
    local Value1 = nil

    for Key, Value in Children, nil, nil do
        if Value:IsA( "Tool" ) then
            if Value:GetAttribute( "Weapon" ) == Entry.Weapon then
                Humanoid:UnequipTools( )
                Humanoid:EquipTool( Value )
                return
            end
        end
    end
end

local Value4 = nil
local Flag2 = false

local function AutoBanner()
    local InTutorial2
    local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )
    InTutorial2 = if InTutorial then Table2[ InTutorial ] else InTutorial

    if InTutorial2 then
        local Flag

        if LocalPlayer:GetAttribute( "Onboarding" ) == false then
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                Flag = false
            elseif ClientState.IntroCinematic == true then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag and Value4 ~= InTutorial and not Flag2 then
            Value4 = InTutorial
            Flag2 = true
            task.spawn( function()
                task.wait( 0.3 )
                WaitNotRolling( 20 )
                task.wait( 0.4 )
                Flag2 = false

                if LocalPlayer:GetAttribute( "InTutorial" ) == InTutorial then
                    ShowBanner( InTutorial2.Banner, InTutorial2.BannerSub )
                    Refresh( )
                    return
                end
                AutoBanner( )
                return
            end )
            return
        end
    end
end

LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( AutoBanner )
local Flag3 = false

local function Arrived()
    local Flag
    AutoBanner( )

    if LocalPlayer:GetAttribute( "Onboarding" ) == false then
        if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
            Flag = false
        elseif ClientState.IntroCinematic == true then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
    if Flag and LocalPlayer:GetAttribute( "InTutorial" ) and not Flag3 then
        Flag3 = true
        task.delay( 0.25, FaceCamera )
    end
end

LocalPlayer:GetAttributeChangedSignal( "Onboarding" ):Connect( Arrived )
LocalPlayer:GetAttributeChangedSignal( "InWardrobe" ):Connect( Arrived )
task.defer( AutoBanner )
Remote.OnClientEvent:Connect( function( Name, WarnName, Name2 )
    if Name == "step" then
        if Name2 == "rolled" then
            local Entry2
            local Entry = Table[ WarnName ]
            Entry2 = if Entry then Config.Steps[ Table[ WarnName ] - 1 ] else Entry
            task.spawn( function()
                task.wait( 0.5 )
                WaitNotRolling( 20 )

                if Entry2 then
                    EquipRolled( Entry2.Id )
                end
            end )
        end
        if Name2 == "arrive" then
            local FlagInner
            AutoBanner( )

            if LocalPlayer:GetAttribute( "Onboarding" ) == false then
                if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                    FlagInner = false
                elseif ClientState.IntroCinematic == true then
                    FlagInner = false
                else
                    FlagInner = true
                end
            else
                FlagInner = false
            end
            if FlagInner and LocalPlayer:GetAttribute( "InTutorial" ) and not Flag3 then
                Flag3 = true
                task.delay( 0.25, FaceCamera )
            end
        end

        AutoBanner( )
        Refresh( )
        return
    end
    if Name == "warn" then
        ShowWarn( WarnName )
        return
    end
    if Name == "fade" then
        DoFade( )
        return
    end
    if Name == "face" then
        task.defer( function()
            if ClientState.FaceCamera then
                pcall( ClientState.FaceCamera )
            end
        end )
        return
    end
    if Name == "done" then
        Flag = true
        Refresh( )
        task.spawn( function()
            task.wait( 0.6 )
            WaitNotRolling( 30 )
            task.wait( 0.4 )
            local DoneBanner = Config.DoneBanner
            ShowBanner( DoneBanner, Config.DoneSub, 5 )

            if LocalPlayer:GetAttribute( "StashGuide" ) then
                task.wait( 5.6 )
                ShowBanner( "CHECK YOUR SAFE", "Your Community Pack (M4, Kevlar, E-Drinks, Medkit) is waiting in your safe", 4 )
            end

            Flag = false
            Refresh( )
        end )
    end

    return
end )
local Table5 = { }

local function Marker( Key )
    local Entry2
    local Entry = Table5[ Key ]

    if Entry then
        Entry2 = Entry
    else
        local Clone = Pointer:Clone( )
        Clone.Name = "Pointer" .. Key
        Clone.Parent = TutorialGui
        Table5[ Key ] = Clone
        Entry2 = Clone
    end

    return Entry2
end

local function Targets( HumanoidRootPart )
    local Table = { }
    local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )

    if InTutorial then
        local Flag = ClientState.CaseRolling == true and true or false

        if not Flag then
            local Flag2

            if LocalPlayer:GetAttribute( "Onboarding" ) == false then
                if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                    Flag2 = false
                elseif ClientState.IntroCinematic == true then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = false
            end
            if Flag2 then
                if Config.Rolls[ InTutorial ] then
                    local StationPos2 = StationPos( )
                    local X = StationPos2.X
                    local Vector32 = Vector3.new( X, 0, StationPos2.Z )
                    local X2 = HumanoidRootPart.Position.X

                    if ( Vector32 - Vector3.new( X2, 0, HumanoidRootPart.Position.Z ) ).Magnitude > 8 then
                        table.insert( Table, { StationPos2, "CASE" } )
                        return Table
                    end
                elseif Fights[ InTutorial ] then
                    local Character = LocalPlayer.Character

                    if Character and Character:GetAttribute( "InSafeZone" ) then
                        local Flag3
                        local PointToObjectSpace = CFrame2:PointToObjectSpace( HumanoidRootPart.Position )

                        if math.abs( PointToObjectSpace.X ) <= Size.X then
                            if math.abs( PointToObjectSpace.Y ) <= Size.Y then
                                if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                                    Flag3 = true
                                else
                                    Flag3 = false
                                end
                            else
                                Flag3 = false
                            end
                        else
                            Flag3 = false
                        end
                        if Flag3 then
                            table.insert( Table, { Config.ShopExitPos, "GO OUTSIDE" } )
                            return Table
                        end
                    end

                    local BotBox = Config.BotBox

                    if BotBox and Config.FightZoneHint then
                        local PointToObjectSpace2 = BotBox.CFrame:PointToObjectSpace( HumanoidRootPart.Position )
                        local SizeInner = BotBox.Size / 2
                        local Max = math.max( 0, math.abs( PointToObjectSpace2.X ) - SizeInner.X )
                        local Max2 = math.max( 0, math.abs( PointToObjectSpace2.Z ) - SizeInner.Z )
                        local Sqrt = math.sqrt( Max * Max + Max2 * Max2 )

                        if Config.FightZoneHint < Sqrt then
                            local Position = BotBox.CFrame.Position
                            local X3 = Position.X
                            local Y = Config.ShopExitPos.Y
                            table.insert( Table, { Vector3.new( X3, Y, Position.Z ), "FIGHT ZONE" } )
                        end
                    end

                    local Children
                    local HoodLocal = workspace:FindFirstChild( "HoodLocal" )
                    Children = HoodLocal and HoodLocal:GetChildren( ) or { }
                    local Value2 = nil

                    for Key, Value in Children, nil, nil do
                        if Value:GetAttribute( "HoodDowned" ) then
                            local UpperTorso = Value:FindFirstChild( "UpperTorso" )
                            local LowerTorso = Value:FindFirstChild( "LowerTorso" )

                            if UpperTorso and LowerTorso then
                                local Sin = math.sin( os.clock( ) * 6 ) * 0.35
                                table.insert( Table, 1, {
                                    ( UpperTorso.Position + LowerTorso.Position ) / 2 + Vector3.new( 0, Sin + 2, 0 ),
                                    "FINISH HIM"
                                } )
                            end
                        end

                        local UpperTorso2

                        if InTutorial == "fight1" then
                            local Lootable = Value:GetAttribute( "Lootable" )

                            if Lootable then
                                UpperTorso2 = Value:FindFirstChild( "UpperTorso" )
                            else
                                UpperTorso2 = Lootable
                            end
                        else
                            UpperTorso2 = false
                        end
                        if UpperTorso2 then
                            local Position2 = UpperTorso2.Position - HumanoidRootPart.Position

                            if Vector2.new( Position2.X, Position2.Z ).Magnitude >= 12 then
                                table.insert( Table, { UpperTorso2.Position, "LOOT" } )
                            end
                            if #Table >= 10 then
                                break
                            end
                        end
                    end
                end

                return Table
            end
        end
    end

    return Table
end

local function Place( Argument1, Item, Text, HumanoidRootPart, CurrentCamera, ViewportSize )
    local Number, Number2
    Argument1.Visible = true
    Argument1.Info.Label.Text = Text
    local Dist = Argument1.Info.Dist
    Dist.Text = math.floor( ( Item - HumanoidRootPart.Position ).Magnitude ) .. "m"
    local Total = Item + Vector3.new( 0, 2, 0 )
    local WorldToViewportPoint, WorldToViewportPoint2 = CurrentCamera:WorldToViewportPoint( Total )
    local X = WorldToViewportPoint.X / ViewportSize.X
    local Y = WorldToViewportPoint.Y / ViewportSize.Y

    if not WorldToViewportPoint2 or not ( X > 0.09 ) or not ( X < 0.91 ) or not ( Y > 0.2 ) or not ( Y < 0.91 ) then
        local Amount2
        local PointToObjectSpace = CurrentCamera.CFrame:PointToObjectSpace( Total )
        local X2 = PointToObjectSpace.X
        local Amount = -PointToObjectSpace.Y

        if PointToObjectSpace.Z > 0 then
            Amount2 = math.abs( Amount ) + PointToObjectSpace.Z * 0.5
        else
            Amount2 = Amount
        end

        local X3, Sqrt2
        local Sqrt = math.sqrt( X2 * X2 + Amount2 * Amount2 )

        if Sqrt < 0.0001 then
            X3 = 0
            Sqrt2 = 1
            Amount2 = 1
        else
            X3 = X2
            Sqrt2 = Sqrt
        end

        local X4 = X3 / Sqrt2
        local Amount3 = Amount2 / Sqrt2
        local X5 = ViewportSize.X * 0.22
        local Y2 = ViewportSize.Y * 0.3
        local Sqrt3 = 1 / math.sqrt( ( X4 / X5 ) ^ 2 + ( Amount3 / Y2 ) ^ 2 )
        Argument1.Position = UDim2.fromScale( 0.5 + X4 * Sqrt3 / ViewportSize.X, 0.47 + Amount3 * Sqrt3 / ViewportSize.Y )
        Number = Amount3
        Number2 = X4
    else
        Argument1.Position = UDim2.fromScale( X, Y - 0.03 )
        Number = 1
        Number2 = 0
    end

    local Abs3
    local Arrow = Argument1.Arrow
    Arrow.Rotation = math.deg( ( math.atan2( Number, Number2 ) ) ) + 90

    if math.abs( Number2 ) > 0.001 then
        local Abs = 2.15 / math.abs( Number2 )

        if Abs then
            Abs3 = Abs
        else
            Abs3 = math.huge
        end
    else
        Abs3 = math.huge
    end

    local Abs4

    if math.abs( Number ) > 0.001 then
        local Abs2 = 1.15 / math.abs( Number )

        if Abs2 then
            Abs4 = Abs2
        else
            Abs4 = math.huge
        end
    else
        Abs4 = math.huge
    end

    local Min = math.min( Abs3, Abs4 )
    local Info = Argument1.Info
    Info.Position = UDim2.fromScale( 0.5 - Number2 * Min, 0.5 - Number * Min )
end

local FromRGB = Color3.fromRGB( 255, 200, 60 )
local CFrame3 = CFrame.new( 0, -5000, 0 )
local CFrame4 = CFrame.new( 0, 0, 0.95 )
local Value5 = nil
local Table6 = { }
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local Unit = Vector3.new( 1.25, 0, 1.7000000476837158 ):Cross( Vector3.new( -1.25, 0, 1.7000000476837158 ) ).Unit
local Unit2 = Vector3.new( 2.5, 0, 0 ):Cross( Unit ).Unit
local Unit3 = Vector3.new( 2.5, 0, 0 ).Unit
local Abs = math.abs( ( Vector3.new( -1.25, 0, 1.7000000476837158 ):Dot( Unit2 ) ) )
local Table8 = {
    Vector3.new( 0.18, Abs, ( math.abs( ( Vector3.new( -1.25, 0, 1.7000000476837158 ):Dot( Unit3 ) ) ) ) ),
    CFrame.fromMatrix( Vector3.new( -0.625, 0, -0.8500000238418579 ), Unit, Unit2, Unit3 )
}
local Vector32 = Vector3.new( 0.18, Abs, ( math.abs( ( Vector3.new( 1.25, 0, 1.7000000476837158 ):Dot( Unit3 ) ) ) ) )
local Amount = -Unit
local Table7 = {
    Table8,
    {
        Vector32,
        CFrame.fromMatrix( Vector3.new( 0.625, 0, -0.8500000238418579 ), Amount, Unit2, -Unit3 )
    }
}

local function ClearGuide()
    if Value5 then
        Value5:Destroy( )
        Value5 = nil
        table.clear( Table6 )
    end
end

local function ArrowParts()
    local Table = { }
    local I = 1

    for I = 1, 3 do
        local Text = I ~= 1 and "WedgePart" or "Part"
        local Size
        local Instance2 = Instance.new( Text )
        Instance2.Name = "TutoArrow"
        Instance2.Anchored = true
        Instance2.CanCollide = false
        Instance2.CanQuery = false
        Instance2.CanTouch = false
        Instance2.CastShadow = false
        Instance2.Material = Enum.Material.Neon
        Instance2.Color = FromRGB
        Size = if I == 1 then Vector3.new( 0.8500000238418579, 0.18000000715255737, 1.899999976158142 ) else Table7[ I - 1 ][ 1 ]
        Instance2.Size = Size
        Instance2.CFrame = CFrame3
        Instance2.Parent = Value5
        Table[ I ] = Instance2
    end

    return Table
end

local function UpdateGuide( Guide )
    local Flag
    local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )

    if InTutorial == nil then
        Flag = false
    elseif Config.Rolls[ InTutorial ] == nil then
        Flag = false
    else
        if LocalPlayer:GetAttribute( "Onboarding" ) == false then
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                Flag = false
            elseif ClientState.IntroCinematic == true then
                Flag = false
            else
                Flag = true
            end
        else
            Flag = false
        end
        if Flag then
            local Flag2 = ClientState.CaseRolling == true and true or false
            local NotFlag = not Flag2

            if NotFlag then
                if Guide == nil then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = NotFlag
            end
        end
    end

    local Flag3

    if Flag then
        Flag3 = StationPos( )
    else
        Flag3 = Flag
    end
    if Flag then
        local X = Flag3.X - Guide.Position.X

        if Vector3.new( X, 0, Flag3.Z - Guide.Position.Z ).Magnitude < 4.5 then
            Flag = false
        end
    end
    if not Flag then
        if Value5 then
            Value5:Destroy( )
            Value5 = nil
            table.clear( Table6 )
        end

        return
    end
    if not Value5 then
        Value5 = Instance.new( "Model" )
        Value5.Name = "TutoGuideArrows"
        Value5.Parent = workspace.CurrentCamera
        local Highlight = Instance.new( "Highlight" )
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = Color3.new( 0, 0, 0 )
        Highlight.OutlineTransparency = 0
        Highlight.Adornee = Value5
        game:GetService( "CollectionService" ):AddTag( Highlight, "OwnFX" )
        Highlight.Parent = Value5
    end

    local Flag4
    local X2 = Guide.Position.X
    local Table = { ( Vector3.new( X2, 0, Guide.Position.Z ) ) }
    local PointToObjectSpace = CFrame2:PointToObjectSpace( Guide.Position )

    if math.abs( PointToObjectSpace.X ) <= Size.X then
        if math.abs( PointToObjectSpace.Y ) <= Size.Y then
            if math.abs( PointToObjectSpace.Z ) <= Size.Z then
                Flag4 = true
            else
                Flag4 = false
            end
        else
            Flag4 = false
        end
    else
        Flag4 = false
    end
    if not Flag4 then
        local X3 = Config.ShopExitPos.X
        table.insert( Table, ( Vector3.new( X3, 0, Config.ShopExitPos.Z ) ) )
    end

    local Number
    local X4 = Flag3.X
    table.insert( Table, ( Vector3.new( X4, 0, Flag3.Z ) ) )
    local Table2 = { }
    local Count = #Table - 1
    local I = 1
    Number = 0

    for I = 1, Count do
        local Magnitude = ( Table[ I + 1 ] - Table[ I ] ).Magnitude

        if Magnitude > 0.01 then
            table.insert( Table2, {
                a = Table[ I ],
                d = ( Table[ I + 1 ] - Table[ I ] ) / Magnitude,
                l = Magnitude,
                s = Number
            } )
            Number = Number + Magnitude
        end
    end
    if #Table2 == 0 then
        if Value5 then
            Value5:Destroy( )
            Value5 = nil
            table.clear( Table6 )
        end

        return
    end
    local function Along( Argument1 )
        local Value1 = nil

        for Key, Value in Table2, nil, nil do
            if not ( Argument1 <= Value.s + Value.l ) then
                if Key ~= #Table2 then
                    continue
                end
            end

            local A = Value.a
            local D = Value.d
            local S = Argument1 - Value.s
            return A + D * math.clamp( S, 0, Value.l ), Value.d
        end
    end

    local Number2 = Number - 2.6
    local Max = math.max( Number2 - 3, 0 )
    local FilterDescendantsInstances = { Value5 }

    if LocalPlayer.Character then
        table.insert( FilterDescendantsInstances, LocalPlayer.Character )
    end

    local HoodLocal = workspace:FindFirstChild( "HoodLocal" )

    if HoodLocal then
        table.insert( FilterDescendantsInstances, HoodLocal )
    end

    RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
    local Y = Guide.Position.Y + 1
    local Clock = 4.8 - os.clock( ) * 2.5 % 4.8
    local Max2 = math.max( 0, ( math.ceil( ( Max - Clock - 211.2 ) / 4.8 ) ) )
    local I2 = 1

    for I2 = 1, 45 do
        local Entry2
        local Entry = Table6[ I2 ]
        local Max3 = ( Max2 + I2 - 1 ) * 4.8 + Clock

        if not ( Max3 <= Max ) or Entry then
            Entry2 = Entry
        else
            local ArrowParts2 = ArrowParts( )
            Table6[ I2 ] = ArrowParts2
            Entry2 = ArrowParts2
        end
        if Entry2 then
            if Max < Max3 then
                local Value2 = nil

                for Key, Value in Entry2, nil, nil do
                    Value.CFrame = CFrame3
                end
            else
                local Y3
                local Along2, Along22 = Along( Number2 - Max3 )
                local X5 = Along2.X
                local Raycast = workspace:Raycast( Vector3.new( X5, Y, Along2.Z ), Vector3.new( 0, -12, 0 ), RaycastParams2 )
                local X6 = Along2.X

                if Raycast then
                    local Y2 = Raycast.Position.Y + 0.1

                    if Y2 then
                        Y3 = Y2
                    else
                        Y3 = Guide.Position.Y - 2.9
                    end
                else
                    Y3 = Guide.Position.Y - 2.9
                end

                local Value3
                local Vector32 = Vector3.new( X6, Y3, Along2.Z )
                local LookAt = CFrame.lookAt( Vector32, Vector32 + Along22 )
                local Item = Entry2[ 1 ]
                Item.CFrame = LookAt * CFrame4
                local Item2 = Entry2[ 2 ]
                local Item3 = Entry2[ 3 ]
                local CFrame2Inner = LookAt * Table7[ 1 ][ 2 ]
                local CFrame3Inner = LookAt * Table7[ 2 ][ 2 ]
                Item2.CFrame = CFrame2Inner
                Item3.CFrame = CFrame3Inner
                local Clamp = math.clamp( math.min( Max3, Max - Max3 ) / 1.5, 0, 1 )
                Value3 = nil

                for Key2, Value4 in Entry2, nil, nil do
                    Value4.Transparency = ( 1 - Clamp ) * 0.6
                end
            end
        end
    end

    return
end

local Table9 = { HUDButtons = true, ArmoryOpen = true }
local Table10 = { "Shop", "Wardrobe" }
local Table11 = { }
local Table12 = { }
local Flag4 = false

local function TopCenter()
    local GlobalGui2
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )
    GlobalGui2 = if GlobalGui then GlobalGui:FindFirstChild( "TopCenter" ) else GlobalGui
    return GlobalGui2
end

local function HideHud()
    Flag4 = true

    for Key, Value in Screens.All( PlayerGui ) do
        if Table9[ Value.name ] then
            local IsShown = Screens.IsShown( Value.obj )

            if Table11[ Value.obj ] == nil then
                Table11[ Value.obj ] = IsShown
            end
            if IsShown then
                Table11[ Value.obj ] = true
                local SetShown = Screens.SetShown
                SetShown( Value.obj, false )
            end
        end
    end

    local TopCenter
    local GlobalGui = PlayerGui:FindFirstChild( "GlobalGui" )

    if GlobalGui then
        TopCenter = GlobalGui:FindFirstChild( "TopCenter" )
    else
        TopCenter = GlobalGui
    end
    if TopCenter then
        if Table11[ TopCenter ] == nil then
            Table11[ TopCenter ] = TopCenter.Visible
        end
        if TopCenter.Visible then
            Table11[ TopCenter ] = true
            TopCenter.Visible = false
        end
    end
    if Success and Result and Result.getIcon then
        local Value1 = nil

        for Key2, Value2 in Table10, nil, nil do
            local Icon = Result.getIcon( Value2 )

            if Icon then
                if Table12[ Icon ] == nil then
                    local Flag = Icon.isEnabled ~= false and true or false
                    Table12[ Icon ] = Flag
                end
                if Icon.isEnabled ~= false then
                    Icon:setEnabled( false )
                end
            end
        end
    end
end

local function RestoreHud()
    if not Flag4 then
        return
    end

    local Value1
    Flag4 = false
    Value1 = nil

    for Key, Value in Table11, nil, nil do
        if Key.Parent then
            if not Key:IsA( "GuiObject" ) or Key.Name ~= "TopCenter" then
                Screens.SetShown( Key, Value )
            else
                Key.Visible = Value
            end
        end
    end

    local Value2
    table.clear( Table11 )
    Value2 = nil

    for Key2, Value3 in Table12, nil, nil do
        if Value3 then
            pcall( Key2.setEnabled, Key2, true )
        end
    end

    table.clear( Table12 )
end

local Table13 = {
    function()
        local CaseStations2
        local CaseStations = workspace:FindFirstChild( "CaseStations" )
        CaseStations2 = if CaseStations then CaseStations:FindFirstChild( "AttachmentStation" ) else CaseStations
        return CaseStations2
    end,
    function()
        local Interactions2
        local Interactions = workspace:FindFirstChild( "Interactions" )
        Interactions2 = if Interactions then Interactions else workspace
        return Interactions2:FindFirstChild( "ArmoryStation" )
    end,
    function()
        local Interactions2
        local Table = { }
        local Interactions = workspace:FindFirstChild( "Interactions" )
        Interactions2 = if Interactions then Interactions else workspace

        for Key, Value in Interactions2:GetChildren( ) do
            if Value:GetAttribute( "Stash" ) then
                table.insert( Table, Value )
            end
        end

        return Table
    end
}
local Table14 = { }

local function HideObj( ObjName )
    if Table14[ ObjName ] then
        return
    end
    if ObjName:IsA( "BasePart" ) then
        Table14[ ObjName ] = { "Transparency", ObjName.Transparency }
        ObjName.Transparency = 1
        return
    end
    if ObjName:IsA( "Decal" ) or ObjName:IsA( "Texture" ) then
        Table14[ ObjName ] = { "Transparency", ObjName.Transparency }
        ObjName.Transparency = 1
        return
    end
    if ObjName:IsA( "ParticleEmitter" ) or ObjName:IsA( "Beam" ) or ObjName:IsA( "Trail" ) or ObjName:IsA( "Light" ) or ObjName:IsA( "LayerCollector" ) or ObjName:IsA( "Highlight" ) then
        Table14[ ObjName ] = { "Enabled", ObjName.Enabled }
        ObjName.Enabled = false
    end
end

local Flag5 = false

local function ApplyHide()
    if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        if Flag5 then
            local Value6
            Flag5 = false
            Value6 = nil

            for Key4, Value7 in Table14, nil, nil do
                if Key4.Parent then
                    pcall( function()
                        Key4[ Value7[ 1 ] ] = Value7[ 2 ]
                    end )
                end
            end

            table.clear( Table14 )
        end

        return
    end
    local Value1
    Flag5 = true
    Value1 = nil

    for Key, Value in Table13, nil, nil do
        local Table
        local Value2 = Value( )

        if typeof( Value2 ) ~= "Instance" or not { Value2 } then
            if type( Value2 ) ~= "table" or not Value2 then
                Table = { }
            else
                Table = Value2
            end
        else
            Table = { Value2 }
        end

        local Value3 = nil

        for Key2, Value4 in Table, nil, nil do
            HideObj( Value4 )

            for Key3, Value5 in Value4:GetDescendants( ) do
                HideObj( Value5 )
            end
        end
    end

    return
end

LocalPlayer:GetAttributeChangedSignal( "InTutorial" ):Connect( ApplyHide )

local function RemoveFondu()
    local Structures
    local Map = workspace:FindFirstChild( "Map" )

    if Map then
        Structures = Map:FindFirstChild( "Structures" )
    else
        Structures = Map
    end
    if Structures then
        Structures = Structures:FindFirstChild( "Structure_004" )
    end
    if Structures then
        Structures = Structures:FindFirstChild( "FonduOut" )
    end
    if Structures then
        Structures.Parent = nil
    end
end

task.spawn( function()
    while true do
        local Structures
        ApplyHide( )
        local Map = workspace:FindFirstChild( "Map" )

        if Map then
            Structures = Map:FindFirstChild( "Structures" )
        else
            Structures = Map
        end
        if Structures then
            Structures = Structures:FindFirstChild( "Structure_004" )
        end
        if Structures then
            Structures = Structures:FindFirstChild( "FonduOut" )
        end
        if Structures then
            Structures.Parent = nil
        end

        task.wait( 1 )
    end
end )
local Flag6 = false
RunService.RenderStepped:Connect( function()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end

    local InTutorial = LocalPlayer:GetAttribute( "InTutorial" )

    if ClientState.IntroCinematic == true then
        Flag6 = true
    elseif Flag6 then
        local FlagInner
        Flag6 = false
        AutoBanner( )

        if LocalPlayer:GetAttribute( "Onboarding" ) == false then
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                FlagInner = false
            elseif ClientState.IntroCinematic == true then
                FlagInner = false
            else
                FlagInner = true
            end
        else
            FlagInner = false
        end
        if FlagInner and LocalPlayer:GetAttribute( "InTutorial" ) and not Flag3 then
            Flag3 = true
            task.delay( 0.25, FaceCamera )
        end
    end
    if InTutorial == nil or ClientState.WardrobeOpen == true then
        if InTutorial == nil then
            RestoreHud( )
        end
    else
        HideHud( )
    end

    local Visible

    if InTutorial == nil then
        Visible = false
    elseif Table2[ InTutorial ] == nil then
        Visible = false
    else
        if LocalPlayer:GetAttribute( "Onboarding" ) == false then
            if LocalPlayer:GetAttribute( "InWardrobe" ) == true then
                Visible = false
            elseif ClientState.IntroCinematic == true then
                Visible = false
            else
                Visible = true
            end
        else
            Visible = false
        end
        if Visible then
            local Flag2 = ClientState.CaseRolling == true and true or false
            Visible = not Flag2
        end
    end
    if Objective.Visible ~= Visible then
        Objective.Visible = Visible
    end
    if Visible and not TutorialGui.Enabled then
        TutorialGui.Enabled = true
    end

    local Table

    if not TutorialGui.Enabled or not HumanoidRootPart then
        Table = { }
    else
        local Targets2 = Targets( HumanoidRootPart )

        if Targets2 then
            Table = Targets2
        else
            Table = { }
        end
    end
    if HumanoidRootPart then
        local Flag4

        if LocalPlayer:GetAttribute( "StashGuide" ) == true then
            local NotCaptured = not Flag

            if NotCaptured then
                local Flag3Inner = ClientState.CaseRolling == true and true or false
                Flag4 = not Flag3Inner
            else
                Flag4 = NotCaptured
            end
        else
            Flag4 = false
        end
        if Flag4 then
            Table = { { SafePos( ), "SAFE" } }

            if not TutorialGui.Enabled then
                TutorialGui.Enabled = true
            end
        end
    end

    local Value2
    local CurrentCamera = workspace.CurrentCamera
    local ViewportSize = CurrentCamera.ViewportSize
    Value2 = nil

    for Key, Value in Table, nil, nil do
        local Entry2
        local Entry = Table5[ Key ]

        if Entry then
            Entry2 = Entry
        else
            local Clone = Pointer:Clone( )
            Clone.Name = "Pointer" .. Key
            Clone.Parent = TutorialGui
            Table5[ Key ] = Clone
            Entry2 = Clone
        end

        local Item = Value[ 1 ]
        Place( Entry2, Item, Value[ 2 ], HumanoidRootPart, CurrentCamera, ViewportSize )
    end

    local Count = #Table + 1
    local Count2 = #Table5
    local I = Count

    for I = Count, Count2 do
        Table5[ I ].Visible = false
    end

    UpdateGuide( HumanoidRootPart )
end )
Refresh( )
