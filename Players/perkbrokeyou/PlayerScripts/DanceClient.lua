-- Players.perkbrokeyou.PlayerScripts.DanceClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #54

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1[ Object:GetAttribute( "DanceId" ) or "Phonk" ]
Entry2 = if Entry then Entry else Upvalue1.Phonk
return Entry2
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

game:GetService( "ContentProvider" ):PreloadAsync( Upvalue1 )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { }
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Warm = Instance.new( "Sound" )
    Warm.Name = Key
    Warm.SoundId = Value.music.id
    Warm.Volume = 0
    Warm.Parent = Upvalue2
    Value.music.warm = Warm
    table.insert( Table, Warm )
end

pcall( function()
    game:GetService( "ContentProvider" ):PreloadAsync( Table )
end )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.spawn( function()
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in Upvalue2, nil, nil do
        local Warm = Instance.new( "Sound" )
        Warm.Name = Key
        Warm.SoundId = Value.music.id
        Warm.Volume = 0
        Warm.Parent = Upvalue3
        Value.music.warm = Warm
        table.insert( Table, Warm )
    end

    pcall( function()
        game:GetService( "ContentProvider" ):PreloadAsync( Table )
    end )
end )
return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

return ( workspace:GetServerTimeNow( ) - Argument1 ) * Argument2 % Argument3
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if Object == Upvalue1 and Upvalue2:IsStudio( ) and workspace:GetAttribute( "DanceTestNoBusy" ) == true then
    return false
end
if Object == Upvalue1 then
    if Upvalue3.WardrobeOpen or Upvalue3.BetaReveal then
        return true
    end
end

local Flag
local Character = Object.Character

if Object:GetAttribute( "InWardrobe" ) == true then
    Flag = true
elseif Object:GetAttribute( "Onboarding" ) == true then
    Flag = true
elseif Character == nil then
    Flag = false
elseif Character:GetAttribute( "BetaReveal" ) == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Flag

if Humanoid == nil then
    Flag = false
elseif Humanoid.Health > 0 then
    local NotSeatPart = not Humanoid.SeatPart

    if NotSeatPart then
        local NotDowned = not Character:GetAttribute( "Downed" )

        if NotDowned then
            local NotRolling = not Upvalue2.Rolling

            if NotRolling then
                Flag = not Upvalue3( Upvalue1 )
            else
                Flag = NotRolling
            end
        else
            Flag = NotDowned
        end
    else
        Flag = NotSeatPart
    end
else
    Flag = false
end

return Flag, Character, Humanoid
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Value2, Value3 = Upvalue1( )

if not Value1 then
    return
end

local Text = if Upvalue2[ Key ] then Key else "Phonk"
Value3:UnequipTools( )
Upvalue3 = true
local Speed = Upvalue2[ Text ].speed or 1
local ServerTimeNow = workspace:GetServerTimeNow( )
Value2:SetAttribute( "DanceStart", ServerTimeNow )
Value2:SetAttribute( "DanceSpeed", Speed )
Value2:SetAttribute( "DanceGroup", Upvalue4.UserId )
Value2:SetAttribute( "DanceMusicStart", ServerTimeNow )
Value2:SetAttribute( "DanceId", Text )
Upvalue5:FireServer( true, Speed, Text )
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character
local Character2 = Argument1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end
if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart or Character:GetAttribute( "Downed" ) or Upvalue2.Rolling then
    return
end
if Upvalue3( Upvalue1 ) or Upvalue3( Argument1 ) then
    return
end
if not Character2 or not Character2:GetAttribute( "DanceStart" ) then
    return
end

local Value1
Humanoid:UnequipTools( )
Upvalue4 = true
Value1 = nil

for Key, Value in Upvalue5, nil, nil do
    Character:SetAttribute( Value, Character2:GetAttribute( Value ) )
end

Upvalue6:FireServer( "join", Argument1 )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = false
local Character = Upvalue2.Character

if Character then
    local Value1 = nil

    for Key, Value in Upvalue3, nil, nil do
        Character:SetAttribute( Value, nil )
    end
end

Upvalue4:FireServer( false )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = ( Object:GetAttribute( "Order" ) or 99 ) < ( Object2:GetAttribute( "Order" ) or 99 ) and true or false
return Flag
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

table.clear( Upvalue1 )
table.clear( Upvalue2 )
local Table = { }

for Key, Value in Upvalue3.Slots:GetChildren( ) do
    if Value:IsA( "GuiButton" ) and Upvalue4[ Value.Name ] then
        table.insert( Table, Value )
    end
end

local Value1
table.sort( Table, function( Object, Object2 )
    local Flag = ( Object:GetAttribute( "Order" ) or 99 ) < ( Object2:GetAttribute( "Order" ) or 99 ) and true or false
    return Flag
end )
local Count = #Table
Value1 = nil

for Key2, Value2 in Table, nil, nil do
    local Rad = math.rad( ( Key2 - 1 ) * 360 / Count )
    Value2.Position = UDim2.fromScale( math.sin( Rad ) * 0.335 + 0.5, 0.5 - math.cos( Rad ) * 0.335 )
    local Name = Value2.Name
    Upvalue1[ Key2 ] = Value2
    Upvalue2[ Key2 ] = Name
end

local Parent = Upvalue3.Separators
Parent:ClearAllChildren( )
local I = 1

for I = 1, Count do
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "Sep" .. I
    Parent2.AnchorPoint = Vector2.new( 0.5, 0.5 )
    Parent2.Position = UDim2.fromScale( 0.5, 0.5 )
    Parent2.Size = UDim2.fromScale( 1, 1 )
    Parent2.BackgroundTransparency = 1
    Parent2.Rotation = ( I - 0.5 ) * 360 / Count
    Parent2.ZIndex = 2
    local Frame = Instance.new( "Frame" )
    Frame.Name = "Line"
    Frame.AnchorPoint = Vector2.new( 0.5, 0 )
    Frame.Position = UDim2.fromScale( 0.5, 0.045 )
    Frame.Size = UDim2.fromScale( 0.005, 0.27 )
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.new( 1, 1, 1 )
    Frame.BackgroundTransparency = 0.8
    Frame.ZIndex = 2
    Frame.Parent = Parent2
    Parent2.Parent = Parent
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Count = #Upvalue1

if Count == 0 or Argument1.Magnitude < 1e-06 then
    return nil
end
local X = Argument1.X
return math.floor( ( math.deg( ( math.atan2( X, -Argument1.Y ) ) ) % 360 + 180 / Count ) % 360 / ( 360 / Count ) ) + 1
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if HotName == Upvalue1 then
    return
end

local Value1
Upvalue1 = HotName
Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    local Flag = Key == HotName and true or false
    local Hot = Value:FindFirstChild( "Hot" )

    if Hot then
        local Scale
        local Table = { }
        Scale = not Flag and 1 or 1.14
        Table.Scale = Scale
        Upvalue3:Create( Hot, Upvalue4, Table ):Play( )
    end

    local Edge = Value:FindFirstChild( "Edge" )

    if Edge then
        local Color

        if not Flag or not Upvalue5 then
            Color = Color3.new( 1, 1, 1 )
        else
            Color = Upvalue5
        end

        local Transparency
        Edge.Color = Color
        Transparency = not Flag and 0.1 or 0
        Edge.Transparency = Transparency
    end

    local Text2 = Value:FindFirstChild( "Text" )

    if Text2 then
        local TextColor3 = Flag and Upvalue5 or Upvalue6
        Text2.TextColor3 = TextColor3
    end
end

local Visible
local Pointer = Upvalue7.Pointer
Visible = HotName ~= nil and true or false
Pointer.Visible = Visible

