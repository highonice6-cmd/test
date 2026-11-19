-- Players.perkbrokeyou.PlayerScripts.TitleScreenClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #63

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Enum.PlaybackState.Completed and Upvalue1.Parent and Upvalue1:GetAttribute( "Resumed" ) ~= true then
    Upvalue1:Pause( )
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local TitleMusic = game:GetService( "SoundService" ):FindFirstChild( "TitleMusic" )

if not TitleMusic then
    return
end
if TitleMusic:GetAttribute( "BaseVolume" ) == nil then
    TitleMusic:SetAttribute( "BaseVolume", TitleMusic.Volume )
end

local Create = Upvalue1:Create( TitleMusic, TweenInfo.new( Amount or 1.2 ), { Volume = 0 } )
Create:Play( )
Create.Completed:Connect( function( Argument1 )
    if Argument1 == Enum.PlaybackState.Completed and TitleMusic.Parent and TitleMusic:GetAttribute( "Resumed" ) ~= true then
        TitleMusic:Pause( )
    end
end )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while Upvalue1:GetAttribute( "LoadingReady" ) ~= true do
    if not ( os.clock( ) - Clock < 150 ) then
        break
    end

    task.wait( 0.1 )
end

Upvalue2( )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute3
local Attribute2 = Upvalue1:GetAttribute( Attribute )
Attribute3 = type( Attribute2 ) == "string" and Attribute2 or Argument2
return Attribute3
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local PreloadAsync = game:GetService( "ContentProvider" ).PreloadAsync
pcall( PreloadAsync, game:GetService( "ContentProvider" ), { Upvalue1 } )
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local NotCaptured2
local NotCaptured = not Upvalue1

if NotCaptured then
    if Upvalue2 == nil then
        NotCaptured2 = false
    else
        NotCaptured2 = Upvalue2.IsLoaded
    end
else
    NotCaptured2 = NotCaptured
end

return NotCaptured2
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2:WaitForChild( "Remotes" ):WaitForChild( "Vip", 60 )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { Argument1, Argument2 }
Value1 = nil

for Key, Value in Table, nil, nil do
    local RequestStreamAroundAsync = Upvalue1.RequestStreamAroundAsync
    pcall( RequestStreamAroundAsync, Upvalue1, Value.Position + Value.LookVector * 500, 20 )
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local TitleCamera
local Cameras = workspace:WaitForChild( "Cameras", 60 )

if Cameras then
    TitleCamera = Cameras:WaitForChild( "TitleCamera", 60 )
else
    TitleCamera = Cameras
end

local Depart
Upvalue1 = TitleCamera

if TitleCamera then
    Depart = TitleCamera:WaitForChild( "Depart", 30 )
else
    Depart = TitleCamera
end

local Fin

if TitleCamera then
    Fin = TitleCamera:WaitForChild( "Fin", 30 )
else
    Fin = TitleCamera
end
if not Depart or not Fin or not ( ( Depart.Position - Upvalue2.Position ).Magnitude > 1 ) then
    if Depart and Fin then
        local CFrame3 = Depart.CFrame
        local CFrame4 = Fin.CFrame
        Upvalue2 = CFrame3
        Upvalue3 = CFrame4
    end
else
    local CFrame = Depart.CFrame
    local CFrame2 = Fin.CFrame
    Upvalue2 = CFrame
    Upvalue3 = CFrame2

    if Upvalue4 then
        Upvalue5( Upvalue2, Upvalue3 )
        return
    end
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp = math.clamp( Argument1, 0, 1 )
return Clamp * Clamp * ( 3 - 2 * Clamp )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local TextColor3
Upvalue1.Text = Name or ""

if Argument2 == false then
    local FromRGB = Color3.fromRGB( 255, 120, 120 )

    if FromRGB then
        TextColor3 = FromRGB
    else
        TextColor3 = Color3.fromRGB( 235, 235, 240 )
    end
else
    TextColor3 = Color3.fromRGB( 235, 235, 240 )
end

Upvalue1.TextColor3 = TextColor3
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == nil then
    return
end
if Upvalue2.FixedCamera == Upvalue1 then
    Upvalue2.FixedCamera = Upvalue3
    Upvalue2.FixedFOV = Upvalue4
end

Upvalue1 = nil
Upvalue3 = nil
Upvalue4 = nil
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local NotCaptured2
    local NotCaptured = not Upvalue2

    if NotCaptured then
        if Upvalue3 == nil then
            NotCaptured2 = false
        else
            NotCaptured2 = Upvalue3.IsLoaded
        end
    else
        NotCaptured2 = NotCaptured
    end
    if not NotCaptured2 then
        local Number2

        if Upvalue8 then
            local Number = tonumber( Upvalue8:GetAttribute( "Duree" ) )

            if Number then
                Number2 = Number
            else
                Number2 = 32
            end
        else
            Number2 = 32
        end

        local Cos = ( 1 - math.cos( ( os.clock( ) - Upvalue9 ) * 2 * 3.141592653589793 / math.max( Number2, 4 ) ) ) / 2

        if not Upvalue10 then
            Upvalue10 = true
            task.spawn( Upvalue11, Upvalue12, Upvalue13 )
        end
        if Upvalue4 == nil or Upvalue5.FixedCamera ~= Upvalue4 then
            local FixedCamera = Upvalue5.FixedCamera
            local FixedFOV = Upvalue5.FixedFOV
            Upvalue6 = FixedCamera
            Upvalue7 = FixedFOV
        end

        Upvalue4 = Upvalue12:Lerp( Upvalue13, Cos )
        Upvalue5.FixedCamera = Upvalue4
        Upvalue5.FixedFOV = 55
        return
    end
end
if Upvalue4 == nil then
    return
end
if Upvalue5.FixedCamera == Upvalue4 then
    Upvalue5.FixedCamera = Upvalue6
    Upvalue5.FixedFOV = Upvalue7
end

Upvalue4 = nil
Upvalue6 = nil
Upvalue7 = nil
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Number2

if Upvalue2 then
    local Number = tonumber( Upvalue2:GetAttribute( "Duree" ) )

    if Number then
        Number2 = Number
    else
        Number2 = 32
    end
else
    Number2 = 32
end

local Visible
local Cos = ( 1 - math.cos( ( os.clock( ) - Upvalue3 ) * 2 * 3.141592653589793 / math.max( Number2, 4 ) ) ) / 2
local NotCaptured = not Upvalue4

