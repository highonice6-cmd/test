-- Players.perkbrokeyou.PlayerGui.SafeZoneHUD.SafeZoneClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local SafeZone = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "SafeZone" ) )
local FarmZone = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "FarmZone" ) )
local SpawnShield = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "SpawnShield" ) )
local LocalPlayer = Players.LocalPlayer
local Banner = script.Parent:WaitForChild( "Banner" )
local UIScale = Banner:WaitForChild( "UIScale" )
local UIStroke = Banner:WaitForChild( "UIStroke" )
local Text = Banner:WaitForChild( "Text" )
local Dot = Banner:WaitForChild( "Dot" )
local Table = {
    bg = Banner.BackgroundTransparency,
    stroke = UIStroke.Transparency,
    text = Text.TextTransparency,
    dot = Dot.BackgroundTransparency
}
local Table2 = {
    text = Text.TextColor3,
    accent = Dot.BackgroundColor3,
    label = Text.Text
}
local Table3 = {
    text = Color3.fromRGB( 255, 190, 80 ),
    accent = Color3.fromRGB( 255, 160, 40 )
}
local TweenInfo2 = TweenInfo.new( 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out )
local FromRGB = Color3.fromRGB( 60, 255, 110 )
local Flag = false

local function Show( Argument1 )
    if Argument1 == Flag then
        return
    end

    Flag = Argument1

    if Argument1 then
        Banner.Visible = true
        Banner.BackgroundTransparency = 1
        UIStroke.Transparency = 1
        Text.TextTransparency = 1
        Dot.BackgroundTransparency = 1
        UIScale.Scale = 0.85
        TweenService:Create( Banner, TweenInfo2, { BackgroundTransparency = Table.bg } ):Play( )
        TweenService:Create( UIStroke, TweenInfo2, { Transparency = Table.stroke } ):Play( )
        TweenService:Create( Text, TweenInfo2, { TextTransparency = Table.text } ):Play( )
        TweenService:Create( Dot, TweenInfo2, { BackgroundTransparency = Table.dot } ):Play( )
        TweenService:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Back ), { Scale = 1 } ):Play( )
        return
    end
    TweenService:Create( Banner, TweenInfo2, { BackgroundTransparency = 1 } ):Play( )
    TweenService:Create( UIStroke, TweenInfo2, { Transparency = 1 } ):Play( )
    TweenService:Create( Dot, TweenInfo2, { BackgroundTransparency = 1 } ):Play( )
    local Create = TweenService:Create( Text, TweenInfo2, { TextTransparency = 1 } )
    Create.Completed:Connect( function()
        if not Flag then
            Banner.Visible = false
        end
    end )
    Create:Play( )
    return
end

local Value1 = nil

local function SetMode( ModeName, Argument2 )
    if ModeName == "wait" then
        local TextInner = string.format( "SAFE IN %.1fs", ( math.max( Argument2, 0 ) ) )

        if Text.Text ~= TextInner then
            Text.Text = TextInner
        end
    end
    if ModeName == Value1 then
        return
    end

    Value1 = ModeName

    if ModeName == "safe" then
        Text.Text = Table2.label
        TweenService:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Back ), { Scale = 1 } ):Play( )

        if Flag then
            UIScale.Scale = 1.12
        end
    end

    local Captured = ModeName == "wait" and Table3 or Table2
    local TextColor3 = Captured.text
    local Color = Captured.accent
    local BackgroundColor3 = Captured.accent
    Text.TextColor3 = TextColor3
    UIStroke.Color = Color
    Dot.BackgroundColor3 = BackgroundColor3
end

local Class = setmetatable( { }, { __mode = "k" } )
local CrewShared = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "CrewShared" ) )

local function SkinOutline( Object, Enabled )
    local SkinHighlight = Object:FindFirstChild( "SkinHighlight" )

    if SkinHighlight and SkinHighlight:IsA( "Highlight" ) and SkinHighlight.Enabled ~= Enabled then
        SkinHighlight.Enabled = Enabled
    end
end

local function SkinDist( Object )
    local CurrentCamera = workspace.CurrentCamera
    local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

    if not CurrentCamera or not HumanoidRootPart then
        return 0
    end
    return ( HumanoidRootPart.Position - CurrentCamera.CFrame.Position ).Magnitude * math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )
end

local function SkinAuto( Self )
    local SkinHighlight = Self:FindFirstChild( "SkinHighlight" )

    if not SkinHighlight or not SkinHighlight:IsA( "Highlight" ) then
        return
    end

    local Number
    local CurrentCamera = workspace.CurrentCamera
    local HumanoidRootPart = Self:FindFirstChild( "HumanoidRootPart" )
    Number = ( not CurrentCamera or not HumanoidRootPart ) and 0 or ( HumanoidRootPart.Position - CurrentCamera.CFrame.Position ).Magnitude * math.clamp( CurrentCamera.FieldOfView / 70, 0.05, 1 )
    local Enabled = Number <= 300 and true or false

    if SkinHighlight.Enabled ~= Enabled then
        SkinHighlight.Enabled = Enabled
    end
    if not Enabled then
        return
    end

    local Number2 = tonumber( script:GetAttribute( "SkinFonduDebut" ) ) or 45
    local Number3 = tonumber( script:GetAttribute( "SkinFonduFin" ) ) or 90
    local Number4 = tonumber( script:GetAttribute( "SkinLoinTransparence" ) ) or 0.78
    local OutlineTransparency = math.clamp( ( Number - Number2 ) / math.max( 1, Number3 - Number2 ), 0, 1 ) * Number4

    if math.abs( SkinHighlight.OutlineTransparency - OutlineTransparency ) > 0.01 then
        SkinHighlight.OutlineTransparency = OutlineTransparency
    end
end

local function Outline( Parent, Argument2, Argument3 )
    if Parent.Parent == nil then
        Class[ Parent ] = nil
        return
    end

    local Entry2
    local Entry = Class[ Parent ]

    if not Entry or Entry.Parent == Parent then
        Entry2 = Entry
    else
        Class[ Parent ] = nil
        Entry2 = nil
    end
    if Argument2 and Parent:FindFirstChild( "SkinHighlight" ) and Parent:FindFirstChild( "SkinHighlight" ):IsA( "Highlight" ) and Parent:FindFirstChild( "SkinHighlight" ).Enabled ~= false then
        Parent:FindFirstChild( "SkinHighlight" ).Enabled = false
    end
    if Entry2 and Argument2 then
        local DepthMode
        DepthMode = Argument3 and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded

        if Entry2.DepthMode ~= DepthMode then
            Entry2.DepthMode = DepthMode
        end

        local Value1 = nil

        for Key, Value in Parent:GetChildren( ) do
            if Value:IsA( "Highlight" ) then
                Value1 = Value
            end
        end
        if Value1 ~= Entry2 then
            Entry2.Parent = nil
            Entry2.Parent = Parent
        end
    end
    if not Argument2 or Entry2 then
        if Argument2 or not Entry2 then
            if not Argument2 then
                SkinAuto( Parent )
            end
        else
            Class[ Parent ] = nil
            local Create = TweenService:Create( Entry2, TweenInfo2, { OutlineTransparency = 1 } )
            Create.Completed:Connect( function()
                Entry2:Destroy( )

                if not Class[ Parent ] then
                    SkinAuto( Parent )
                end
            end )
            Create:Play( )
        end
    else
        local DepthMode2
        local Highlight = Instance.new( "Highlight" )
        Highlight.Name = "SafeZoneOutline"
        Highlight.Adornee = Parent
        Highlight.FillTransparency = 1
        Highlight.OutlineColor = FromRGB
        Highlight.OutlineTransparency = 1
        DepthMode2 = Argument3 and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        Highlight.DepthMode = DepthMode2
        game:GetService( "CollectionService" ):AddTag( Highlight, "OwnFX" )
        Highlight.Parent = Parent
        Class[ Parent ] = Highlight
        TweenService:Create( Highlight, TweenInfo2, { OutlineTransparency = 0 } ):Play( )
    end
end

local Flag2 = false
local Number = -math.huge
local Value2 = nil
local Flag3 = false
local Number2 = -math.huge
local Number3 = 0.1