if HotName then
    local Total = ( HotName - 1 ) * 360 / #Upvalue2
    local Rotation = Pointer.Rotation
    Upvalue3:Create( Pointer, Upvalue4, { Rotation = Rotation + ( ( Total - Rotation + 180 ) % 360 - 180 ) } ):Play( )
end

local Text
local DanceName = Upvalue7.Hub.DanceName

if HotName then
    local Label = Upvalue2[ HotName ]:GetAttribute( "Label" )

    if Label then
        Text = Label
    else
        local Entry = Upvalue8[ HotName ]

        if Entry then
            Text = Entry
        else
            Text = "Choose"
        end
    end
else
    Text = "Choose"
end

DanceName.Text = Text

if HotName and Upvalue9.IsGamepad then
    local SetVirtual = Upvalue10.SetVirtual
    SetVirtual( "EmoteWheel", Upvalue2[ HotName ] )
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsGamepad then
    return "pad"
end
if Upvalue2:GetLastInputType( ) == Enum.UserInputType.Touch then
    return "touch"
end
return "mouse"
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue2 then
    local TestStick = Upvalue2:GetAttribute( "TestStick" )

    if typeof( TestStick ) == "Vector2" then
        local TestStick2 = TestStick.Magnitude >= 0.5 and TestStick or nil
        return TestStick2
    end
end

local Success, Result = pcall( Upvalue3.GetGamepadState, Upvalue3, Enum.UserInputType.Gamepad1 )

if not Success or not Result then
    return nil
end

local Value1, Vector22
Value1 = nil
Vector22 = nil

for Key, Value in Result, nil, nil do
    if Value.KeyCode == Enum.KeyCode.Thumbstick1 or Value.KeyCode == Enum.KeyCode.Thumbstick2 then
        local Vector23 = Vector2.new( Value.Position.X, Value.Position.Y )

        if Vector23.Magnitude >= 0.5 then
            if not Vector22 or Vector22.Magnitude < Vector23.Magnitude then
                Vector22 = Vector23
            end
        end
    end
end

return Vector22
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = false
Upvalue2( nil )

if Upvalue3 then
    Upvalue3.Enabled = false
end

Upvalue4.Close( "EmoteWheel" )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Upvalue2 then
    Upvalue2 = false
    Upvalue3( nil )

    if Upvalue4 then
        Upvalue4.Enabled = false
    end

    Upvalue5.Close( "EmoteWheel" )
end
if Entry then
    Upvalue6( Entry )
end
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue2[ Upvalue1 ]

if Upvalue3 then
    Upvalue3 = false
    Upvalue4( nil )

    if Upvalue5 then
        Upvalue5.Enabled = false
    end

    Upvalue6.Close( "EmoteWheel" )
end
if Entry then
    Upvalue7( Entry )
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1[ Upvalue2 or 1 ]
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2( ) then
    return
end