if NotCaptured then
    if Upvalue5 == nil then
        Visible = false
    else
        Visible = Upvalue5.IsLoaded
    end
else
    Visible = NotCaptured
end
if Upvalue5 then
    Upvalue5.Visible = Visible
end
if Visible then
    local Cos2 = Cos * 0.1 + 1.02
    Upvalue5.Size = UDim2.fromScale( Cos2, Cos2 )
    Upvalue5.Position = UDim2.fromScale( 0.5 - Cos * 0.02, Cos * 0.01 + 0.5 )
end
if Upvalue6.Enabled then
    Upvalue6.Enabled = false
end
for Key, Value in Upvalue7:GetChildren( ) do
    if Value ~= Upvalue8 and Value:IsA( "ScreenGui" ) and Value.Enabled and Value.Name ~= "LoadingScreen" and Value.Name ~= "EcranChargement" then
        Upvalue9[ Value ] = true
        Value.Enabled = false
    end
end

Upvalue10.MouseBehavior = Enum.MouseBehavior.Default
Upvalue10.MouseIconEnabled = true
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.inVip then
    local Text
    local Vip_InVip = Upvalue3:GetAttribute( "Vip_InVip" )
    Text = type( Vip_InVip ) == "string" and Vip_InVip or "VIP SERVER"
    local Text2
    Upvalue2.Text = Text
    local Info_InVip = Upvalue3:GetAttribute( "Info_InVip" )
    Text2 = type( Info_InVip ) == "string" and Info_InVip or "You are playing on a VIP server"
    Upvalue4.Text = Text2
    return
end
if not Upvalue1.enabled then
    local Text3
    local Vip_Default = Upvalue3:GetAttribute( "Vip_Default" )
    Text3 = type( Vip_Default ) == "string" and Vip_Default or "VIP SERVERS"
    local Text4
    Upvalue2.Text = Text3
    local Info_Soon = Upvalue3:GetAttribute( "Info_Soon" )
    Text4 = type( Info_Soon ) == "string" and Info_Soon or "Coming soon · Servers for VIP members only"
    Upvalue4.Text = Text4
    return
end
if Upvalue1.sub or Upvalue1.free then
    local Text9
    local Vip_Member = Upvalue3:GetAttribute( "Vip_Member" )
    Text9 = type( Vip_Member ) == "string" and Vip_Member or "JOIN VIP SERVER"
    local Text10
    Upvalue2.Text = Text9

    if Upvalue1.sub then
        local Info_Member = Upvalue3:GetAttribute( "Info_Member" )

        if type( Info_Member ) ~= "string" or not Info_Member then
            Text10 = "Your VIP membership is active"
        else
            Text10 = Info_Member
        end
        if not Text10 then
            local Info_Free = Upvalue3:GetAttribute( "Info_Free" )

            if type( Info_Free ) ~= "string" or not Info_Free then
                Text10 = "VIP server access included"
            else
                Text10 = Info_Free
            end
        end
    else
        local Info_Free = Upvalue3:GetAttribute( "Info_Free" )

        if type( Info_Free ) ~= "string" or not Info_Free then
            Text10 = "VIP server access included"
        else
            Text10 = Info_Free
        end
    end

    Upvalue4.Text = Text10
    return
end
if Upvalue1.pending then
    local Text5
    local Vip_Default2 = Upvalue3:GetAttribute( "Vip_Default" )
    Text5 = type( Vip_Default2 ) == "string" and Vip_Default2 or "VIP SERVERS"
    local Text6
    Upvalue2.Text = Text5
    local Info_Pending = Upvalue3:GetAttribute( "Info_Pending" )
    Text6 = type( Info_Pending ) == "string" and Info_Pending or "Activating your VIP, please wait..."
    Upvalue4.Text = Text6
    return
end
local Text7
local Vip_Default3 = Upvalue3:GetAttribute( "Vip_Default" )
Text7 = type( Vip_Default3 ) == "string" and Vip_Default3 or "VIP SERVERS"
local Text8
Upvalue2.Text = Text7
local Info_Default = Upvalue3:GetAttribute( "Info_Default" )
Text8 = type( Info_Default ) == "string" and Info_Default or "Monthly subscription · Servers for VIP members only"
Upvalue4.Text = Text8
return
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1:GetAttribute( "Returning" ) == true then
    Flag = true
elseif Upvalue2.inVip == true then
    Flag = true
elseif Upvalue2.sub == true then
    Flag = true
elseif Upvalue2.free == true then
    Flag = true
elseif Upvalue1:GetAttribute( "VIP" ) == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Visible

if Upvalue1:GetAttribute( "Returning" ) == true then
    Visible = true
elseif Upvalue2.inVip == true then
    Visible = true
elseif Upvalue2.sub == true then
    Visible = true
elseif Upvalue2.free == true then
    Visible = true
elseif Upvalue1:GetAttribute( "VIP" ) == true then
    Visible = true
else
    Visible = false
end

Upvalue3.Visible = Visible
Upvalue4.Visible = Visible
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return Upvalue2
end

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "status" )

if Success and type( Result ) == "table" then
    local Enabled
    local Table = { }
    Enabled = Result.enabled == true and true or false
    local Sub
    Table.enabled = Enabled
    Sub = Result.sub == true and true or false
    local Free
    Table.sub = Sub
    Free = Result.free == true and true or false
    local InVip
    Table.free = Free
    InVip = Result.inVip == true and true or false
    local Err
    Table.inVip = InVip
    Table.id = Result.id
    Table.price = Result.price
    Err = Result.err == true and true or false
    local Pending2
    Table.err = Err

    if Result.sub == true then
        Pending2 = nil
    else
        local Pending = Upvalue2.pending

        if Pending then
            Pending2 = Pending
        else
            Pending2 = nil
        end
    end

    Table.pending = Pending2
    Upvalue2 = Table
    Upvalue3( )
end

return Upvalue2
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1 and require( Upvalue1 )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local PlayerScripts2
local PlayerScripts = Upvalue1:FindFirstChild( "PlayerScripts" )
PlayerScripts2 = if PlayerScripts then PlayerScripts:FindFirstChild( "PlayerModule" ) else PlayerScripts
local Success, Result = pcall( function()
    return PlayerScripts2 and require( PlayerScripts2 )
end )

