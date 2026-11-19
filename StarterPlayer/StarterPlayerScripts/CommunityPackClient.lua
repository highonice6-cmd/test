-- StarterPlayer.StarterPlayerScripts.CommunityPackClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local TweenService = game:GetService( "TweenService" )
local GroupService = game:GetService( "GroupService" )
local LocalPlayer = Players.LocalPlayer
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Success, Result = pcall( require, ReplicatedStorage:WaitForChild( "Notify", 10 ) )

if not Success then
    Result = nil
end

local Scale
local CommunityPack = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "CommunityPack" )
local CommunityPack2 = LocalPlayer:WaitForChild( "PlayerGui" ):WaitForChild( "CommunityPack", math.huge )
CommunityPack2.Enabled = false
local Window = CommunityPack2:WaitForChild( "Window" )
local Close = Window:WaitForChild( "Close" )
local Ask = Window:WaitForChild( "Ask" )
local Join = Window:WaitForChild( "Join" )
local Claimed = Window:WaitForChild( "Claimed" )
local Yes = Ask:WaitForChild( "Yes" )
local No = Ask:WaitForChild( "No" )
local JoinGroup = Join:WaitForChild( "JoinGroup" )
local Claim = Join:WaitForChild( "Claim" )
local Status = Window:FindFirstChild( "Status" )
local UIScale = Window:FindFirstChildOfClass( "UIScale" )
Scale = UIScale and UIScale.Scale or 1
local UIAspectRatioConstraint2
local FromRGB = Color3.fromRGB( 130, 220, 114 )
local FromRGB2 = Color3.fromRGB( 240, 110, 110 )
local Table = {
    notmember = "Join the community first",
    full = "Your safe is full: free 4 slots and try again",
    claimed = "You already got the Community Pack",
    far = "Stand in the circle",
    loading = "Your data is loading, try again",
    roblox = "Roblox didn't answer, try again",
    wait = ""
}
local UIAspectRatioConstraint = Window:FindFirstChildOfClass( "UIAspectRatioConstraint" )
local Size = Window.Size
UIAspectRatioConstraint2 = if UIAspectRatioConstraint then UIAspectRatioConstraint.AspectRatio else UIAspectRatioConstraint

local function Fit()
    local Y2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Y = CurrentCamera.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 1080
        end
    else
        Y2 = 1080
    end

    local Flag = Y2 < 600 and true or false
    local SizeInner

    if Flag then
        local FromScale = UDim2.fromScale( 0.94, 0.9 )

        if FromScale then
            SizeInner = FromScale
        else
            SizeInner = Size
        end
    else
        SizeInner = Size
    end

    Window.Size = SizeInner

    if UIAspectRatioConstraint then
        local AspectRatio = if Flag then 1.6 else UIAspectRatioConstraint2
        UIAspectRatioConstraint.AspectRatio = AspectRatio
    end
end

local function WatchCam()
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
    end

    local Y2
    local CurrentCamera2 = workspace.CurrentCamera

    if CurrentCamera2 then
        local Y = CurrentCamera2.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 1080
        end
    else
        Y2 = 1080
    end

    local Flag = Y2 < 600 and true or false
    local SizeInner

    if Flag then
        local FromScale = UDim2.fromScale( 0.94, 0.9 )

        if FromScale then
            SizeInner = FromScale
        else
            SizeInner = Size
        end
    else
        SizeInner = Size
    end

    Window.Size = SizeInner

    if UIAspectRatioConstraint then
        local AspectRatio = if Flag then 1.6 else UIAspectRatioConstraint2
        UIAspectRatioConstraint.AspectRatio = AspectRatio
    end
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( WatchCam )
local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Fit )
end

local Y2
local CurrentCamera2 = workspace.CurrentCamera

if CurrentCamera2 then
    local Y = CurrentCamera2.ViewportSize.Y

    if Y then
        Y2 = Y
    else
        Y2 = 1080
    end
else
    Y2 = 1080
end

local Flag = Y2 < 600 and true or false
local Size2

if Flag then
    local FromScale = UDim2.fromScale( 0.94, 0.9 )

    if FromScale then
        Size2 = FromScale
    else
        Size2 = Size
    end