local Number
Upvalue3( )
Number = ( not Upvalue4.TouchEnabled or Upvalue4.KeyboardEnabled ) and 0.66 or 0.8
Upvalue1.Size = UDim2.fromScale( Number, Number )
Upvalue5 = true
Upvalue6 = nil
Upvalue7( nil )
Upvalue8 = nil
Upvalue9.Enabled = true
Upvalue1.Pop.Scale = 0.86
Upvalue10:Create( Upvalue1.Pop, TweenInfo.new( 0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
local Backdrop = Upvalue9.Backdrop
Backdrop.BackgroundTransparency = 1
Upvalue10:Create( Backdrop, TweenInfo.new( 0.15 ), { BackgroundTransparency = 0.5 } ):Play( )

if not Upvalue11 then
    Upvalue11 = true
    task.spawn( function()
        local Value1
        local Table = { }
        Value1 = nil

        for Key, Value in Upvalue12, nil, nil do
            local Warm = Instance.new( "Sound" )
            Warm.Name = Key
            Warm.SoundId = Value.music.id
            Warm.Volume = 0
            Warm.Parent = Upvalue13
            Value.music.warm = Warm
            table.insert( Table, Warm )
        end

        pcall( function()
            game:GetService( "ContentProvider" ):PreloadAsync( Table )
        end )
    end )
end

local Value1
local Table = { }
Value1 = nil

for Key, Value in Upvalue14, nil, nil do
    Table[ Value ] = function()
        local Entry = Upvalue15[ Key ]

        if Upvalue5 then
            Upvalue5 = false
            Upvalue7( nil )

            if Upvalue9 then
                Upvalue9.Enabled = false
            end

            Upvalue16.Close( "EmoteWheel" )
        end
        if Entry then
            Upvalue17( Entry )
        end
    end
end

Upvalue16.Open( "EmoteWheel", {
    root = Upvalue1,
    virtual = true,
    first = function()
        return Upvalue14[ Upvalue6 or 1 ]
    end,
    virtualActions = Table,
    onBack = Upvalue18,
    selectLabel = "Dance",
    backLabel = "Close"
} )

if Upvalue19.IsGamepad then
    Upvalue7( 1 )
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Upvalue2.Enabled then
    local Text

    if Upvalue5.IsGamepad then
        Text = "pad"
    elseif Upvalue6:GetLastInputType( ) == Enum.UserInputType.Touch then
        Text = "touch"
    else
        Text = "mouse"
    end
    if Text ~= Upvalue7 then
        Upvalue7 = Text
        local Hint = Upvalue8.Hub.Hint
        Hint.Text = Upvalue9[ Text ]
    end
    if Text == "pad" then
        local Value1 = Upvalue10( )

        if Value1 then
            local Floor
            local Vector22 = Vector2.new( Value1.X, -Value1.Y )
            local Count = #Upvalue11

            if Count == 0 or Vector22.Magnitude < 1e-06 then
                Floor = nil
            else
                local X = Vector22.X
                Floor = math.floor( ( math.deg( ( math.atan2( X, -Vector22.Y ) ) ) % 360 + 180 / Count ) % 360 / ( 360 / Count ) ) + 1
            end

            Upvalue3( Floor )
            return
        end
        local Find
        local Virtual = Upvalue4.GetVirtual( "EmoteWheel" )

        if Virtual then
            Find = table.find( Upvalue11, Virtual )
        else
            Find = Virtual
        end
        if Find then
            Upvalue3( Find )
            return
        end
    elseif Text == "mouse" then
        local MouseLocation = Upvalue6:GetMouseLocation( ) - ( Upvalue8.AbsolutePosition + Upvalue8.AbsoluteSize / 2 )
        local X2 = Upvalue8.AbsoluteSize.X / 2

        if MouseLocation.Magnitude < X2 * 0.2 or X2 * 1.6 < MouseLocation.Magnitude then
            Upvalue3( nil )
            return
        end

        local Floor2
        local Count2 = #Upvalue11

        if Count2 == 0 or MouseLocation.Magnitude < 1e-06 then
            Floor2 = nil
        else
            local X3 = MouseLocation.X
            Floor2 = math.floor( ( math.deg( ( math.atan2( X3, -MouseLocation.Y ) ) ) % 360 + 180 / Count2 ) % 360 / ( 360 / Count2 ) ) + 1
        end

        Upvalue3( Floor2 )
    end

    return
end
if not Upvalue1 then
    return
end

Upvalue1 = false
Upvalue3( nil )

if Upvalue2 then
    Upvalue2.Enabled = false
end

Upvalue4.Close( "EmoteWheel" )
return
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Find = table.find( Upvalue2, Upvalue3 )

if Find then
    local Entry = Upvalue4[ Find ]

    if Upvalue1 then
        Upvalue1 = false
        Upvalue5( nil )

        if Upvalue6 then
            Upvalue6.Enabled = false
        end

        Upvalue7.Close( "EmoteWheel" )
    end
    if Entry then
        Upvalue8( Entry )
    end
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Text

if Upvalue2.IsGamepad then
    Text = "pad"
elseif Upvalue3:GetLastInputType( ) == Enum.UserInputType.Touch then
    Text = "touch"
else
    Text = "mouse"
end
if Text ~= "mouse" or not Upvalue4 then
    if not Upvalue1 then
        return
    end

    Upvalue1 = false
    Upvalue6( nil )

    if Upvalue7 then
        Upvalue7.Enabled = false
    end

    Upvalue8.Close( "EmoteWheel" )
else
    local Entry = Upvalue5[ Upvalue4 ]

    if Upvalue1 then
        Upvalue1 = false
        Upvalue6( nil )

        if Upvalue7 then
            Upvalue7.Enabled = false
        end

        Upvalue8.Close( "EmoteWheel" )
    end
    if Entry then
        Upvalue9( Entry )
        return
    end
end
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2:WaitForChild( "PlayerGui" ):WaitForChild( "EmoteWheel", math.huge )
Upvalue3 = Upvalue1:WaitForChild( "Wheel" )
Upvalue3:WaitForChild( "Slots" )
Upvalue3:WaitForChild( "Hub" )
Upvalue4( )

for Key, Value in Upvalue3.Slots:GetChildren( ) do
    if Value:IsA( "GuiButton" ) then
        Value.Activated:Connect( function()
            if not Upvalue5 then
                return
            end

            local Find = table.find( Upvalue6, Value )

            if Find then
                local Entry = Upvalue7[ Find ]

                if Upvalue5 then
                    Upvalue5 = false
                    Upvalue8( nil )

                    if Upvalue1 then
                        Upvalue1.Enabled = false
                    end

                    Upvalue9.Close( "EmoteWheel" )
                end
                if Entry then
                    Upvalue10( Entry )
                end
            end
        end )
    end
end

Upvalue3.Hub.Activated:Connect( Upvalue11 )
Upvalue1.Backdrop.Activated:Connect( function()
    if not Upvalue5 then
        return
    end

    local Text

    if Upvalue12.IsGamepad then
        Text = "pad"
    elseif Upvalue13:GetLastInputType( ) == Enum.UserInputType.Touch then
        Text = "touch"
    else
        Text = "mouse"
    end
    if Text ~= "mouse" or not Upvalue14 then
        if not Upvalue5 then
            return
        end

        Upvalue5 = false
        Upvalue8( nil )

        if Upvalue1 then
            Upvalue1.Enabled = false
        end

        Upvalue9.Close( "EmoteWheel" )
    else
        local Entry = Upvalue7[ Upvalue14 ]

        if Upvalue5 then
            Upvalue5 = false
            Upvalue8( nil )

            if Upvalue1 then
                Upvalue1.Enabled = false
            end

            Upvalue9.Close( "EmoteWheel" )
        end
        if Entry then
            Upvalue10( Entry )
            return
        end
    end
end )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if not Upvalue1 then
        return
    end

    Upvalue1 = false
    Upvalue2( nil )

    if Upvalue3 then
        Upvalue3.Enabled = false
    end

    Upvalue4.Close( "EmoteWheel" )
    return
end
if Upvalue5 then
    Upvalue6( )
    return
end
Upvalue7( )
return
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 or not Upvalue1.Is( "Dance", Argument1 ) then
    return
end
if Upvalue2 then
    if not Upvalue2 then
        return
    end

    Upvalue2 = false
    Upvalue3( nil )

    if Upvalue4 then
        Upvalue4.Enabled = false
    end

    Upvalue5.Close( "EmoteWheel" )
    return
end
if Upvalue6 then
    Upvalue7( )
    return
end
Upvalue8( )
return
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

local HUDButtons = Upvalue1:WaitForChild( "PlayerGui" ):WaitForChild( "HUDButtons", math.huge )
local EmotesButton = HUDButtons:FindFirstChild( "EmotesButton", true )

while not EmotesButton do
    HUDButtons.DescendantAdded:Wait( )
    EmotesButton = HUDButtons:FindFirstChild( "EmotesButton", true )
end

EmotesButton.Activated:Connect( Upvalue2 )
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.Volume = Argument2.volume or 1.2

if Argument2.start then
    Argument1.PlaybackRegionsEnabled = true
    Argument1.LoopRegion = NumberRange.new( Argument2.start, Argument2.start + Argument2.len )
    Argument1.PlaybackRegion = NumberRange.new( Argument2.start, Argument2.start + Argument2.len )
    return
end
Argument1.PlaybackRegionsEnabled = false
return
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ SpotName ]

if Entry then
    if Entry.music ~= Music then
        local Sound2
        Entry.music = Music
        local Sound = Entry.sound

        if Music.warm then
            local Clone = Music.warm:Clone( )

            if Clone then
                Sound2 = Clone
            else
                Sound2 = Sound:Clone( )
            end
        else
            Sound2 = Sound:Clone( )
        end

        Sound2.SoundId = Music.id
        Sound2.Looped = true
        Sound2.RollOffMode = Sound.RollOffMode
        local RollOffMinDistance = Sound.RollOffMinDistance
        local RollOffMaxDistance = Sound.RollOffMaxDistance
        Sound2.RollOffMinDistance = RollOffMinDistance
        Sound2.RollOffMaxDistance = RollOffMaxDistance
        Upvalue2( Sound2, Music )
        Sound2.Parent = Entry.part
        Sound:Destroy( )
        Entry.sound = Sound2
        Entry.nextSync = 0
    end

    return Entry
end
local Sound3
local Parent = Instance.new( "Part" )
Parent.Name = tostring( SpotName )
Parent.Anchored = true
Parent.CanCollide = false
Parent.CanQuery = false
Parent.CanTouch = false
Parent.Transparency = 1
Parent.Size = Vector3.new( 0.20000000298023224, 0.20000000298023224, 0.20000000298023224 )
Parent.Parent = Upvalue3

if Music.warm then
    local Clone2 = Music.warm:Clone( )

    if Clone2 then
        Sound3 = Clone2
    else
        Sound3 = Instance.new( "Sound" )
    end
else
    Sound3 = Instance.new( "Sound" )
end

Sound3.Name = "DanceMusic"
Sound3.SoundId = Music.id
Upvalue2( Sound3, Music )
Sound3.Looped = true
Sound3.Volume = Music.volume or 1.2
Sound3.RollOffMode = Enum.RollOffMode.InverseTapered
Sound3.RollOffMinDistance = 10
Sound3.RollOffMaxDistance = 90
Sound3.Parent = Parent
local Table = { part = Parent, sound = Sound3, nextSync = 0, music = Music }
Upvalue1[ SpotName ] = Table
return Table
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

local Sound = Argument1.sound
local Music = Argument1.music

if not Sound.IsLoaded then
    Argument1.nextSync = 0
    return
end

local TimePosition = ( Music.start or 0 ) + ( workspace:GetServerTimeNow( ) - Argument2 + Music.offset ) % Music.len

if Sound.IsPlaying then
    local Abs = math.abs( Sound.TimePosition - TimePosition )

    if Argument1.force or math.min( Abs, Music.len - Abs ) > 0.06 then
        Sound.TimePosition = TimePosition
    end
else
    Sound.TimePosition = TimePosition
    Sound:Play( )
end

Argument1.force = nil
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceJoinPrompt = Parent:FindFirstChild( "DanceJoinPrompt" )

if Argument3 and not DanceJoinPrompt then
    local ProximityPrompt = Instance.new( "ProximityPrompt" )
    ProximityPrompt.Name = "DanceJoinPrompt"
    ProximityPrompt.ActionText = "Dance with " .. Player.DisplayName
    ProximityPrompt.ObjectText = "Sync"
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
    ProximityPrompt.GamepadKeyCode = Enum.KeyCode.ButtonY
    ProximityPrompt:AddTag( "InteractPrompt" )
    ProximityPrompt.HoldDuration = 0
    ProximityPrompt.MaxActivationDistance = 12
    ProximityPrompt.RequiresLineOfSight = false
    ProximityPrompt.Parent = Parent
    ProximityPrompt.Triggered:Connect( function()
        Upvalue1( Player )
    end )
    return
end
if not Argument3 and DanceJoinPrompt then
    DanceJoinPrompt:Destroy( )
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local Root
local LowerTorso = Self:FindFirstChild( "LowerTorso" )

if LowerTorso then
    Root = LowerTorso:FindFirstChild( "Root" )
else
    Root = LowerTorso
end
if not Root then
    return
end

local Transform
local Sample, Sample2, Sample3 = Upvalue1.Sample( Argument4, Argument2 )
local CFrame2 = CFrame.new( Sample.X, Sample.Y - Argument4.baseY, Sample.Z ) * Sample2

if not ( Amount >= 1 ) or not CFrame2 then
    Transform = Root.Transform:Lerp( CFrame2, Amount )
else
    Transform = CFrame2
end

local Value1
Root.Transform = Transform
Value1 = nil

for Key, Value in Sample3, nil, nil do
    local FoundChild2
    local FoundChild = Self:FindFirstChild( Upvalue2[ Key ] or "" )

    if FoundChild then
        FoundChild2 = FoundChild:FindFirstChild( Key )
    else
        FoundChild2 = FoundChild
    end
    if FoundChild2 then
        local Transform2

        if not ( Amount >= 1 ) or not Value then
            Transform2 = FoundChild2.Transform:Lerp( Value, Amount )
        else
            Transform2 = Value
        end

        FoundChild2.Transform = Transform2
    end
end
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )
local Position = Upvalue1.CFrame.Position