if Success and Result and Result.GetControls and Upvalue2 then
    Upvalue3 = Result:GetControls( )
    pcall( Upvalue3.Disable, Upvalue3 )
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

return Enum.ContextActionResult.Sink
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2, TweenInfo.new( 0.45, Enum.EasingStyle.Back ), { Size = Upvalue3 } ):Play( )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2, TweenInfo.new( 0.45, Enum.EasingStyle.Back ), { Size = Upvalue3 } ):Play( )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Enabled and Upvalue2.Parent and Upvalue3.SelectedObject == nil then
    Upvalue3.SelectedObject = Upvalue2
end
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1 = true
Upvalue2.TitleScreen = true
Upvalue3 = os.clock( )
Value1 = nil

for Key, Value in Upvalue4, nil, nil do
    local Success, Result = pcall( Upvalue5.GetCoreGuiEnabled, Upvalue5, Value )

    if Success then
        Upvalue6[ Value ] = Result
        pcall( Upvalue5.SetCoreGuiEnabled, Upvalue5, Value, false )
    end
end

local Visible
task.spawn( function()
    local PlayerScripts2
    local PlayerScripts = Upvalue7:FindFirstChild( "PlayerScripts" )
    PlayerScripts2 = if PlayerScripts then PlayerScripts:FindFirstChild( "PlayerModule" ) else PlayerScripts
    local Success, Result = pcall( function()
        return PlayerScripts2 and require( PlayerScripts2 )
    end )

    if Success and Result and Result.GetControls and Upvalue1 then
        Upvalue8 = Result:GetControls( )
        pcall( Upvalue8.Disable, Upvalue8 )
    end
end )
game:GetService( "ContextActionService" ):BindActionAtPriority( "TitleScreenBlock", function()
    return Enum.ContextActionResult.Sink
end, false, 3000, Enum.PlayerActions.CharacterForward, Enum.PlayerActions.CharacterBackward, Enum.PlayerActions.CharacterLeft, Enum.PlayerActions.CharacterRight, Enum.PlayerActions.CharacterJump, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Z, Enum.KeyCode.Q, Enum.KeyCode.Space )
Upvalue9:BindToRenderStep( "TitleScreenCam", Enum.RenderPriority.Last.Value + 100, Upvalue10 )
Upvalue10( )
Upvalue9:BindToRenderStep( "TitleScreenVue", Enum.RenderPriority.Camera.Value - 1, Upvalue11 )
Upvalue11( )
Upvalue12.Visible = true
Upvalue13.BackgroundTransparency = 1
Upvalue14.Enabled = true
Upvalue15( )

if Upvalue7:GetAttribute( "Returning" ) == true then
    Visible = true
elseif Upvalue16.inVip == true then
    Visible = true
elseif Upvalue16.sub == true then
    Visible = true
elseif Upvalue16.free == true then
    Visible = true
elseif Upvalue7:GetAttribute( "VIP" ) == true then
    Visible = true
else
    Visible = false
end

Upvalue17.Visible = Visible
Upvalue18.Visible = Visible
local Size = Upvalue19.Size
local Size2 = Upvalue17.Size
local Size3 = UDim2.fromScale( 0, 0 )
local Size4 = UDim2.fromScale( 0, 0 )
Upvalue19.Size = Size3
Upvalue17.Size = Size4
task.delay( 0.35, function()
    Upvalue20:Create( Upvalue19, TweenInfo.new( 0.45, Enum.EasingStyle.Back ), { Size = Size } ):Play( )
end )
task.delay( 0.5, function()
    Upvalue20:Create( Upvalue17, TweenInfo.new( 0.45, Enum.EasingStyle.Back ), { Size = Size2 } ):Play( )
end )

if Upvalue21.GamepadEnabled then
    task.delay( 0.4, function()
        if Upvalue14.Enabled and Upvalue19.Parent and Upvalue22.SelectedObject == nil then
            Upvalue22.SelectedObject = Upvalue19
        end
    end )
end

task.spawn( Upvalue23 )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

local Enabled
local NotCaptured = not ( Upvalue2 and Upvalue2:GetAttribute( "Downed" ) )

if NotCaptured then
    if Upvalue3.BetaRollLock == true then
        Enabled = false
    else
        Enabled = true
    end
else
    Enabled = NotCaptured
end

Upvalue1.Enabled = Enabled
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
Upvalue1:UnbindFromRenderStep( "TitleScreenCam" )
Upvalue1:UnbindFromRenderStep( "TitleScreenVue" )
Upvalue2 = false
Value1 = nil

for Value in Upvalue3, nil, nil do
    if Value.Parent then
        Value.Enabled = true
    end
end

local Value2
table.clear( Upvalue3 )
Value2 = nil

for Key, Value3 in Upvalue4, nil, nil do
    pcall( Upvalue5.SetCoreGuiEnabled, Upvalue5, Key, Value3 )
end
if Upvalue6 then
    pcall( Upvalue6.Enable, Upvalue6 )
end

game:GetService( "ContextActionService" ):UnbindAction( "TitleScreenBlock" )

if Upvalue7 ~= nil then
    if Upvalue8.FixedCamera == Upvalue7 then
        Upvalue8.FixedCamera = Upvalue9
        Upvalue8.FixedFOV = Upvalue10
    end

    Upvalue7 = nil
    Upvalue9 = nil
    Upvalue10 = nil
end

local Character = Upvalue11.Character
pcall( function()
    local Enabled
    local NotCaptured = not ( Character and Character:GetAttribute( "Downed" ) )

    if NotCaptured then
        if Upvalue8.BetaRollLock == true then
            Enabled = false
        else
            Enabled = true
        end
    else
        Enabled = NotCaptured
    end

    Upvalue12.Enabled = Enabled
end )

if Upvalue13.SelectedObject and Upvalue13.SelectedObject:IsDescendantOf( Upvalue14 ) then
    Upvalue13.SelectedObject = nil
end

Upvalue8.TitleScreen = false
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end
if workspace:GetAttribute( "ServeurStable" ) ~= true then
    Upvalue2 = true
    Upvalue3.Text = "Server is starting, one moment..."
    Upvalue3.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    local Clock = os.clock( )

    while workspace:GetAttribute( "ServeurStable" ) ~= true do
        if not ( os.clock( ) - Clock < 12 ) then
            break
        end

        task.wait( 0.1 )
    end

    Upvalue3.Text = ""
    Upvalue3.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    Upvalue2 = false

    if Upvalue1 then
        return
    end