local function ServerWait( Object, Attribute )
    local Attribute4
    local Attribute2 = Object:GetAttribute( Attribute )

    if type( Attribute2 ) == "number" then
        local Attribute3 = Attribute2 - workspace:GetServerTimeNow( )

        if Attribute3 then
            Attribute4 = Attribute3
        else
            Attribute4 = 0
        end
    else
        Attribute4 = 0
    end

    return Attribute4
end

local Value3 = nil
RunService.Heartbeat:Connect( function( Argument1 )
    local Clock = os.clock( )
    local Character = LocalPlayer.Character

    if Character ~= Value2 then
        Value2 = Character
        Flag2 = false
        Number = -math.huge
        Flag3 = false
        Number2 = -math.huge
        Value3 = nil
    end

    local IsIn

    if Character == nil then
        IsIn = false
    else
        IsIn = SafeZone.IsIn( Character )
    end
    if Flag2 and not IsIn then
        Number = Clock
    end

    local SafeAt3
    Flag2 = IsIn
    local COOLDOWN = SafeZone.COOLDOWN - ( Clock - Number )

    if Character then
        local SafeAt = Character:GetAttribute( "SafeAt" )

        if type( SafeAt ) == "number" then
            local SafeAt2 = SafeAt - workspace:GetServerTimeNow( )

            if SafeAt2 then
                SafeAt3 = SafeAt2
            else
                SafeAt3 = 0
            end
        else
            SafeAt3 = 0
        end
        if not SafeAt3 then
            SafeAt3 = 0
        end
    else
        SafeAt3 = 0
    end

    local Flag
    local Max = math.max( COOLDOWN, SafeAt3 )

    if IsIn then
        if Max <= 0 then
            if Character:GetAttribute( "InSafeZone" ) == true then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = IsIn
    end

    local IsIn2

    if Character == nil then
        IsIn2 = false
    else
        IsIn2 = FarmZone.IsIn( Character )
    end
    if Flag3 and not IsIn2 then
        Number2 = Clock
    end

    local Max2
    Flag3 = IsIn2

    if LocalPlayer:GetAttribute( "InTutorial" ) == nil then
        local FarmSafeAt3
        local COOLDOWN2 = FarmZone.COOLDOWN - ( Clock - Number2 )

        if Character then
            local FarmSafeAt = Character:GetAttribute( "FarmSafeAt" )

            if type( FarmSafeAt ) == "number" then
                local FarmSafeAt2 = FarmSafeAt - workspace:GetServerTimeNow( )

                if FarmSafeAt2 then
                    FarmSafeAt3 = FarmSafeAt2
                else
                    FarmSafeAt3 = 0
                end
            else
                FarmSafeAt3 = 0
            end
            if not FarmSafeAt3 then
                FarmSafeAt3 = 0
            end
        else
            FarmSafeAt3 = 0
        end

        Max2 = math.max( COOLDOWN2, FarmSafeAt3 )
    else
        Max2 = 0
    end

    local Flag3Inner

    if IsIn2 then
        if Max2 <= 0 then
            if Character:GetAttribute( "PvPSafe" ) == true then
                Flag3Inner = true
            else
                Flag3Inner = false
            end
        else
            Flag3Inner = false
        end
    else
        Flag3Inner = IsIn2
    end
    if IsIn then
        if Flag then
            SetMode( "safe" )
        elseif Max > 0 then
            local TextInner = string.format( "SAFE IN %.1fs", ( math.max( Max, 0 ) ) )

            if Text.Text ~= TextInner then
                Text.Text = TextInner
            end
            if Value1 ~= "wait" then
                Value1 = "wait"
                local TextColor3 = ( Table3 or Table2 ).text
                local Color = ( Table3 or Table2 ).accent
                local BackgroundColor3 = ( Table3 or Table2 ).accent
                Text.TextColor3 = TextColor3
                UIStroke.Color = Color
                Dot.BackgroundColor3 = BackgroundColor3
            end
        end

        local Flag2Inner

        if Flag then
            Flag2Inner = Flag
        elseif Max > 0 then
            Flag2Inner = true
        else
            Flag2Inner = false
        end

        Show( Flag2Inner )
    elseif IsIn2 then
        if Flag3Inner then
            SetMode( "safe" )
        elseif Max2 > 0 then
            local Text2 = string.format( "SAFE IN %.1fs", ( math.max( Max2, 0 ) ) )

            if Text.Text ~= Text2 then
                Text.Text = Text2
            end
            if Value1 ~= "wait" then
                Value1 = "wait"
                local TextColor32 = ( Table3 or Table2 ).text
                local Color2 = ( Table3 or Table2 ).accent
                local BackgroundColor32 = ( Table3 or Table2 ).accent
                Text.TextColor3 = TextColor32
                UIStroke.Color = Color2
                Dot.BackgroundColor3 = BackgroundColor32
            end
        end

        local Flag4

        if Flag3Inner then
            Flag4 = Flag3Inner
        elseif Max2 > 0 then
            Flag4 = true
        else
            Flag4 = false
        end

        Show( Flag4 )
    else
        Show( false )
    end

    local Active

    if Character == nil then
        Active = false
    elseif Flag then
        Active = Flag
    elseif Flag3Inner then
        Active = Flag3Inner
    else
        Active = SpawnShield.Active( Character )
    end

    Number3 = Number3 + Argument1

    if Character then
        if Active ~= Value3 or Number3 >= 0.1 then
            Value3 = Active
            Outline( Character, Active )
        end
    end
    if Number3 < 0.1 then
        return
    end

    local Flag9
    Number3 = 0
    Flag9 = LocalPlayer:GetAttribute( "InTutorial" ) ~= nil and true or false

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer and Value.Character then
            local Humanoid2
            local Same = CrewShared.Same( LocalPlayer, Value )

            if Same then
                Humanoid2 = Value.Character:FindFirstChildOfClass( "Humanoid" )
            else
                Humanoid2 = Same
            end

            local Same2

            if Same then
                if Humanoid2 == nil then
                    Same2 = false
                elseif Humanoid2.Health > 0 then
                    Same2 = true
                else
                    Same2 = false
                end
            else
                Same2 = Same
            end

            local Flag7
            local Character2 = Value.Character

            if Character2:GetAttribute( "InFarmZone" ) == true then
                if Character2:GetAttribute( "PvPSafe" ) == true then
                    Flag7 = true
                else
                    Flag7 = false
                end
            else
                Flag7 = false
            end

            local Flag8

            if Flag9 then
                Flag8 = Flag9
            elseif Value:GetAttribute( "InTutorial" ) == nil then
                Flag8 = false
            else
                Flag8 = true
            end

            local Same3

            if Same2 then
                Same3 = Same2
            elseif Character2:GetAttribute( "InSafeZone" ) == true then
                Same3 = true
            elseif Flag7 then
                Same3 = Flag7
            else
                local Active2 = SpawnShield.Active( Character2 )

                if Active2 then
                    Same3 = Active2
                else
                    Same3 = Flag8
                end
            end

            Outline( Character2, Same3, Same2 )
        end
    end

    local Dummies
    local RankedTeam = LocalPlayer:GetAttribute( "RankedTeam" )

    if RankedTeam then
        local RankedMatch = workspace:GetAttribute( "RankedMatch" )

        if RankedMatch then
            Dummies = workspace:FindFirstChild( "Dummies" )
        else
            Dummies = RankedMatch
        end
    else
        Dummies = RankedTeam
    end

    local Children = Dummies and Dummies:GetChildren( ) or { }
    local Value1Inner = nil

    for Key2, Value2Inner in Children, nil, nil do
        if Value2Inner:IsA( "Model" ) and Value2Inner:GetAttribute( "RankedTeam" ) ~= nil and not Players:GetPlayerFromCharacter( Value2Inner ) then
            local Flag5
            local Humanoid = Value2Inner:FindFirstChildOfClass( "Humanoid" )

            if Value2Inner:GetAttribute( "RankedTeam" ) == RankedTeam then
                if Humanoid == nil then
                    Flag5 = false
                elseif Humanoid.Health > 0 then
                    Flag5 = true
                else
                    Flag5 = false
                end
            else
                Flag5 = false
            end

            local Flag6

            if Flag5 then
                Flag6 = Flag5
            elseif Value2Inner:GetAttribute( "InSafeZone" ) == true then
                Flag6 = true
            else
                Flag6 = false
            end

            Outline( Value2Inner, Flag6, Flag5 )
        end
    end
end )