if Upvalue2 then
    local Humanoid
    local Character = Upvalue3.Character

    if Character then
        Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
    else
        Humanoid = Character
    end
    if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart or Character:FindFirstChildOfClass( "Tool" ) or Upvalue4.Crouching or Upvalue4.Rolling or Character:GetAttribute( "Downed" ) or Upvalue5( Upvalue3 ) then
        Upvalue6( )
    end
end
if Upvalue7 and not Upvalue8( ) then
    if Upvalue7 then
        Upvalue7 = false
        Upvalue9( nil )

        if Upvalue10 then
            Upvalue10.Enabled = false
        end

        Upvalue11.Close( "EmoteWheel" )
    end
end

local DanceGroup
local Character2 = Upvalue3.Character

if Upvalue2 then
    if Character2 then
        DanceGroup = Character2:GetAttribute( "DanceGroup" )
    else
        DanceGroup = Character2
    end
else
    DanceGroup = Upvalue2
end

local Table = { }

for Key, Value in Upvalue12:GetPlayers( ) do
    local HumanoidRootPart
    local Character3 = Value.Character

    if Character3 then
        HumanoidRootPart = Character3:FindFirstChild( "HumanoidRootPart" )
    else
        HumanoidRootPart = Character3
    end
    if HumanoidRootPart then
        local DanceStart = Character3:GetAttribute( "DanceStart" )
        local DanceSpeed = Character3:GetAttribute( "DanceSpeed" )

        if Value ~= Upvalue3 then
            local Flag
            local Humanoid2 = Character3:FindFirstChildOfClass( "Humanoid" )

            if DanceStart == nil then
                Flag = false
            elseif Humanoid2 == nil then
                Flag = false
            elseif Humanoid2.Health > 0 then
                local Captured

                if DanceGroup then
                    if DanceGroup == Character3:GetAttribute( "DanceGroup" ) then
                        Captured = true
                    else
                        Captured = false
                    end
                else
                    Captured = DanceGroup
                end

                local NotCaptured = not Captured

                if NotCaptured then
                    local IsMissing = not Upvalue5( Upvalue3 )

                    if IsMissing then
                        Flag = not Upvalue5( Value )
                    else
                        Flag = IsMissing
                    end
                else
                    Flag = NotCaptured
                end
            else
                Flag = false
            end

            Upvalue13( Value, HumanoidRootPart, Flag )
        end

        local Entry = Upvalue14[ Character3 ]

        if not DanceStart or not DanceSpeed then
            if Entry then
                Entry.endAt = Entry.endAt or Clock
                local Clock2 = ( Clock - Entry.endAt ) / 0.2

                if Clock2 >= 1 or not Entry.lastPhase then
                    Upvalue14[ Character3 ] = nil
                else
                    local Clip3
                    local LastPhase2 = Entry.lastPhase
                    local Clock3 = 1 - Clock2
                    local Clip2 = Entry.clip
                    Clip3 = if Clip2 then Clip2 else Upvalue18
                    Upvalue17( Character3, LastPhase2, Clock3, Clip3 )
                end
            end
        else
            local Entry3
            local Entry2 = Upvalue15[ Character3:GetAttribute( "DanceId" ) or "Phonk" ]
            Entry3 = if Entry2 then Entry2 else Upvalue15.Phonk
            local Entry6

            if not Entry or Entry.endAt or Entry.clip ~= Entry3.clip then
                local Table2 = { t0 = Clock }
                Upvalue14[ Character3 ] = Table2
                Entry6 = Table2
            else
                Entry6 = Entry
            end

            local Entry5

            if Value == Upvalue3 then
                local Entry4 = Upvalue16[ Character3:GetAttribute( "DanceId" ) or "" ]

                if Entry4 then
                    Entry5 = Entry4
                else
                    Entry5 = 0
                end
            else
                Entry5 = 0
            end

            local DanceStart2 = DanceStart + Entry5
            local Length = Entry3.clip.length
            local LastPhase = ( workspace:GetServerTimeNow( ) - DanceStart2 ) * DanceSpeed % Length
            local Clip = Entry3.clip
            Entry6.lastPhase = LastPhase
            Entry6.clip = Clip

            if Entry3.music and ( HumanoidRootPart.Position - Position ).Magnitude < 300 then
                local DanceGroup3
                local DanceGroup2 = Character3:GetAttribute( "DanceGroup" )
                DanceGroup3 = if DanceGroup2 then DanceGroup2 else Character3.Name
                local Entry8
                local Entry7 = Table[ DanceGroup3 ]

                if Entry7 then
                    Entry8 = Entry7
                else
                    local Table3 = {
                        sum = Vector3.new( 0, 0, 0 ),
                        n = 0,
                        t0 = Character3:GetAttribute( "DanceMusicStart" ) or DanceStart,
                        music = Entry3.music
                    }
                    Table[ DanceGroup3 ] = Table3
                    Entry8 = Table3
                end

                Entry8.sum = Entry8.sum + HumanoidRootPart.Position
                Entry8.n = Entry8.n + 1
            end
            if ( HumanoidRootPart.Position - Position ).Magnitude < 300 then
                Upvalue17( Character3, LastPhase, math.clamp( ( Clock - Entry6.t0 ) / 0.25, 0, 1 ), Entry3.clip )
            end
        end
    end
end

local Value1 = nil

for Value2 in Upvalue14, nil, nil do
    if not Value2.Parent then
        Upvalue14[ Value2 ] = nil
    end
end

local Value3 = nil

for Key2, Value4 in Table, nil, nil do
    local Value7 = Upvalue19( Key2, Value4.music )
    local Part = Value7.part
    Part.CFrame = CFrame.new( Value4.sum / Value4.n )

    if Value7.nextSync <= Clock then
        Value7.nextSync = Clock + 0.5
        Upvalue20( Value7, Value4.t0 )
    end
end

local Value5 = nil

for Key3, Value6 in Upvalue21, nil, nil do
    if not Table[ Key3 ] then
        Value6.part:Destroy( )
        Upvalue21[ Key3 ] = nil
    end
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end
if not DanceId or not Upvalue3[ DanceId ] then
    return nil