end

Upvalue1 = true
Upvalue4( 1.2 )
local Create = Upvalue5:Create( Upvalue6, TweenInfo.new( 0.35 ), { BackgroundTransparency = 0 } )
Create:Play( )
Create.Completed:Wait( )
Upvalue7.Visible = false
Upvalue8( )
task.wait( 0.15 )
local Create2 = Upvalue5:Create( Upvalue6, TweenInfo.new( 0.6 ), { BackgroundTransparency = 1 } )
Create2:Play( )
Create2.Completed:Wait( )
Upvalue9.Enabled = false
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local TextColor3
Upvalue1.Text = SayName or ""

if Argument2 == false then
    local FromRGB = Color3.fromRGB( 255, 120, 120 )

    if FromRGB then
        TextColor3 = FromRGB
    else
        TextColor3 = Color3.fromRGB( 200, 200, 210 )
    end
else
    TextColor3 = Color3.fromRGB( 200, 200, 210 )
end

local Clock2
Upvalue1.TextColor3 = TextColor3

if Argument2 == false then
    local Clock = os.clock( ) + 5

    if Clock then
        Clock2 = Clock
    else
        Clock2 = 0
    end
else
    Clock2 = 0
end

Upvalue2 = Clock2
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

return ColorSequence.new( {
    ColorSequenceKeypoint.new( 0, List[ 1 ] ),
    ColorSequenceKeypoint.new( 0.14, List[ 2 ] ),
    ColorSequenceKeypoint.new( 0.51, List[ 3 ] ),
    ColorSequenceKeypoint.new( 0.86, List[ 2 ] ),
    ColorSequenceKeypoint.new( 1, List[ 4 ] )
} )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
for Key, Value in Upvalue1:GetChildren( ) do
    local Mode = Value:GetAttribute( "Mode" )

    if Value:IsA( "GuiButton" ) and Mode then
        local Flag = Mode == Upvalue2 and true or false
        local UIGradient = Value:FindFirstChildOfClass( "UIGradient" )

        if UIGradient then
            local Entry2

            if Flag then
                local Entry = Upvalue4[ Mode ]

                if Entry then
                    Entry2 = Entry
                else
                    Entry2 = Upvalue4.off
                end
            else
                Entry2 = Upvalue4.off
            end

            UIGradient.Color = Upvalue3( Entry2 )
        end

        local InnerStroke = Value:FindFirstChild( "InnerStroke" )

        if InnerStroke then
            local Transparency = not Flag and 0.85 or 0.35
            InnerStroke.Transparency = Transparency
        end
        if Value:FindFirstChild( "Texte" ) then
            local TextTransparency
            local Texte = Value.Texte
            TextTransparency = not Flag and 0.45 or 0
            Texte.TextTransparency = TextTransparency
        end
        if Value:FindFirstChild( "Sous" ) then
            local TextTransparency2
            local Sous2 = Value.Sous
            TextTransparency2 = not Flag and 0.5 or 0
            Sous2.TextTransparency = TextTransparency2
        end
    end
end

local Sous = Upvalue5:FindFirstChild( "Sous" )
local Text = Upvalue5:GetAttribute( "Sous_" .. Upvalue2 )

if Sous and type( Text ) == "string" then
    Sous.Text = Text
end

local Text2 = Upvalue6:GetAttribute( "Texte_" .. Upvalue2 )

if type( Text2 ) == "string" then
    Upvalue6.Text = Text2
end
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if not Amount then
    return Color3.fromRGB( 170, 170, 180 )
end
if Amount < 70 then
    return Color3.fromRGB( 110, 230, 120 )
end
if Amount < 130 then
    return Color3.fromRGB( 245, 205, 80 )
end
return Color3.fromRGB( 240, 95, 90 )
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local Match = string.match( tostring( Upvalue1:GetAttribute( "VipJoin" ) or "" ), "^(%a+)" )

if Match == "retry" then
    Upvalue2 = os.clock( ) + 15
    return
end
if Match == "failed" then
    Upvalue2 = 0
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1 == Upvalue2 do
    if not Upvalue3 or not ( os.clock( ) < Upvalue4 ) then
        break
    end

    task.wait( 0.2 )
end
if Upvalue1 ~= Upvalue2 or not Upvalue3 then
    return
end
Upvalue2 = Upvalue2 + 1
Upvalue5.BackgroundTransparency = 1
Upvalue6( "Teleport failed, try again", false )
Upvalue7 = false
return
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 and Upvalue2 or Upvalue3
local Success, Result
Captured( "Joining a VIP server..." )

if Argument1 then
    Success, Result = pcall( Upvalue4.InvokeServer, Upvalue4, "joinId", Argument1, Upvalue5 )
else
    Success, Result = pcall( Upvalue4.InvokeServer, Upvalue4, "join", Upvalue5 )
end
if not Success or type( Result ) ~= "table" then
    Captured( "Something went wrong, try again", false )
    return false
end
if Result.ok then
    Upvalue6( 1.5 )
    Upvalue7:Create( Upvalue8, TweenInfo.new( 0.6 ), { BackgroundTransparency = 0 } ):Play( )
    Captured( Result.msg or "Joining a VIP server..." )
    Upvalue9 = Upvalue9 + 1
    Upvalue10 = os.clock( ) + 15
    task.spawn( function()
        while Upvalue9 == Upvalue9 do
            if not Upvalue11 or not ( os.clock( ) < Upvalue10 ) then
                break
            end

            task.wait( 0.2 )
        end
        if Upvalue9 ~= Upvalue9 or not Upvalue11 then
            return
        end
        Upvalue9 = Upvalue9 + 1
        Upvalue8.BackgroundTransparency = 1
        Captured( "Teleport failed, try again", false )
        Upvalue12 = false
        return
    end )
    return true
end
if Result.msg == "not_subscribed" then
    return "prompt"
end
Captured( Result.msg or "Try again", false )
return false
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end

local Flag
Upvalue1 = true
Flag = Upvalue3( Upvalue4.id ) == true and true or false
Upvalue1 = Flag
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    if Value.Name == "Ligne" then
        Value:Destroy( )
    end
end

local Value1 = nil

