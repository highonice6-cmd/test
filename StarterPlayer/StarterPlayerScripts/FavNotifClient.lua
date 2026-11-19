-- StarterPlayer.StarterPlayerScripts.FavNotifClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local UserInputService = game:GetService( "UserInputService" )
local RunService = game:GetService( "RunService" )
local AvatarEditorService = game:GetService( "AvatarEditorService" )
local ExperienceNotificationService = game:GetService( "ExperienceNotificationService" )
local LocalPlayer = Players.LocalPlayer
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local AskPrompt = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "AskPrompt" )
local Number = -math.huge
LocalPlayer:GetAttributeChangedSignal( "CombatUntil" ):Connect( function()
    Number = os.clock( )
end )

local function Calm()
    if ClientState.Combat or ClientState.Aiming then
        Number = os.clock( )
        return false
    end

    local CombatUntil = LocalPlayer:GetAttribute( "CombatUntil" )

    if type( CombatUntil ) == "number" and workspace:GetServerTimeNow( ) < CombatUntil then
        Number = os.clock( )
        return false
    end
    if os.clock( ) - Number < 20 then
        return false
    end
    if workspace:GetAttribute( "RankedMatch" ) then
        return false
    end
    if LocalPlayer:GetAttribute( "InTutorial" ) or LocalPlayer:GetAttribute( "Onboarding" ) == true or LocalPlayer:GetAttribute( "InWardrobe" ) == true then
        return false
    end
    if LocalPlayer:GetAttribute( "StarterOffer" ) or LocalPlayer:GetAttribute( "ServerMoving" ) then
        return false
    end
    if ClientState.WardrobeOpen or ClientState.CaseRolling or ClientState.BetaReveal or ClientState.ServerMove or ClientState.CursorFree then
        return false
    end

    local Humanoid
    local Character = LocalPlayer.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 then
        return false
    end
    if Character:GetAttribute( "Downed" ) or Character:GetAttribute( "CarriedBy" ) or Character:GetAttribute( "Carrying" ) then
        return false
    end
    if not Humanoid.SeatPart or not Humanoid.SeatPart:IsA( "VehicleSeat" ) then
        return true
    end
    return false
end

local function AskFav()
    local GetFavoriteAsync = AvatarEditorService.GetFavoriteAsync
    local Success, Result = pcall( GetFavoriteAsync, AvatarEditorService, game.PlaceId, Enum.AvatarItemType.Asset )

    if Success and Result == true then
        return "already"
    end

    local Flag = false
    local Value1 = nil
    local Connect = AvatarEditorService.PromptSetFavoriteCompleted:Connect( function( Argument1 )
        Flag = true
        Value1 = Argument1
    end )
    local PromptSetFavorite = AvatarEditorService.PromptSetFavorite

    if not pcall( PromptSetFavorite, AvatarEditorService, game.PlaceId, Enum.AvatarItemType.Asset, true ) then
        Connect:Disconnect( )
        return "failed"
    end

    local Clock = os.clock( )

    while not Flag do
        if not ( os.clock( ) - Clock < 90 ) then
            break
        end

        task.wait( 0.25 )
    end

    Connect:Disconnect( )

    if not Flag then
        return "timeout"
    end
    if Value1 == Enum.AvatarPromptResult.Success then
        return "accepted"
    end
    if Value1 == Enum.AvatarPromptResult.PermissionDenied then
        return "declined"
    end
    return "failed"
end

local function AskNotif()
    local Success, Result = pcall( ExperienceNotificationService.CanPromptOptInAsync, ExperienceNotificationService )

    if not Success then
        return "failed"
    end
    if not Result then
        return "unavailable"
    end

    local Flag = false
    local Connect = ExperienceNotificationService.OptInPromptClosed:Connect( function()
        Flag = true
    end )

    if not pcall( ExperienceNotificationService.PromptOptIn, ExperienceNotificationService ) then
        Connect:Disconnect( )
        return "failed"
    end

    local Clock = os.clock( )

    while not Flag do
        if not ( os.clock( ) - Clock < 90 ) then
            break
        end

        task.wait( 0.25 )
    end

    local Text
    Connect:Disconnect( )
    Text = not Flag and "timeout" or "closed"
    return Text
end

local Flag = false