end
return DanceId, Upvalue3[ DanceId ], Character
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceGroup2
local DanceGroup = Self:GetAttribute( "DanceGroup" )
DanceGroup2 = if DanceGroup then DanceGroup else Self.Name
local Entry2
local Entry = Upvalue1[ DanceGroup2 ]
Entry2 = if Entry then Entry.sound else Entry
return Entry2
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 and Upvalue3 then
    Upvalue4:FireServer( true, Upvalue5, Upvalue6 )
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ SpeedName ]
local Speed = math.clamp( math.round( Amount * 100000 ) / 100000, 0.25, 3 )
Entry.speed = Speed

if SpeedName == "Phonk" then
    Upvalue2 = Speed
end

local Character = Upvalue3.Character

if Upvalue4 and Character and Character:GetAttribute( "DanceId" ) == SpeedName then
    local DanceStart = Character:GetAttribute( "DanceStart" )
    local DanceSpeed = Character:GetAttribute( "DanceSpeed" )

    if DanceStart and DanceSpeed then
        local ServerTimeNow = workspace:GetServerTimeNow( )
        Character:SetAttribute( "DanceStart", ServerTimeNow - ( ServerTimeNow - DanceStart ) * DanceSpeed / Speed )
        Character:SetAttribute( "DanceSpeed", Speed )
    end

    local Clock = os.clock( )
    Upvalue5 = Clock
    task.delay( 0.12, function()
        if Upvalue5 == Clock and Upvalue4 then
            Upvalue6:FireServer( true, Speed, SpeedName )
        end
    end )
end
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

local Instance2 = Instance.new( Argument1 )
Instance2.Name = Name
Instance2.Position = UDim2.fromOffset( Argument4, Argument5 )
Instance2.Size = UDim2.fromOffset( Argument6, Argument7 )
Instance2.BorderSizePixel = 0
Instance2.Parent = Parent
return Instance2
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local TextLabel = Instance.new( "TextLabel" )
TextLabel.Name = Name
TextLabel.Position = UDim2.fromOffset( Argument3, Argument4 )
TextLabel.Size = UDim2.fromOffset( Argument5, Argument6 )
TextLabel.BorderSizePixel = 0
TextLabel.Parent = Parent
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.new( 1, 1, 1 )
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = TextSize
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Text = Name2 or ""
return TextLabel
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

local TextButton = Instance.new( "TextButton" )
TextButton.Name = Name
TextButton.Position = UDim2.fromOffset( Argument3, Argument4 )
TextButton.Size = UDim2.fromOffset( Item, 28 )
TextButton.BorderSizePixel = 0
TextButton.Parent = Parent
TextButton.BackgroundColor3 = BackgroundColor3 or Color3.fromRGB( 50, 50, 60 )
TextButton.TextColor3 = Color3.new( 1, 1, 1 )
TextButton.Font = Enum.Font.GothamBold
TextButton.TextSize = 13
TextButton.Text = Text
TextButton.AutoButtonColor = true
local UICorner = Instance.new( "UICorner", TextButton )
UICorner.CornerRadius = UDim.new( 0, 5 )
TextButton.Activated:Connect( Callback )
return TextButton
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

local Frame = Instance.new( "Frame" )
Frame.Name = Name
Frame.Position = UDim2.fromOffset( Amount, 38 )
Frame.Size = UDim2.fromOffset( 24, 24 )
Frame.BorderSizePixel = 0
Frame.Parent = Upvalue1
Frame.BackgroundColor3 = Color3.fromRGB( 45, 45, 52 )
local UICorner = Instance.new( "UICorner", Frame )
UICorner.CornerRadius = UDim.new( 0.5, 0 )
local Text = Name .. "Text"
Upvalue2( Upvalue1, Text, Amount + 30, 38, 70, 24, 14, Name2 )
return Frame
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured, Entry

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
    Entry = nil
else
    Captured = DanceId
    Entry = Upvalue3[ DanceId ]
end
if not Captured then
    return
end

local Value1
local Music = Entry.music
Music.offset = math.round( ( Music.offset + Upvalue4[ 2 ] ) * 1000 ) / 1000
Value1 = nil

for Key, Value in Upvalue5, nil, nil do
    Value.nextSync = 0
    Value.force = true
end
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured, Entry

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
    Entry = nil
else
    Captured = DanceId
    Entry = Upvalue3[ DanceId ]
end
if not Captured then
    return
end

local Item2

if math.abs( Upvalue4[ 2 ] ) == 0.5 then
    local Item = Upvalue4[ 2 ] * Entry.music.len / ( Entry.music.beats or 16 )

    if Item then
        Item2 = Item
    else
        Item2 = Upvalue4[ 2 ]
    end
else
    Item2 = Upvalue4[ 2 ]
end

Upvalue5[ Captured ] = math.round( ( ( Upvalue5[ Captured ] or 0 ) + Item2 ) * 1000 ) / 1000
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured, Entry

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
    Entry = nil
else
    Captured = DanceId
    Entry = Upvalue3[ DanceId ]
end
if not Captured then
    return
end
if Upvalue4[ 2 ] == 0 then
    Upvalue5( Captured, Entry.clip.length / Entry.music.len )
    return
end
Upvalue5( Captured, ( Entry.speed or 1 ) + Upvalue4[ 2 ] )
return
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
else
    local Entry = Upvalue3[ DanceId ]
    Captured = DanceId
end
if Captured then
    Upvalue4( )
    task.delay( 0.15, function()
        Upvalue5( Captured )
    end )
    return
end
return
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured, Entry

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
    Entry = nil
else
    Captured = DanceId
    Entry = Upvalue3[ DanceId ]
end
if Captured then
    print( ( "[Danse] %s : décalage musique = %+.3f s | décalage danse = %+.3f s | vitesse = %.5f (boucle danse %.4f s, musique %.4f s, Synced = %.5f)" ):format( Captured, Entry.music.offset, Upvalue4[ Captured ] or 0, Entry.speed or 1, Entry.clip.length / ( Entry.speed or 1 ), Entry.music.len, Entry.clip.length / Entry.music.len ) )
    return
end
return
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = not Upvalue1
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local DanceId
local Character = Upvalue1.Character

if Upvalue2 then
    if Character then
        DanceId = Character:GetAttribute( "DanceId" )
    else
        DanceId = Character
    end
else
    DanceId = Upvalue2
end

local Captured, Entry, Character2

if not DanceId or not Upvalue3[ DanceId ] then
    Captured = nil
    Entry = nil
    Character2 = nil
else
    Captured = DanceId
    Entry = Upvalue3[ DanceId ]
    Character2 = Character
end

local Visible = Captured ~= nil and true or false
local Visible2
Upvalue4.Visible = Visible

if Upvalue6 then
    if Captured == nil then
        Visible2 = false
    else
        Visible2 = true
    end
else
    Visible2 = Upvalue6
end

Upvalue5.Visible = Visible2

if not Upvalue5.Visible then
    return
end

local DanceSpeed2
local Music = Entry.music
local DanceSpeed = Character2:GetAttribute( "DanceSpeed" )

if DanceSpeed then
    DanceSpeed2 = DanceSpeed
else
    local Speed = Entry.speed

    if Speed then
        DanceSpeed2 = Speed
    else
        DanceSpeed2 = 1
    end
end

local ServerTimeNow2
local DanceStart = Character2:GetAttribute( "DanceStart" )
local Length = Entry.clip.length

if DanceStart then
    local DanceStart2 = DanceStart + ( Upvalue7[ Captured ] or 0 )
    local ServerTimeNow = ( workspace:GetServerTimeNow( ) - DanceStart2 ) * DanceSpeed2 % Length

    if ServerTimeNow then
        ServerTimeNow2 = ServerTimeNow
    else
        ServerTimeNow2 = 0
    end