for Key2, Value2 in List, nil, nil do
    local Text
    local Clone = Upvalue2:Clone( )
    Clone.Name = "Ligne"
    Clone.Visible = true
    Clone.LayoutOrder = Key2
    local Lieu = Clone.Lieu
    Lieu.Text = tostring( Value2.loc or "VIP server" )
    local Joueurs = Clone.Joueurs
    Joueurs.Text = ( "%d/%d" ):format( Value2.n or 0, Value2.max or 0 )
    local Ping = Clone.Ping

    if Value2.ping then
        local Format = ( "%d ms" ):format( Value2.ping )

        if Format then
            Text = Format
        else
            Text = "? ms"
        end
    else
        Text = "? ms"
    end

    local Flag
    Ping.Text = Text
    local Ping2 = Clone.Ping
    Ping2.TextColor3 = Upvalue3( Value2.ping )

    if Value2.full == true then
        Flag = true
    else
        local N = Value2.n or 0

        if ( Value2.max or 0 ) <= N then
            Flag = true
        else
            Flag = false
        end
    end

    local Rejoindre = Clone.Rejoindre

    if Flag then
        Rejoindre.Texte.Text = "FULL"
        Rejoindre.AutoButtonColor = false
        Rejoindre.Active = false
        local UIGradient = Rejoindre:FindFirstChildOfClass( "UIGradient" )

        if UIGradient then
            UIGradient.Color = ColorSequence.new( Color3.fromRGB( 90, 90, 98 ), Color3.fromRGB( 50, 50, 56 ) )
        end
    else
        Rejoindre.Activated:Connect( function()
            if Upvalue4 or Upvalue5 then
                return
            end

            local Flag
            Upvalue4 = true
            Flag = Upvalue6( Value2.id ) == true and true or false
            Upvalue4 = Flag
        end )
    end

    Clone.Parent = Upvalue1
end

local Visible = #List == 0 and true or false
Upvalue7.Visible = Visible
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Success, Result = pcall( Upvalue1.InvokeServer, Upvalue1, "list", Upvalue2 )

if not Upvalue3 or Upvalue2 ~= Upvalue2 then
    return
end
if not Success or type( Result ) ~= "table" or not Result.ok then
    if Success and type( Result ) == "table" then
        local Text = if Result.msg == "not_subscribed" then "Your VIP membership is not active" else Result.msg or "Could not load the servers"
        local TextColor3
        Upvalue7.Text = Text or ""
        local FromRGB = Color3.fromRGB( 255, 120, 120 )
        TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 200, 200, 210 )
        local Clock2
        Upvalue7.TextColor3 = TextColor3
        local Clock = os.clock( ) + 5
        Clock2 = if Clock then Clock else 0
        Upvalue6 = Clock2
        return
    end
    local TextColor32
    Upvalue7.Text = "Could not load the servers, retrying..."
    local FromRGB2 = Color3.fromRGB( 255, 120, 120 )
    TextColor32 = if FromRGB2 then FromRGB2 else Color3.fromRGB( 200, 200, 210 )
    local Clock4
    Upvalue7.TextColor3 = TextColor32
    local Clock3 = os.clock( ) + 5
    Clock4 = if Clock3 then Clock3 else 0
    Upvalue6 = Clock4
else
    local Servers2
    local Servers = Result.servers
    Servers2 = if Servers then Servers else { }
    Upvalue4( Servers2 )

    if not Upvalue5 and Upvalue6 <= os.clock( ) then
        local Format2

        if not Result.myPing or not ( Result.myPing > 0 ) then
            Format2 = ""
        else
            local Format = ( "Your ping here: %d ms · " ):format( Result.myPing )

            if Format then
                Format2 = Format
            else
                Format2 = ""
            end
        end

        Upvalue7.Text = Format2 .. "Server ping is estimated" or ""
        Upvalue7.TextColor3 = Color3.fromRGB( 200, 200, 210 )
        Upvalue6 = 0
        return
    end
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1 do
    if Upvalue2 ~= Upvalue3 or not Upvalue4 then
        break
    end

    Upvalue5( )
    task.wait( 10 )
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Value1
Upvalue1 = true
Upvalue2 = Upvalue2 + 1
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    Value.Visible = false
end

Upvalue4( )
Upvalue5( { } )
Upvalue6.Visible = false
Upvalue7.Text = "Loading the VIP servers..."
Upvalue7.TextColor3 = Color3.fromRGB( 200, 200, 210 )
Upvalue8 = 0
Upvalue9.Visible = true
local UIScale = Upvalue9:FindFirstChildOfClass( "UIScale" )

