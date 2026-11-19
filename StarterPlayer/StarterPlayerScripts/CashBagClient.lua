-- StarterPlayer.StarterPlayerScripts.CashBagClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #27

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue1 = nil

if Upvalue2 then
    Upvalue2( nil )
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 then
    return
end

Upvalue1 = nil

if Upvalue3 then
    Upvalue3( nil )
end
if Upvalue4.Parent == Upvalue5.Character then
    Upvalue6:FireServer( Upvalue4 )
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Argument1 or Argument1.Parent ~= Upvalue2.Character then
    return
end

local Captured

if Upvalue3 then
    Captured = Upvalue3( )
else
    Captured = Upvalue3
end
if Captured then
    Upvalue4.Error( Captured )
    return
end

local Table = { }
Upvalue1 = Table

if Upvalue5 then
    Upvalue5( Upvalue6 )
end

task.delay( Upvalue6, function()
    if Upvalue1 ~= Table then
        return
    end

    Upvalue1 = nil

    if Upvalue5 then
        Upvalue5( nil )
    end
    if Argument1.Parent == Upvalue2.Character then
        Upvalue7:FireServer( Argument1 )
    end
end )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
        if not Upvalue1 then
            return
        end

        Upvalue1 = nil

        if Upvalue2 then
            Upvalue2( nil )
        end
    end
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.CursorFree then
    return
end
Upvalue2( Upvalue3 )
return
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if not Key:IsA( "Tool" ) or Upvalue1[ Key ] or not Upvalue2.CASH_BAGS[ Key:GetAttribute( "Item" ) or "" ] then
    return
end
Upvalue1[ Key ] = true
Key.Activated:Connect( function()
    if Upvalue3.CursorFree then
        return
    end
    Upvalue4( Key )
    return
end )
Key.Deactivated:Connect( Upvalue5 )
return
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Self.ChildAdded:Connect( Upvalue1 )

for Key, Value in Self:GetChildren( ) do
    Upvalue1( Value )
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Backpack" ) then
    Self.ChildAdded:Connect( Upvalue1 )

    for Key, Value in Self:GetChildren( ) do
        Upvalue1( Value )
    end
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Children
local Character = Upvalue1.Character
Children = Character and Character:GetChildren( ) or { }
local Value1 = nil

for Key, Value in Children, nil, nil do
    if Value:IsA( "Tool" ) then
        if Upvalue2.CASH_BAGS[ Value:GetAttribute( "Item" ) or "" ] then
            return Value
        end
    end
end

return nil
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end
if not Humanoid or Humanoid.Health <= 0 or Humanoid.SeatPart or Upvalue2.Downed or Character:GetAttribute( "Downed" ) then
    return false
end
if not Upvalue1:GetAttribute( "InTutorial" ) then
    if not Upvalue3 or not Upvalue3.Visible then
        local CombatUntil3
        local CombatUntil = Upvalue1:GetAttribute( "CombatUntil" )

        if type( CombatUntil ) == "number" then
            local CombatUntil2 = CombatUntil - workspace:GetServerTimeNow( )

            if CombatUntil2 then
                CombatUntil3 = CombatUntil2
            else
                CombatUntil3 = 0
            end
        else
            CombatUntil3 = 0
        end

        return true, ( math.max( 0, CombatUntil3 ) )
    end
end

return false
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 or not Upvalue3 or not Upvalue4 or not Upvalue5 then
    return
end

local TouchMode = Upvalue6.TouchMode( )

if Upvalue7 == Argument1 and Upvalue8 == TouchMode then
    return
end

local Number
Upvalue7 = Argument1
Upvalue8 = TouchMode
Number = if TouchMode then 0.05 else Upvalue3.X.Scale
local Size
Upvalue1.Position = UDim2.fromScale( Number, Upvalue3.Y.Scale )

if not Argument1 or not Upvalue4 then
    Size = UDim2.fromScale( 0.62 - Number, Upvalue4.Y.Scale * 0.86 )
else
    Size = Upvalue4
end

local Size2
Upvalue1.Size = Size

if not Argument1 or not Upvalue5 then
    Size2 = UDim2.fromScale( 0.26, Upvalue5.Y.Scale * 0.9 )