else
    ServerTimeNow2 = 0
end

local DanceGroup2
local DanceGroup = Character2:GetAttribute( "DanceGroup" )
DanceGroup2 = if DanceGroup then DanceGroup else Character2.Name
local Entry3
local Entry2 = Upvalue8[ DanceGroup2 ]
Entry3 = if Entry2 then Entry2.sound else Entry2
local TimePosition = Entry3 and Entry3.IsPlaying and Entry3.TimePosition or nil
local FoundChild

if Upvalue9 then
    FoundChild = Upvalue9.Slots:FindFirstChild( Captured )
else
    FoundChild = Upvalue9
end

local Label = FoundChild and FoundChild:GetAttribute( "Label" ) or Captured
local Text
Upvalue10.Text = "DANCE SYNC  ·  " .. Label
Upvalue11.Text = ( "Music offset %+.3f s" ):format( Music.offset )
Upvalue12.Text = ( "Dance shift %+.3f s" ):format( Upvalue7[ Captured ] or 0 )
local Speed2 = Entry.speed or 1
Text = not ( math.abs( ( Entry.speed or 1 ) - Length / Music.len ) < 1e-05 ) and "" or " (synced)"
Upvalue13.Text = ( "Speed %.5f%s" ):format( Speed2, Text )
local Beats = Music.beats

if not Beats or not Entry.beat0 or not TimePosition then
    local Text3
    Upvalue14 = nil
    Upvalue16 = nil
    Upvalue18 = nil
    Text3 = not Beats and "gap: beats unknown (this dance)" or "gap: waiting for music"
    local Format
    Upvalue19.Text = Text3
    Upvalue19.TextColor3 = Color3.fromRGB( 200, 200, 210 )
    Format = TimePosition and ( "%.2f" ):format( TimePosition ) or "-"
    Upvalue20.Text = ( "music %s / %.2f s\ndance %.2f / %.2f s" ):format( Format, ( Music.start or 0 ) + Music.len, ServerTimeNow2, Length )
else
    local Len = Music.len / Beats
    local TimePosition2 = ( TimePosition - ( Music.beat0 or 0 ) ) / Len
    local ServerTimeNow3 = ( ServerTimeNow2 - Entry.beat0 ) / ( Length / Beats )
    local Floor = math.floor( TimePosition2 )
    local Floor2 = math.floor( ServerTimeNow3 )

    if Upvalue14 and Floor ~= Upvalue14 then
        Upvalue15 = 1
    end
    if Upvalue16 and Floor2 ~= Upvalue16 then
        Upvalue17 = 1
    end

    local Captured3
    Upvalue14 = Floor
    Upvalue16 = Floor2
    local TimePosition3 = ( TimePosition2 % 1 - ServerTimeNow3 % 1 + 0.5 ) % 1 - 0.5

    if Upvalue18 then
        local Captured2 = Upvalue18 + ( TimePosition3 - Upvalue18 ) * math.min( 1, Amount * 4 )

        if Captured2 then
            Captured3 = Captured2
        else
            Captured3 = TimePosition3
        end
    else
        Captured3 = TimePosition3
    end

    local Text2
    Upvalue18 = Captured3
    local Captured4 = Upvalue18 * Len * 1000
    local Round = math.round( Captured4 )

    if math.abs( Captured4 ) <= 15 then
        Text2 = "  ✓"
    elseif Captured4 > 0 then
        Text2 = "  (dance late)"
    else
        Text2 = "  (dance early)"
    end

    local TextColor3
    Upvalue19.Text = ( "gap %+d ms%s" ):format( Round, Text2 )

    if math.abs( Captured4 ) <= 15 then
        local FromRGB = Color3.fromRGB( 110, 230, 130 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 255, 200, 90 )
        end
    else
        TextColor3 = Color3.fromRGB( 255, 200, 90 )
    end

    Upvalue19.TextColor3 = TextColor3
    local Start = ( Music.start or 0 ) + Music.len
    local Floor3 = Floor % Beats + 1
    Upvalue20.Text = ( "music %.2f / %.2f s · beat %d/%d\ndance %.2f / %.2f s · beat %d/%d" ):format( TimePosition, Start, Floor3, Beats, ServerTimeNow2, Length, Floor2 % Beats + 1, Beats )
end

Upvalue15 = math.max( 0, Upvalue15 - Amount * 7 )
Upvalue17 = math.max( 0, Upvalue17 - Amount * 7 )
Upvalue21.BackgroundColor3 = Upvalue22:Lerp( Upvalue23, Upvalue15 )
Upvalue24.BackgroundColor3 = Upvalue22:Lerp( Color3.fromRGB( 90, 200, 255 ), Upvalue17 )
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Number5
local Parent = Instance.new( "ScreenGui" )
Parent.Name = "DanceSyncPanel"
Parent.ResetOnSpawn = false
Parent.DisplayOrder = 50

local function Box( Argument1, Name, Parent, Argument4, Argument5, Argument6, Argument7 )
    local Instance2 = Instance.new( Argument1 )
    Instance2.Name = Name
    Instance2.Position = UDim2.fromOffset( Argument4, Argument5 )
    Instance2.Size = UDim2.fromOffset( Argument6, Argument7 )
    Instance2.BorderSizePixel = 0
    Instance2.Parent = Parent
    return Instance2
end

local function Label( Parent, Name, Argument3, Argument4, Argument5, Argument6, TextSize, Name2 )
    local TextLabel = Instance.new( "TextLabel" )
    TextLabel.Name = Name
    TextLabel.Position = UDim2.fromOffset( Argument3, Argument4 )
    TextLabel.Size = UDim2.fromOffset( Argument5, Argument6 )
    TextLabel.BorderSizePixel = 0
    TextLabel.Parent = Parent
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextColor3 = Color3.new( 1, 1, 1 )
    TextLabel.Font = Enum.Font.GothamBold
    TextLabel.TextSize = TextSize
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = Name2 or ""
    return TextLabel
end

local function Button( Parent, Name, Argument3, Argument4, Item, Text, Callback, BackgroundColor3 )
    local TextButton = Instance.new( "TextButton" )
    TextButton.Name = Name
    TextButton.Position = UDim2.fromOffset( Argument3, Argument4 )
    TextButton.Size = UDim2.fromOffset( Item, 28 )
    TextButton.BorderSizePixel = 0
    TextButton.Parent = Parent
    TextButton.BackgroundColor3 = BackgroundColor3 or Color3.fromRGB( 50, 50, 60 )
    TextButton.TextColor3 = Color3.new( 1, 1, 1 )
    TextButton.Font = Enum.Font.GothamBold
    TextButton.TextSize = 13
    TextButton.Text = Text
    TextButton.AutoButtonColor = true
    local UICorner = Instance.new( "UICorner", TextButton )
    UICorner.CornerRadius = UDim.new( 0, 5 )
    TextButton.Activated:Connect( Callback )
    return TextButton
end

local Button2 = Button( Parent, "Open", 16, 660, 150, "Dance sync", function()
end, Color3.fromRGB( 25, 25, 30 ) )
Button2.Size = UDim2.fromOffset( 150, 34 )
Button2.TextSize = 14
Button2.Visible = false
local Frame = Instance.new( "Frame" )
Frame.Name = "Panel"
Frame.Position = UDim2.fromOffset( 172, 404 )
Frame.Size = UDim2.fromOffset( 470, 292 )
Frame.BorderSizePixel = 0
Frame.Parent = Parent
Frame.BackgroundColor3 = Color3.fromRGB( 20, 20, 26 )
Frame.BackgroundTransparency = 0.1
Frame.Visible = false
local UICorner = Instance.new( "UICorner", Frame )
UICorner.CornerRadius = UDim.new( 0, 6 )
local Label2 = Label( Frame, "Title", 12, 6, 446, 24, 16, "DANCE SYNC" )