else
    Size2 = Size
end

Window.Size = Size2

if UIAspectRatioConstraint then
    local AspectRatio = if Flag then 1.6 else UIAspectRatioConstraint2
    UIAspectRatioConstraint.AspectRatio = AspectRatio
end

local Flag2 = false
local Flag3 = false
local Flag4 = false
local Flag5 = false
local Value1 = nil

local function Msg( Text, Argument2 )
    if not Status then
        return
    end

    local TextColor3 = Argument2 and FromRGB or FromRGB2
    Status.TextColor3 = TextColor3
    Status.Text = Text
    task.delay( 3, function()
        if Status.Text == Text then
            Status.Text = ""
        end
    end )
end

local function Fail( Key )
    local Entry = Table[ Key ]

    if Entry == "" then
        return
    end

    local Text = Entry or "Something went wrong, try again"

    if Result and Result.Error then
        Result.Error( Text )
        return
    end
    if Status then
        Status.TextColor3 = FromRGB2
        Status.Text = Text
        task.delay( 3, function()
            if Status.Text == Text then
                Status.Text = ""
            end
        end )
        return
    end
    return
end

local function Show( Name )
    local Visible = Name == "ask" and true or false
    local Visible2
    Ask.Visible = Visible
    Visible2 = Name == "join" and true or false
    local Visible3
    Join.Visible = Visible2
    Visible3 = Name == "claimed" and true or false
    local Captured
    Claimed.Visible = Visible3
    local Refresh = GamepadNav.Refresh

    if Name ~= "ask" or not Yes then
        if Name ~= "join" or not JoinGroup then
            Captured = Close
        else
            Captured = JoinGroup
        end
    else
        Captured = Yes
    end

    Refresh( "CommunityPack", Captured )
end

local function Claim2()
    if Flag4 or Flag5 then
        return
    end

    Flag4 = true
    local Success, ResultInner = pcall( CommunityPack.InvokeServer, CommunityPack, "claim" )
    Flag4 = false

    if not Success or type( ResultInner ) ~= "table" or not ResultInner.ok then
        local Err = Success and type( ResultInner ) == "table" and ResultInner.err or nil
        local Entry = Table[ Err ]

        if Entry ~= "" then
            local Text2 = Entry or "Something went wrong, try again"

            if not Result or not Result.Error then
                if Status then
                    Status.TextColor3 = FromRGB2
                    Status.Text = Text2
                    task.delay( 3, function()
                        if Status.Text == Text2 then
                            Status.Text = ""
                        end
                    end )
                end
            else
                Result.Error( Text2 )
            end
        end
        if Success and type( ResultInner ) == "table" and ResultInner.err == "claimed" then
            Flag5 = true
            Ask.Visible = false
            Join.Visible = false
            Claimed.Visible = true
            GamepadNav.Refresh( "CommunityPack", Close )
        end

        return
    end
    Flag5 = true

    if Status then
        Status.TextColor3 = FromRGB or FromRGB2
        Status.Text = "Community Pack sent to your safe!"
        local Text = "Community Pack sent to your safe!"
        task.delay( 3, function()
            if Status.Text == Text then
                Status.Text = ""
            end
        end )
    end
    if Result and Result.Announce then
        Result.Announce( "COMMUNITY PACK", "M4, Kevlar, 3 E-Drinks and a Medkit are in your safe", 4 )
    end

    Ask.Visible = false
    Join.Visible = false
    Claimed.Visible = true
    GamepadNav.Refresh( "CommunityPack", Close )
    return
end

local Callback = nil

local function Close2()
    Flag3 = true
    Callback( false )
end