if UIScale then
    UIScale.Scale = 0.92
    Upvalue10:Create( UIScale, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
end
if Upvalue11.GamepadEnabled then
    Upvalue12.SelectedObject = Upvalue13
end

task.spawn( function()
    while Upvalue1 do
        if Upvalue2 ~= Upvalue2 or not Upvalue14 then
            break
        end

        Upvalue15( )
        task.wait( 10 )
    end
end )
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 then
    return
end

local Value1
Upvalue1 = false
Upvalue3.Visible = false
Value1 = nil

for Key, Value in Upvalue4, nil, nil do
    Value.Visible = true
end

local Visible

if Upvalue5:GetAttribute( "Returning" ) == true then
    Visible = true
elseif Upvalue6.inVip == true then
    Visible = true
elseif Upvalue6.sub == true then
    Visible = true
elseif Upvalue6.free == true then
    Visible = true
elseif Upvalue5:GetAttribute( "VIP" ) == true then
    Visible = true
else
    Visible = false
end

Upvalue7.Visible = Visible
Upvalue8.Visible = Visible
Upvalue9.Text = ""
Upvalue9.TextColor3 = Color3.fromRGB( 235, 235, 240 )

if Upvalue10.GamepadEnabled then
    Upvalue11.SelectedObject = Upvalue7
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end

local Flag
Upvalue1 = true
Flag = Upvalue3( nil ) == true and true or false
Upvalue1 = Flag
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 or Upvalue3 == Upvalue4 then
    return
end
Upvalue4 = Upvalue3
Upvalue5( )
Upvalue6( { } )
Upvalue7.Visible = false
Upvalue8.Text = "Loading the VIP servers..."
Upvalue8.TextColor3 = Color3.fromRGB( 200, 200, 210 )
Upvalue9 = 0
task.spawn( Upvalue10 )
return
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

local Statut

if Upvalue1 then
    Statut = Upvalue1:FindFirstChild( "Statut" )
else
    Statut = Upvalue1
end
if not Statut then
    return Upvalue2( SayName, Argument2 )
end

local TextColor3
Statut.Text = SayName or ""

if Argument2 == false then
    local FromRGB = Color3.fromRGB( 255, 120, 120 )

    if FromRGB then
        TextColor3 = FromRGB
    else
        TextColor3 = Color3.fromRGB( 200, 200, 210 )
    end
else
    TextColor3 = Color3.fromRGB( 200, 200, 210 )
end

Statut.TextColor3 = TextColor3
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if type( TextName ) ~= "string" or TextName == "" then
    return nil
end
if Upvalue1 and Upvalue2 == TextName and os.clock( ) - Upvalue3 < 600 then
    return Upvalue1
end

local Success, Result = pcall( Upvalue4.GetSubscriptionProductInfoAsync, Upvalue4, TextName )

if not Success or type( Result ) ~= "table" then
    local Captured = Upvalue2 == TextName and Upvalue1 or nil
    return Captured
end
local DisplayPrice
local Number = tonumber( Result.PriceInRobux )

if type( Result.DisplayPrice ) ~= "string" or not Result.DisplayPrice:match( "%S" ) or not Result.DisplayPrice then
    DisplayPrice = nil
else
    DisplayPrice = Result.DisplayPrice
end
if DisplayPrice and Number and DisplayPrice:match( "^[%d%s,%.]+$" ) then
    DisplayPrice = DisplayPrice .. " Robux"
end

local DisplayPrice2

if DisplayPrice then
    DisplayPrice2 = DisplayPrice
elseif Number then
    DisplayPrice2 = tostring( Number ) .. " Robux"
else
    DisplayPrice2 = Number
end
if not DisplayPrice2 then
    return nil
end

local Lower2
local SubscriptionPeriod = Result.SubscriptionPeriod

if typeof( SubscriptionPeriod ) == "EnumItem" then
    local Lower = SubscriptionPeriod.Name:lower( )

    if Lower then
        Lower2 = Lower
    else
        Lower2 = "month"
    end
else
    Lower2 = "month"
end

local Format = ( "%s / %s" ):format( DisplayPrice2, Lower2 )
local Clock = os.clock( )
Upvalue1 = Format
Upvalue2 = TextName
Upvalue3 = Clock
return Upvalue1
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = Upvalue1( Upvalue2.id )

if Text and Upvalue3 then
    Upvalue4.Text = Text
end
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 then
    return
end

local Value1
Upvalue2 = true
Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    if Value then
        Value.Visible = false
    end
end

local Prix = Upvalue1:FindFirstChild( "Prix" )

if not Prix or not Argument1 or type( Argument1.price ) ~= "string" or Argument1.price == "" then
    if Prix and Argument1 then
        task.spawn( function()
            local Text = Upvalue4( Argument1.id )

            if Text and Upvalue2 then
                Prix.Text = Text
            end
        end )
    end
else
    Prix.Text = Argument1.price
end

local Statut

if Upvalue1 then
    Statut = Upvalue1:FindFirstChild( "Statut" )
else
    Statut = Upvalue1
end
if Statut then
    Statut.Text = ""
    Statut.TextColor3 = Color3.fromRGB( 200, 200, 210 )
else
    Upvalue5.Text = ""
    Upvalue5.TextColor3 = Color3.fromRGB( 235, 235, 240 )
end

Upvalue1.Visible = true

if Upvalue6.GamepadEnabled then
    Upvalue7.SelectedObject = Upvalue1:FindFirstChild( "Abonner" )
end
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 ~= Upvalue1 or Upvalue2 ~= Upvalue3 then
    return
end

local Flag = Argument3 == true and true or false
Upvalue4 = true
Upvalue5 = Flag

if not Upvalue5 then
    Upvalue6 = math.min( Upvalue6, os.clock( ) + 2 )
    return
end

Upvalue6 = os.clock( ) + 120

if Upvalue7( ).sub then
    return
end

Upvalue8.pending = true

if Upvalue9 then
    local Value1
    Upvalue10( false )
    Value1 = nil

    for Key, Value in Upvalue11, nil, nil do
        if Value then
            Value.Visible = true
        end
    end
end

Upvalue12( )

if not Upvalue13 then
    local Visible

    if Upvalue1:GetAttribute( "Returning" ) == true then
        Visible = true
    elseif Upvalue8.inVip == true then
        Visible = true
    elseif Upvalue8.sub == true then
        Visible = true
    elseif Upvalue8.free == true then
        Visible = true
    elseif Upvalue1:GetAttribute( "VIP" ) == true then
        Visible = true
    else
        Visible = false
    end

    Upvalue14.Visible = Visible
    Upvalue15.Visible = Visible
end

Upvalue16( "" )
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2.PromptSubscriptionPurchaseFinished:Connect( function( Argument1, Argument2, Argument3 )
    if Argument1 ~= Upvalue3 or Upvalue4 ~= Upvalue5 then
        return
    end

    local Flag = Argument3 == true and true or false
    Upvalue6 = true
    Upvalue7 = Flag

    if not Upvalue7 then
        Upvalue8 = math.min( Upvalue8, os.clock( ) + 2 )
        return
    end

    Upvalue8 = os.clock( ) + 120

    if Upvalue9( ).sub then
        return
    end

    Upvalue10.pending = true

    if Upvalue11 then
        local Value1
        Upvalue12( false )
        Value1 = nil

        for Key, Value in Upvalue13, nil, nil do
            if Value then
                Value.Visible = true
            end
        end
    end

    Upvalue14( )

    if not Upvalue15 then
        local Visible

        if Upvalue3:GetAttribute( "Returning" ) == true then
            Visible = true
        elseif Upvalue10.inVip == true then
            Visible = true
        elseif Upvalue10.sub == true then
            Visible = true
        elseif Upvalue10.free == true then
            Visible = true
        elseif Upvalue3:GetAttribute( "VIP" ) == true then
            Visible = true
        else
            Visible = false
        end

        Upvalue16.Visible = Visible
        Upvalue17.Visible = Visible
    end

    Upvalue18( "" )
end )
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1 == Upvalue2 do
    if not ( os.clock( ) < Upvalue3 ) or not Upvalue4 then
        break
    end

    local Number = not Upvalue5 and 3 or 2
    task.wait( Number )

    if Upvalue1 ~= Upvalue2 then
        break
    end
    if Upvalue6( ).sub then
        if Upvalue7 then
            Upvalue7:Disconnect( )
        end

        Upvalue8.pending = nil
        Upvalue9( )

        if Upvalue1 == Upvalue2 then
            Upvalue10( )
        end

        return
    end
end
if Upvalue7 then
    Upvalue7:Disconnect( )
end
if Upvalue1 == Upvalue2 and Upvalue11 then
    local TextColor3
    Upvalue8.pending = nil
    Upvalue9( )
    Upvalue12.Text = "Your VIP is not active yet, try again in a minute"
    local FromRGB = Color3.fromRGB( 255, 120, 120 )
    TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 235, 235, 240 )
    Upvalue12.TextColor3 = TextColor3