local function Light( Name, Amount, Name2 )
    local FrameInner = Instance.new( "Frame" )
    FrameInner.Name = Name
    FrameInner.Position = UDim2.fromOffset( Amount, 38 )
    FrameInner.Size = UDim2.fromOffset( 24, 24 )
    FrameInner.BorderSizePixel = 0
    FrameInner.Parent = Frame
    FrameInner.BackgroundColor3 = Color3.fromRGB( 45, 45, 52 )
    local UICorner = Instance.new( "UICorner", FrameInner )
    UICorner.CornerRadius = UDim.new( 0.5, 0 )
    local Text = Name .. "Text"
    Label( Frame, Text, Amount + 30, 38, 70, 24, 14, Name2 )
    return FrameInner
end

local Light2 = Light( "MusicLight", 12, "MUSIC" )
local Light3 = Light( "DanceLight", 118, "DANCE" )
local Label3 = Label( Frame, "Gap", 226, 38, 232, 24, 15, "" )
local Label4 = Label( Frame, "Info", 12, 68, 446, 38, 13, "" )
Label4.TextYAlignment = Enum.TextYAlignment.Top
Label4.TextColor3 = Color3.fromRGB( 200, 200, 210 )
local Label5 = Label( Frame, "OffsetText", 12, 112, 160, 28, 13, "" )
local Table = {
    { "-0.05", -0.05, 50 },
    { "-0.01", -0.01, 46 },
    { "-.001", -0.001, 44 },
    { "+.001", 0.001, 44 },
    { "+0.01", 0.01, 46 },
    { "+0.05", 0.05, 50 }
}
Value1 = nil
Number5 = 172

for Key, Value in Table, nil, nil do
    local Text3 = "Off" .. Value[ 1 ]
    Button( Frame, Text3, Number5, 112, Value[ 3 ], Value[ 1 ], function()
        local DanceId
        local Character = Upvalue1.Character

        if Upvalue2 then
            if Character then
                DanceId = Character:GetAttribute( "DanceId" )
            else
                DanceId = Character
            end
        else
            DanceId = Upvalue2
        end

        local Captured, Entry

        if not DanceId or not Upvalue3[ DanceId ] then
            Captured = nil
            Entry = nil
        else
            Captured = DanceId
            Entry = Upvalue3[ DanceId ]
        end
        if not Captured then
            return
        end

        local Value1
        local Music = Entry.music
        Music.offset = math.round( ( Music.offset + Value[ 2 ] ) * 1000 ) / 1000
        Value1 = nil

        for Key, ValueInner in Upvalue4, nil, nil do
            ValueInner.nextSync = 0
            ValueInner.force = true
        end
    end )
    Number5 = Number5 + ( Value[ 3 ] + 4 )
end

local Value2, Number4
local Label6 = Label( Frame, "ShiftText", 12, 148, 160, 28, 13, "" )
local Table2 = {
    { "-½ beat", -0.5, 66 },
    { "-0.01", -0.01, 46 },
    { "-.001", -0.001, 44 },
    { "+.001", 0.001, 44 },
    { "+0.01", 0.01, 46 },
    { "+½ beat", 0.5, 66 }
}
Value2 = nil
Number4 = 172

for Key2, Value3 in Table2, nil, nil do
    local Text2 = "Shift" .. Value3[ 1 ]
    Button( Frame, Text2, Number4, 148, Value3[ 3 ], Value3[ 1 ], function()
        local DanceId
        local Character = Upvalue1.Character

        if Upvalue2 then
            if Character then
                DanceId = Character:GetAttribute( "DanceId" )
            else
                DanceId = Character
            end
        else
            DanceId = Upvalue2
        end

        local Captured, Entry

        if not DanceId or not Upvalue3[ DanceId ] then
            Captured = nil
            Entry = nil
        else
            Captured = DanceId
            Entry = Upvalue3[ DanceId ]
        end
        if not Captured then
            return
        end

        local Item2

        if math.abs( Value3[ 2 ] ) == 0.5 then
            local Item = Value3[ 2 ] * Entry.music.len / ( Entry.music.beats or 16 )

            if Item then
                Item2 = Item
            else
                Item2 = Value3[ 2 ]
            end
        else
            Item2 = Value3[ 2 ]
        end

        Upvalue5[ Captured ] = math.round( ( ( Upvalue5[ Captured ] or 0 ) + Item2 ) * 1000 ) / 1000
    end, Color3.fromRGB( 60, 50, 90 ) )
    Number4 = Number4 + ( Value3[ 3 ] + 4 )
end

local Value4, Number3
local Label7 = Label( Frame, "SpeedText", 12, 184, 160, 28, 13, "" )
local Table3 = {
    { "-0.01", -0.01, 50 },
    { "-.001", -0.001, 46 },
    { "Synced", 0, 64 },
    { "+.001", 0.001, 46 },
    { "+0.01", 0.01, 50 }
}
Value4 = nil
Number3 = 172

for Key3, Value5 in Table3, nil, nil do
    local FromRGB4
    local Text = "Spd" .. Value5[ 1 ]
    local Item = Value5[ 3 ]
    local Item2 = Value5[ 1 ]

    local function Callback()
        local DanceId
        local Character = Upvalue1.Character

        if Upvalue2 then
            if Character then
                DanceId = Character:GetAttribute( "DanceId" )
            else
                DanceId = Character
            end
        else
            DanceId = Upvalue2
        end

        local Captured, Entry

        if not DanceId or not Upvalue3[ DanceId ] then
            Captured = nil
            Entry = nil
        else
            Captured = DanceId
            Entry = Upvalue3[ DanceId ]
        end
        if not Captured then
            return
        end
        if Value5[ 2 ] == 0 then
            Upvalue6( Captured, Entry.clip.length / Entry.music.len )
            return
        end
        Upvalue6( Captured, ( Entry.speed or 1 ) + Value5[ 2 ] )
        return
    end

    if Value5[ 2 ] == 0 then
        local FromRGB3 = Color3.fromRGB( 40, 110, 70 )

        if FromRGB3 then
            FromRGB4 = FromRGB3
        else
            FromRGB4 = nil
        end
    else
        FromRGB4 = nil
    end

    Button( Frame, Text, Number3, 184, Item, Item2, Callback, FromRGB4 )
    Number3 = Number3 + ( Value5[ 3 ] + 4 )
end