else
    Size2 = Upvalue5
end

Upvalue2.Size = Size2
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 or not Upvalue3 then
    return
end

local TouchMode = Upvalue4.TouchMode( )
Upvalue1.Visible = not TouchMode

if TouchMode then
    return
end
if not Upvalue4.IsGamepad then
    Upvalue3.Visible = false
    Upvalue2.Visible = true
    Upvalue2.Text = Upvalue4.KeyName( "MouseButton1", true )
    return
end

local Visible
local Glyph, Glyph2 = Upvalue4.Glyph( Enum.KeyCode.ButtonR2 )
Upvalue3.Image = Glyph or ""
Visible = Glyph ~= nil and true or false
local Visible2
Upvalue3.Visible = Visible
Visible2 = Glyph == nil and true or false
Upvalue2.Visible = Visible2
Upvalue2.Text = Glyph2 or "RT"
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2:Create( Upvalue1, TweenInfo.new( Argument2, Argument3 or Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Argument1 } ):Play( )
end
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

while Upvalue1.Enabled do
    task.wait( 0.25 )
    local _, Value1 = Upvalue2( )
    Upvalue3( )

    if not Value1 or Value1 <= 0 then
        break
    end
end

Upvalue4 = false
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end
Upvalue1 = true
task.spawn( function()
    while Upvalue2.Enabled do
        task.wait( 0.25 )
        local _, Value1 = Upvalue3( )
        Upvalue4( )

        if not Value1 or Value1 <= 0 then
            break
        end
    end

    Upvalue1 = false
end )
return
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2( )
local Enabled, Value1 = Upvalue3( )

if Upvalue1 == nil then
    Enabled = false
end
if Upvalue4.Enabled ~= Enabled then
    Upvalue4.Enabled = Enabled

    if Enabled then
        Upvalue5( )
        Upvalue6 = nil

        if Upvalue7 then
            Upvalue7.Scale = 0.86
        end

        Upvalue8( 1, 0.2, Enum.EasingStyle.Back )
    end
end
if Enabled then
    local Enabled2 = Value1 <= 0 and true or false
    Upvalue11( Enabled2 )

    if Upvalue12 and Upvalue13 then
        local Color = Enabled2 and Upvalue13 or Upvalue14
        Upvalue12.Color = Color
    end
    if Upvalue15 then
        local Text = Enabled2 and Upvalue16 or "IN COMBAT"
        Upvalue15.Text = Text
    end
    if Upvalue17 then
        local Text3

        if Enabled2 then
            local Text2 = "+" .. Upvalue18( Upvalue19.CASH_BAGS[ Upvalue1:GetAttribute( "Item" ) ] or 0 )

            if Text2 then
                Text3 = Text2
            else
                Text3 = ( "%ds" ):format( ( math.ceil( Value1 ) ) )
            end
        else
            Text3 = ( "%ds" ):format( ( math.ceil( Value1 ) ) )
        end

        local TextColor3
        Upvalue17.Text = Text3
        TextColor3 = Enabled2 and Upvalue20 or Upvalue21
        Upvalue17.TextColor3 = TextColor3

        if Upvalue22 then
            Upvalue22.Enabled = Enabled2
        end
    end
    if not Enabled2 then
        if Upvalue9 then
            Upvalue9 = nil

            if Upvalue10 then
                Upvalue10( nil )
            end
        end
        if Upvalue23 then
            return
        end

        Upvalue23 = true
        task.spawn( function()
            while Upvalue4.Enabled do
                task.wait( 0.25 )
                local _, Value1 = Upvalue3( )
                Upvalue24( )

                if not Value1 or Value1 <= 0 then
                    break
                end
            end

            Upvalue23 = false
        end )
    end

    return
end
if not Upvalue9 then
    return
end

Upvalue9 = nil

if Upvalue10 then
    Upvalue10( nil )
end

return
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Cancel( )
    Upvalue1 = nil
end
if not Upvalue2 then
    return
end

Upvalue2.Size = UDim2.fromScale( 0, 1 )

if Argument1 then
    Upvalue1 = Upvalue3:Create( Upvalue2, TweenInfo.new( Argument1, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 1, 1 ) } )
    Upvalue1:Play( )
end
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1, Value2 = Upvalue1( )