end
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
local Clock = os.clock( ) + 45
local Flag = false
local Flag2 = false
local Value1 = nil
pcall( function()
    Value1 = Upvalue2.PromptSubscriptionPurchaseFinished:Connect( function( Argument1Inner, Argument2, Argument3 )
        if Argument1Inner ~= Upvalue3 or Upvalue1 ~= Upvalue1 then
            return
        end

        local FlagInner = Argument3 == true and true or false
        Flag = true
        Flag2 = FlagInner

        if not Flag2 then
            Clock = math.min( Clock, os.clock( ) + 2 )
            return
        end

        Clock = os.clock( ) + 120

        if Upvalue4( ).sub then
            return
        end

        Upvalue5.pending = true

        if Upvalue6 then
            local Value1
            Upvalue7( false )
            Value1 = nil

            for Key, Value in Upvalue8, nil, nil do
                if Value then
                    Value.Visible = true
                end
            end
        end

        Upvalue9( )

        if not Upvalue10 then
            local Visible

            if Upvalue3:GetAttribute( "Returning" ) == true then
                Visible = true
            elseif Upvalue5.inVip == true then
                Visible = true
            elseif Upvalue5.sub == true then
                Visible = true
            elseif Upvalue5.free == true then
                Visible = true
            elseif Upvalue3:GetAttribute( "VIP" ) == true then
                Visible = true
            else
                Visible = false
            end

            Upvalue11.Visible = Visible
            Upvalue12.Visible = Visible
        end

        Argument1( "" )
    end )
end )
task.spawn( function()
    while Upvalue1 == Upvalue1 do
        if not ( os.clock( ) < Clock ) or not Upvalue13 then
            break
        end

        local Number = not Flag and 3 or 2
        task.wait( Number )

        if Upvalue1 ~= Upvalue1 then
            break
        end
        if Upvalue4( ).sub then
            if Value1 then
                Value1:Disconnect( )
            end

            Upvalue5.pending = nil
            Upvalue9( )

            if Upvalue1 == Upvalue1 then
                Argument2( )
            end

            return
        end
    end
    if Value1 then
        Value1:Disconnect( )
    end
    if Upvalue1 == Upvalue1 and Flag2 then
        local TextColor3
        Upvalue5.pending = nil
        Upvalue9( )
        Upvalue14.Text = "Your VIP is not active yet, try again in a minute"
        local FromRGB = Color3.fromRGB( 255, 120, 120 )
        TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 235, 235, 240 )
        Upvalue14.TextColor3 = TextColor3
    end
end )
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = false
Upvalue2.Visible = false

if Argument1 then
    Upvalue3 = Upvalue3 + 1
end
if Argument1 then
    local Value1 = nil

    for Key, Value in Upvalue4, nil, nil do
        if Value then
            Value.Visible = true
        end
    end

    local Visible

    if Upvalue5:GetAttribute( "Returning" ) == true then
        Visible = true
    elseif Upvalue6.inVip == true then
        Visible = true
    elseif Upvalue6.sub == true then
        Visible = true
    elseif Upvalue6.free == true then
        Visible = true
    elseif Upvalue5:GetAttribute( "VIP" ) == true then
        Visible = true
    else
        Visible = false
    end

    Upvalue7.Visible = Visible
    Upvalue8.Visible = Visible

    if Upvalue9.GamepadEnabled then
        Upvalue10.SelectedObject = Upvalue7
    end
end
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end
if Upvalue3 then
    local Statut

    if Upvalue4 then
        Statut = Upvalue4:FindFirstChild( "Statut" )
    else
        Statut = Upvalue4
    end
    if Statut then
        Statut.Text = "Welcome to VIP!"
        Statut.TextColor3 = Color3.fromRGB( 200, 200, 210 )
    else
        Upvalue5.Text = "Welcome to VIP!"
        Upvalue5.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    end

    task.wait( 0.8 )

    if Upvalue3 and not Upvalue1 then
        Upvalue6( false )
        Upvalue7( )
    end

    return
end
Upvalue5.Text = "Welcome to VIP!"
Upvalue5.TextColor3 = Color3.fromRGB( 235, 235, 240 )
task.wait( 0.8 )

if not Upvalue1 and not Upvalue2 and not Upvalue3 and Upvalue8 then
    Upvalue7( )
end

return
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end

Upvalue1 = true
local Value1 = Upvalue3( )

if Value1.sub or Value1.free then
    Upvalue4( false )
    Upvalue1 = false
    Upvalue5( )
    return
end

local Statut

if Upvalue6 then
    Statut = Upvalue6:FindFirstChild( "Statut" )
else
    Statut = Upvalue6
end
if Statut then
    Statut.Text = "Opening the Roblox subscription window..."
    Statut.TextColor3 = Color3.fromRGB( 200, 200, 210 )
else
    Upvalue7.Text = "Opening the Roblox subscription window..."
    Upvalue7.TextColor3 = Color3.fromRGB( 235, 235, 240 )
end

local PromptSubscriptionPurchase = Upvalue8.PromptSubscriptionPurchase
local Success = pcall( PromptSubscriptionPurchase, Upvalue8, Upvalue9, Value1.id )
Upvalue1 = false