Button( Frame, "Restart", 12, 222, 140, "Restart (loop start)", function()
    local DanceId
    local Character = Upvalue1.Character

    if Upvalue2 then
        if Character then
            DanceId = Character:GetAttribute( "DanceId" )
        else
            DanceId = Character
        end
    else
        DanceId = Upvalue2
    end

    local Captured

    if not DanceId or not Upvalue3[ DanceId ] then
        Captured = nil
    else
        local Entry = Upvalue3[ DanceId ]
        Captured = DanceId
    end
    if Captured then
        Upvalue7( )
        task.delay( 0.15, function()
            Upvalue8( Captured )
        end )
        return
    end
    return
end, Color3.fromRGB( 150, 90, 30 ) )
Button( Frame, "Print", 158, 222, 300, "Print values (Output / F9)", function()
    local DanceId
    local Character = Upvalue1.Character

    if Upvalue2 then
        if Character then
            DanceId = Character:GetAttribute( "DanceId" )
        else
            DanceId = Character
        end
    else
        DanceId = Upvalue2
    end

    local Captured, Entry

    if not DanceId or not Upvalue3[ DanceId ] then
        Captured = nil
        Entry = nil
    else
        Captured = DanceId
        Entry = Upvalue3[ DanceId ]
    end
    if Captured then
        print( ( "[Danse] %s : décalage musique = %+.3f s | décalage danse = %+.3f s | vitesse = %.5f (boucle danse %.4f s, musique %.4f s, Synced = %.5f)" ):format( Captured, Entry.music.offset, Upvalue5[ Captured ] or 0, Entry.speed or 1, Entry.clip.length / ( Entry.speed or 1 ), Entry.music.len, Entry.clip.length / Entry.music.len ) )
        return
    end
    return
end, Color3.fromRGB( 70, 140, 255 ) )
local Label8 = Label( Frame, "Note", 12, 258, 446, 28, 11, "Music offset / Dance shift = only for you (to find the value). Speed = your whole group." )
Label8.TextColor3 = Color3.fromRGB( 150, 150, 165 )
local Flag = false
Button2.Activated:Connect( function()
    Flag = not Flag
end )
require( game:GetService( "ReplicatedStorage" ):WaitForChild( "ScaleUI" ) ).Convert( Parent )
Parent.Parent = Upvalue1:WaitForChild( "PlayerGui" )
local Value6 = nil
local Value7 = nil
local Number = 0
local Number2 = 0
local Value8 = nil
local FromRGB = Color3.fromRGB( 45, 45, 52 )
local FromRGB2 = Color3.fromRGB( 255, 170, 60 )
Upvalue9.RenderStepped:Connect( function( Amount )
    local DanceId
    local Character = Upvalue1.Character

    if Upvalue2 then
        if Character then
            DanceId = Character:GetAttribute( "DanceId" )
        else
            DanceId = Character
        end
    else
        DanceId = Upvalue2
    end

    local Captured, Entry, Character2

    if not DanceId or not Upvalue3[ DanceId ] then
        Captured = nil
        Entry = nil
        Character2 = nil
    else
        Captured = DanceId
        Entry = Upvalue3[ DanceId ]
        Character2 = Character
    end

    local Visible = Captured ~= nil and true or false
    local Visible2
    Button2.Visible = Visible

    if Flag then
        if Captured == nil then
            Visible2 = false
        else
            Visible2 = true
        end
    else
        Visible2 = Flag
    end

    Frame.Visible = Visible2

    if not Frame.Visible then
        return
    end

    local DanceSpeed2
    local Music = Entry.music
    local DanceSpeed = Character2:GetAttribute( "DanceSpeed" )

    if DanceSpeed then
        DanceSpeed2 = DanceSpeed
    else
        local Speed = Entry.speed

        if Speed then
            DanceSpeed2 = Speed
        else
            DanceSpeed2 = 1
        end
    end

    local ServerTimeNow2
    local DanceStart = Character2:GetAttribute( "DanceStart" )
    local Length = Entry.clip.length

    if DanceStart then
        local DanceStart2 = DanceStart + ( Upvalue5[ Captured ] or 0 )
        local ServerTimeNow = ( workspace:GetServerTimeNow( ) - DanceStart2 ) * DanceSpeed2 % Length

        if ServerTimeNow then
            ServerTimeNow2 = ServerTimeNow
        else
            ServerTimeNow2 = 0
        end
    else
        ServerTimeNow2 = 0
    end

    local DanceGroup2
    local DanceGroup = Character2:GetAttribute( "DanceGroup" )
    DanceGroup2 = if DanceGroup then DanceGroup else Character2.Name
    local Entry3
    local Entry2 = Upvalue4[ DanceGroup2 ]
    Entry3 = if Entry2 then Entry2.sound else Entry2
    local TimePosition = Entry3 and Entry3.IsPlaying and Entry3.TimePosition or nil
    local FoundChild

    if Upvalue10 then
        FoundChild = Upvalue10.Slots:FindFirstChild( Captured )
    else
        FoundChild = Upvalue10
    end

    local Label = FoundChild and FoundChild:GetAttribute( "Label" ) or Captured
    local Text
    Label2.Text = "DANCE SYNC  ·  " .. Label
    Label5.Text = ( "Music offset %+.3f s" ):format( Music.offset )
    Label6.Text = ( "Dance shift %+.3f s" ):format( Upvalue5[ Captured ] or 0 )
    local Speed2 = Entry.speed or 1
    Text = not ( math.abs( ( Entry.speed or 1 ) - Length / Music.len ) < 1e-05 ) and "" or " (synced)"
    Label7.Text = ( "Speed %.5f%s" ):format( Speed2, Text )
    local Beats = Music.beats

    if not Beats or not Entry.beat0 or not TimePosition then
        local Text3
        Value6 = nil
        Value7 = nil
        Value8 = nil
        Text3 = not Beats and "gap: beats unknown (this dance)" or "gap: waiting for music"
        local Format
        Label3.Text = Text3
        Label3.TextColor3 = Color3.fromRGB( 200, 200, 210 )
        Format = TimePosition and ( "%.2f" ):format( TimePosition ) or "-"
        Label4.Text = ( "music %s / %.2f s\ndance %.2f / %.2f s" ):format( Format, ( Music.start or 0 ) + Music.len, ServerTimeNow2, Length )
    else
        local Len = Music.len / Beats
        local TimePosition2 = ( TimePosition - ( Music.beat0 or 0 ) ) / Len
        local ServerTimeNow3 = ( ServerTimeNow2 - Entry.beat0 ) / ( Length / Beats )
        local Floor = math.floor( TimePosition2 )
        local Floor2 = math.floor( ServerTimeNow3 )

        if Value6 and Floor ~= Value6 then
            Number = 1
        end
        if Value7 and Floor2 ~= Value7 then
            Number2 = 1
        end

        local Captured3
        Value6 = Floor
        Value7 = Floor2
        local TimePosition3 = ( TimePosition2 % 1 - ServerTimeNow3 % 1 + 0.5 ) % 1 - 0.5

        if Value8 then
            local Captured2 = Value8 + ( TimePosition3 - Value8 ) * math.min( 1, Amount * 4 )

            if Captured2 then
                Captured3 = Captured2
            else
                Captured3 = TimePosition3
            end
        else
            Captured3 = TimePosition3
        end

        local Text2
        Value8 = Captured3
        local Captured4 = Value8 * Len * 1000
        local Round = math.round( Captured4 )

        if math.abs( Captured4 ) <= 15 then
            Text2 = "  ✓"
        elseif Captured4 > 0 then
            Text2 = "  (dance late)"
        else
            Text2 = "  (dance early)"
        end

        local TextColor3
        Label3.Text = ( "gap %+d ms%s" ):format( Round, Text2 )

        if math.abs( Captured4 ) <= 15 then
            local FromRGBInner = Color3.fromRGB( 110, 230, 130 )

            if FromRGBInner then
                TextColor3 = FromRGBInner
            else
                TextColor3 = Color3.fromRGB( 255, 200, 90 )
            end
        else
            TextColor3 = Color3.fromRGB( 255, 200, 90 )
        end

        Label3.TextColor3 = TextColor3
        local Start = ( Music.start or 0 ) + Music.len
        local Floor3 = Floor % Beats + 1
        Label4.Text = ( "music %.2f / %.2f s · beat %d/%d\ndance %.2f / %.2f s · beat %d/%d" ):format( TimePosition, Start, Floor3, Beats, ServerTimeNow2, Length, Floor2 % Beats + 1, Beats )
    end

    Number = math.max( 0, Number - Amount * 7 )
    Number2 = math.max( 0, Number2 - Amount * 7 )
    Light2.BackgroundColor3 = FromRGB:Lerp( FromRGB2, Number )
    Light3.BackgroundColor3 = FromRGB:Lerp( Color3.fromRGB( 90, 200, 255 ), Number2 )
end )
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

-- empty function
]]