local function Run()
    if Flag then
        return
    end

    local AskPromptInner = LocalPlayer:GetAttribute( "AskPrompt" )

    if AskPromptInner == "fav" or AskPromptInner == "notif" then
        Flag = true
        task.spawn( function()
            local Clock = nil

            while LocalPlayer:GetAttribute( "AskPrompt" ) == AskPromptInner do
                if Calm( ) then
                    local Clock2

                    if Clock then
                        Clock2 = Clock
                    else
                        Clock2 = os.clock( )
                    end
                    if os.clock( ) - Clock2 >= 4 then
                        break
                    end

                    Clock = Clock2
                else
                    Clock = nil
                end

                task.wait( 0.5 )
            end
            if LocalPlayer:GetAttribute( "AskPrompt" ) == AskPromptInner then
                local MouseEnabled2
                local LastInputType = UserInputService:GetLastInputType( )
                local MouseEnabled = UserInputService.MouseEnabled

                if MouseEnabled then
                    if LastInputType == Enum.UserInputType.Keyboard then
                        MouseEnabled2 = true
                    elseif LastInputType.Name:sub( 1, 5 ) == "Mouse" then
                        MouseEnabled2 = true
                    else
                        MouseEnabled2 = false
                    end
                else
                    MouseEnabled2 = MouseEnabled
                end

                local MouseEnabled3

                if MouseEnabled2 then
                    local NotIsStudio = not RunService:IsStudio( )

                    if NotIsStudio then
                        MouseEnabled3 = not ClientState.CursorFree
                    else
                        MouseEnabled3 = NotIsStudio
                    end
                else
                    MouseEnabled3 = MouseEnabled2
                end
                if MouseEnabled3 then
                    ClientState.CursorFree = true
                end

                local Success, Result = pcall( function()
                    local AskNotif2

                    if AskPromptInner == "fav" then
                        local AskFav2 = AskFav( )

                        if AskFav2 then
                            Value2 = AskFav2
                        else
                            AskNotif2 = AskNotif( )
                        end
                    else
                        AskNotif2 = AskNotif( )
                    end

                    return Value2
                end )

                if MouseEnabled3 then
                    ClientState.CursorFree = false
                end

                local Result2 = Success and Result or "failed"
                AskPrompt:FireServer( AskPromptInner, Result2 )
            end

            Flag = false
            task.defer( Run )
        end )
        return
    end
    return
end

LocalPlayer:GetAttributeChangedSignal( "AskPrompt" ):Connect( Run )

if not Flag then
    local AskPrompt2 = LocalPlayer:GetAttribute( "AskPrompt" )

    if AskPrompt2 == "fav" or AskPrompt2 == "notif" then
        Flag = true
        task.spawn( function()
            local Clock = nil

            while LocalPlayer:GetAttribute( "AskPrompt" ) == AskPrompt2 do
                if Calm( ) then
                    local Clock2

                    if Clock then
                        Clock2 = Clock
                    else
                        Clock2 = os.clock( )
                    end
                    if os.clock( ) - Clock2 >= 4 then
                        break
                    end

                    Clock = Clock2
                else
                    Clock = nil
                end

                task.wait( 0.5 )
            end
            if LocalPlayer:GetAttribute( "AskPrompt" ) == AskPrompt2 then
                local MouseEnabled2
                local LastInputType = UserInputService:GetLastInputType( )
                local MouseEnabled = UserInputService.MouseEnabled

                if MouseEnabled then
                    if LastInputType == Enum.UserInputType.Keyboard then
                        MouseEnabled2 = true
                    elseif LastInputType.Name:sub( 1, 5 ) == "Mouse" then
                        MouseEnabled2 = true
                    else
                        MouseEnabled2 = false
                    end
                else
                    MouseEnabled2 = MouseEnabled
                end

                local MouseEnabled3

                if MouseEnabled2 then
                    local NotIsStudio = not RunService:IsStudio( )

                    if NotIsStudio then
                        MouseEnabled3 = not ClientState.CursorFree
                    else
                        MouseEnabled3 = NotIsStudio
                    end
                else
                    MouseEnabled3 = MouseEnabled2
                end
                if MouseEnabled3 then
                    ClientState.CursorFree = true
                end

                local Success, Result = pcall( function()
                    local AskNotif2

                    if AskPrompt2 == "fav" then
                        local AskFav2 = AskFav( )

                        if AskFav2 then
                            Value2 = AskFav2
                        else
                            AskNotif2 = AskNotif( )
                        end
                    else
                        AskNotif2 = AskNotif( )
                    end

                    return Value2
                end )

                if MouseEnabled3 then
                    ClientState.CursorFree = false
                end

                local Result2 = Success and Result or "failed"
                AskPrompt:FireServer( AskPrompt2, Result2 )
            end

            Flag = false
            task.defer( Run )
        end )
    end
end