if Success then
    Upvalue10( Upvalue11, function()
        if Upvalue2 or Upvalue12 then
            return
        end
        if Upvalue13 then
            local Statut

            if Upvalue6 then
                Statut = Upvalue6:FindFirstChild( "Statut" )
            else
                Statut = Upvalue6
            end
            if Statut then
                Statut.Text = "Welcome to VIP!"
                Statut.TextColor3 = Color3.fromRGB( 200, 200, 210 )
            else
                Upvalue7.Text = "Welcome to VIP!"
                Upvalue7.TextColor3 = Color3.fromRGB( 235, 235, 240 )
            end

            task.wait( 0.8 )

            if Upvalue13 and not Upvalue2 then
                Upvalue4( false )
                Upvalue5( )
            end

            return
        end
        Upvalue7.Text = "Welcome to VIP!"
        Upvalue7.TextColor3 = Color3.fromRGB( 235, 235, 240 )
        task.wait( 0.8 )

        if not Upvalue2 and not Upvalue12 and not Upvalue13 and Upvalue14 then
            Upvalue5( )
        end

        return
    end )
    return
end

local Statut2

if Upvalue6 then
    Statut2 = Upvalue6:FindFirstChild( "Statut" )
else
    Statut2 = Upvalue6
end
if Statut2 then
    local TextColor32
    Statut2.Text = "The VIP subscription is not available right now"
    local FromRGB2 = Color3.fromRGB( 255, 120, 120 )
    TextColor32 = if FromRGB2 then FromRGB2 else Color3.fromRGB( 200, 200, 210 )
    Statut2.TextColor3 = TextColor32
    return
end
local TextColor3
Upvalue7.Text = "The VIP subscription is not available right now"
local FromRGB = Color3.fromRGB( 255, 120, 120 )
TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 235, 235, 240 )
Upvalue7.TextColor3 = TextColor3
return
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( Upvalue1 )
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    Upvalue2( true )
    Upvalue3.Text = ""
    Upvalue3.TextColor3 = Color3.fromRGB( 235, 235, 240 )
end
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end

Upvalue3.Text = "Welcome to VIP!"
Upvalue3.TextColor3 = Color3.fromRGB( 235, 235, 240 )
task.wait( 0.8 )

if not Upvalue1 then
    Upvalue4( )
end
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or Upvalue2 then
    return
end
if not Upvalue3 then
    Upvalue4.Text = "Please wait a moment..."
    Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    return
end

Upvalue2 = true
local Value1 = Upvalue5( )

if Value1.inVip then
    local Text = Value1.mode ~= "safe" and "You are already on a VIP server" or "You are already on a SAFE VIP server"
    Upvalue4.Text = Text or ""
    Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    Upvalue2 = false
    return
end
if not Value1.enabled then
    Upvalue4.Text = "VIP servers are coming soon!"
    Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    Upvalue2 = false
    return
end
if Value1.sub or Value1.free then
    Upvalue2 = false
    Upvalue6( )
    return
end
if Value1.err then
    Upvalue4.Text = "Checking your VIP with Roblox, try again in a moment"
    Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    Upvalue2 = false
    return
end
if Upvalue7.pending then
    local Info_Pending2
    local Info_Pending = Upvalue8:GetAttribute( "Info_Pending" )
    Info_Pending2 = type( Info_Pending ) == "string" and Info_Pending or "Activating your VIP, please wait..."
    Upvalue4.Text = Info_Pending2 or ""
    Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
    Upvalue2 = false
    return
end
if Upvalue9 then
    Upvalue2 = false
    Upvalue10( Value1 )
    return
end

Upvalue4.Text = "Get VIP to unlock the VIP servers"
Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
local PromptSubscriptionPurchase = Upvalue11.PromptSubscriptionPurchase
local Success = pcall( PromptSubscriptionPurchase, Upvalue11, Upvalue12, Value1.id )
Upvalue2 = false

if Success then
    Upvalue13( Upvalue14, function()
        if Upvalue1 or Upvalue15 then
            return
        end

        Upvalue4.Text = "Welcome to VIP!"
        Upvalue4.TextColor3 = Color3.fromRGB( 235, 235, 240 )
        task.wait( 0.8 )

        if not Upvalue1 then
            Upvalue6( )
        end
    end )
    return
end

local TextColor3
Upvalue4.Text = "The VIP subscription is not available right now"
local FromRGB = Color3.fromRGB( 255, 120, 120 )
TextColor3 = if FromRGB then FromRGB else Color3.fromRGB( 235, 235, 240 )
Upvalue4.TextColor3 = TextColor3
return
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

task.spawn( Upvalue1 )
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

local Sub = Upvalue2:GetAttribute( "VIP" ) == true and true or false
Upvalue1.sub = Sub
Upvalue3( )

if Upvalue4 and not Upvalue5 and not Upvalue6 then
    local Visible

    if Upvalue2:GetAttribute( "Returning" ) == true then
        Visible = true
    elseif Upvalue1.inVip == true then
        Visible = true
    elseif Upvalue1.sub == true then
        Visible = true
    elseif Upvalue1.free == true then
        Visible = true
    elseif Upvalue2:GetAttribute( "VIP" ) == true then
        Visible = true
    else
        Visible = false
    end

    Upvalue7.Visible = Visible
    Upvalue8.Visible = Visible
end
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

local InVip = workspace:GetAttribute( "VipServer" ) == true and true or false
Upvalue1.inVip = InVip
Upvalue2( )

if Upvalue3 and not Upvalue4 and not Upvalue5 then
    local Visible

    if Upvalue6:GetAttribute( "Returning" ) == true then
        Visible = true
    elseif Upvalue1.inVip == true then
        Visible = true
    elseif Upvalue1.sub == true then
        Visible = true
    elseif Upvalue1.free == true then
        Visible = true
    elseif Upvalue6:GetAttribute( "VIP" ) == true then
        Visible = true
    else
        Visible = false
    end

    Upvalue7.Visible = Visible
    Upvalue8.Visible = Visible
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and not Upvalue2 and not Upvalue3 then
    local Visible

    if Upvalue4:GetAttribute( "Returning" ) == true then
        Visible = true
    elseif Upvalue5.inVip == true then
        Visible = true
    elseif Upvalue5.sub == true then
        Visible = true
    elseif Upvalue5.free == true then
        Visible = true
    elseif Upvalue4:GetAttribute( "VIP" ) == true then
        Visible = true
    else
        Visible = false
    end

    Upvalue6.Visible = Visible
    Upvalue7.Visible = Visible
end
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

local Enabled = Upvalue2:GetAttribute( "VipEnabled" ) == true and true or false
Upvalue1.enabled = Enabled
Upvalue3( )
]]