if not Value1 then
    return "You can't cash in right now"
end
if Value2 > 0 then
    return ( "You can't cash in a bag during combat (%ds)" ):format( ( math.ceil( Value2 ) ) )
end
return nil
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1( 0.94, 0.07 )
    Upvalue2( Upvalue3 )
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1( 1, 0.12 )

    if not Upvalue2 then
        return
    end

    Upvalue2 = nil

    if Upvalue3 then
        Upvalue3( nil )
    end
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil

    if Upvalue2 then
        Upvalue2( nil )
    end
end

Upvalue3( 1, 0.12 )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) then
    Upvalue1( )
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) then
    Upvalue1( )
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

Self.ChildAdded:Connect( function( Object )
    if Object:IsA( "Tool" ) then
        Upvalue1( )
    end
end )
Self.ChildRemoved:Connect( function( Object )
    if Object:IsA( "Tool" ) then
        Upvalue1( )
    end
end )
Self:GetAttributeChangedSignal( "Downed" ):Connect( Upvalue1 )
local Humanoid = Self:WaitForChild( "Humanoid", 10 )

if Humanoid then
    Humanoid:GetPropertyChangedSignal( "SeatPart" ):Connect( Upvalue1 )
    Humanoid.Died:Connect( Upvalue1 )
end

Upvalue1( )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Enabled then
    Upvalue2( )
    Upvalue3 = nil
    Upvalue4( )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Parent then
    Upvalue2:Disconnect( )
    return
end

local Clamp = math.clamp( ( os.clock( ) - Upvalue3 ) / 0.4, 0, 1 )
local Clamp2 = 1 - ( 1 - Clamp ) ^ 3
local Clamp3 = 1 - Clamp2
Upvalue1.C0 = CFrame.new( Upvalue4 * ( Clamp3 * Clamp3 ) + Upvalue5 * ( Clamp3 * 2 * Clamp2 ) + Upvalue6 * ( Clamp2 * Clamp2 ) ) * Upvalue7:Lerp( Upvalue8, Clamp2 )

if Clamp >= 1 then
    Upvalue1.C0 = Upvalue9
    Upvalue2:Disconnect( )
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Object:IsA( "Weld" ) then
    return
end
if Object:GetAttribute( "FromBack" ) then
    return
end

local Part02
local Part0 = Object.Part0
local Part1 = Object.Part1
Part02 = if Part0 then Part0.Parent else Part0
local RightHand

if Part02 then
    RightHand = Part02:FindFirstChild( "RightHand" )
else
    RightHand = Part02
end
if not Part0 or not Part1 or not RightHand then
    return
end

local CurrentCamera = workspace.CurrentCamera

if not CurrentCamera or not ( ( CurrentCamera.CFrame.Position - Part0.Position ).Magnitude > 250 ) then
    local C0 = Object.C0
    local PointToObjectSpace = Part0.CFrame:PointToObjectSpace( RightHand.Position ) + Vector3.new( 0, -0.6000000238418579, 0 )
    local Position = C0.Position
    local X = PointToObjectSpace.X
    local Max = math.max( X, Position.X ) + 0.6
    local Y = PointToObjectSpace.Y
    local Max2 = math.max( Y, Position.Y ) + 0.5
    local Vector32 = Vector3.new( Max, Max2, Position.Z + 0.7 )
    local Rotation = C0.Rotation
    local Clock = os.clock( )
    local Connect = nil
    Connect = Upvalue1.RenderStepped:Connect( function()
        if not Object.Parent then
            Connect:Disconnect( )
            return
        end

        local Clamp = math.clamp( ( os.clock( ) - Clock ) / 0.4, 0, 1 )
        local Clamp2 = 1 - ( 1 - Clamp ) ^ 3
        local Clamp3 = 1 - Clamp2
        Object.C0 = CFrame.new( PointToObjectSpace * ( Clamp3 * Clamp3 ) + Vector32 * ( Clamp3 * 2 * Clamp2 ) + Position * ( Clamp2 * Clamp2 ) ) * Upvalue2:Lerp( Rotation, Clamp2 )

        if Clamp >= 1 then
            Object.C0 = C0
            Connect:Disconnect( )
        end
    end )
    return
end
return
]]