Yes.Activated:Connect( function()
    if Flag2 and not Flag5 then
        Ask.Visible = false
        Join.Visible = true
        Claimed.Visible = false
        local Refresh = GamepadNav.Refresh
        Refresh( "CommunityPack", JoinGroup or Close )
    end
end )
No.Activated:Connect( Close2 )
Close.Activated:Connect( Close2 )
Claim.Activated:Connect( Claim2 )
JoinGroup.Activated:Connect( function()
    if Flag4 or Flag5 or not Value1 then
        return
    end

    local Success, Result = pcall( GroupService.PromptJoinAsync, GroupService, Value1 )

    if Success then
        if Result == Enum.GroupMembershipStatus.Joined or Result == Enum.GroupMembershipStatus.AlreadyMember then
            Claim2( )
            return
        end
    end
    if Success and Result == Enum.GroupMembershipStatus.JoinRequestPending then
        if not Status then
            return
        end

        Status.TextColor3 = FromRGB2
        Status.Text = "Join request sent: claim the pack once accepted"
        local Text = "Join request sent: claim the pack once accepted"
        task.delay( 3, function()
            if Status.Text == Text then
                Status.Text = ""
            end
        end )
    end
end )

Callback = function( Enabled )
    if Flag2 == Enabled then
        return
    end

    Flag2 = Enabled
    CommunityPack2.Enabled = Enabled

    if not Enabled then
        GamepadNav.Close( "CommunityPack" )
        return
    end
    if Status then
        Status.Text = ""
    end

    local Text = not Flag5 and "ask" or "claimed"
    local Visible = Text == "ask" and true or false
    local Visible2
    Ask.Visible = Visible
    Visible2 = Text == "join" and true or false
    local Visible3
    Join.Visible = Visible2
    Visible3 = Text == "claimed" and true or false
    local Captured
    Claimed.Visible = Visible3
    local Refresh = GamepadNav.Refresh

    if Text ~= "ask" or not Yes then
        if Text ~= "join" or not JoinGroup then
            Captured = Close
        else
            Captured = JoinGroup
        end
    else
        Captured = Yes
    end

    Refresh( "CommunityPack", Captured )
    task.spawn( function()
        local Success, Result = pcall( CommunityPack.InvokeServer, CommunityPack, "state" )

        if Success and type( Result ) == "table" then
            Value1 = Result.groupId

            if Result.claimed and not Flag5 then
                Flag5 = true

                if Flag2 then
                    Ask.Visible = false
                    Join.Visible = false
                    Claimed.Visible = true
                    GamepadNav.Refresh( "CommunityPack", Close )
                end
            end
        end
    end )

    if UIScale then
        UIScale.Scale = 0.92 * Scale
        TweenService:Create( UIScale, TweenInfo.new( 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Scale } ):Play( )
    end

    GamepadNav.Open( "CommunityPack", {
        root = CommunityPack2,
        first = function()
            local Captured = Flag5 and Close or Yes
            return Captured
        end,
        freeze = false,
        backLabel = "Close",
        onBack = Close2
    } )
end

local Table2 = { }

local function AddCircle( Circle )
    if Circle:GetAttribute( "CommunityPack" ) and Circle:IsA( "PVInstance" ) and not table.find( Table2, Circle ) then
        table.insert( Table2, Circle )
    end
end

for Key, Value in workspace:WaitForChild( "Interactions" ):GetChildren( ) do
    if Value:GetAttribute( "CommunityPack" ) and Value:IsA( "PVInstance" ) and not table.find( Table2, Value ) then
        table.insert( Table2, Value )
    end
end

workspace:WaitForChild( "Interactions" ).ChildAdded:Connect( AddCircle )
workspace:WaitForChild( "Interactions" ).ChildRemoved:Connect( function( Argument1 )
    local Find = table.find( Table2, Argument1 )

    if Find then
        table.remove( Table2, Find )
    end
end )

local function InCircle()
    local HumanoidRootPart
    local Character = LocalPlayer.Character

    if Character then
        HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character
    end
    if not HumanoidRootPart or Character:GetAttribute( "Downed" ) then
        return false
    end

    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        local Position = HumanoidRootPart.Position - Value:GetPivot( ).Position
        local X = Position.X

        if Vector3.new( X, 0, Position.Z ).Magnitude <= 3.8 then
            if math.abs( Position.Y ) < 6 then
                return true
            end
        end
    end

    return false
end

task.spawn( function()
    while true do
        task.wait( 0.2 )
        local InCircle2 = InCircle( )

        if not InCircle2 then
            Flag3 = false
        end

        local NotCaptured = if InCircle2 then not Flag3 else InCircle2
        Callback( NotCaptured )
    end
end )
