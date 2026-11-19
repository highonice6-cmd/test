-- Players.perkbrokeyou.PlayerGui.Inventory.InventoryClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #109

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local I = 1

for I = 1, 20 do
    if pcall( Upvalue1.SetCoreGuiEnabled, Upvalue1, Enum.CoreGuiType.PlayerList, false ) then
        return
    end

    task.wait( 0.5 )
end
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Self:GetChildren( ) do
    if Value:IsA( "UIGradient" ) then
        if Value.Enabled then
            return Value
        end
    end
end

return Self:FindFirstChildWhichIsA( "UIGradient" )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Icon = Object:WaitForChild( "Icon" )
return { pos = Icon.Position, size = Icon.Size, anchor = Icon.AnchorPoint }
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Error( "This weapon is broken: repair it first" )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1[ Key ] then
    local Entry2
    local Entry = Upvalue2.TILE_GRAD[ Key ]
    Entry2 = if Entry then Entry else Upvalue2.TILE_GRAD.gun
    local Keypoints = Entry2.Keypoints
    local Value = Keypoints[ 1 ].Value
    local Value2 = Keypoints[ #Keypoints ].Value
    Upvalue1[ Key ] = ColorSequence.new( {
        ColorSequenceKeypoint.new( 0, Value2 ),
        ColorSequenceKeypoint.new( Upvalue3, Value ),
        ColorSequenceKeypoint.new( 1, Value2 )
    } )
end

return Upvalue1[ Key ]
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = Upvalue1( Parent )

if Value1 then
    local Rotation = Upvalue2.Rotation
    local Transparency = Upvalue2.Transparency
    Value1.Rotation = Rotation
    Value1.Transparency = Transparency
end

local AmmoBar = Parent:FindFirstChild( "AmmoBar" )

if AmmoBar then
    local AnchorPoint = Upvalue3.AnchorPoint
    local Position = Upvalue3.Position
    local Size = Upvalue3.Size
    AmmoBar.AnchorPoint = AnchorPoint
    AmmoBar.Position = Position
    AmmoBar.Size = Size
end

local Ammo = Parent:FindFirstChild( "Ammo" )

if Ammo then
    local Value2
    local Table = {
        "AnchorPoint",
        "Position",
        "Size",
        "TextXAlignment",
        "TextYAlignment",
        "FontFace",
        "TextColor3"
    }
    Value2 = nil

    for Key, Value in Table, nil, nil do
        Ammo[ Value ] = Upvalue4[ Value ]
    end
end
if Upvalue5 and not Parent:FindFirstChild( "Broken" ) then
    local Clone = Upvalue5:Clone( )
    Clone.Visible = false
    Clone.Parent = Parent
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Text = ( Object:GetAttribute( "Weapon" ) or Object:GetAttribute( "Melee" ) or Object:GetAttribute( "Vehicle" ) ) and "weapon" or "item"
local Entry = Upvalue1[ Text ]
local PlaceIcon = Upvalue2.PlaceIcon
PlaceIcon( Argument1, Entry.anchor, Entry.pos, Entry.size, Upvalue2.IconScale( Object ) )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Name
local Entry = Upvalue1[ Self:GetAttribute( "Weapon" ) ]

if not Entry or not Entry.Name then
    local DisplayName = Self:GetAttribute( "DisplayName" )

    if DisplayName then
        Name = DisplayName
    else
        Name = Self.Name
    end
else
    Name = Entry.Name
end

return Name
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = tonumber( ( Self:GetAttribute( "Kg" ) ) )

if Number then
    return Upvalue1.WeightText( Number )
end

local Count = Self:GetAttribute( "Count" )

if Count and tostring( Self:GetAttribute( "Item" ) or "" ):sub( 1, 7 ) == "CashBag" and ( tonumber( Count ) or 1 ) <= 1 then
    return ""
end
if Count then
    return "x" .. Count
end

local Ammo = Self:GetAttribute( "Ammo" )
local MagSize = Self:GetAttribute( "MagSize" )

if not Self:GetAttribute( "Weapon" ) or Ammo == nil then
    return ""
end

local Text

if not MagSize or not ( Ammo .. "/" .. MagSize ) then
    Text = tostring( Ammo )
else
    Text = Ammo .. "/" .. MagSize
end

return Text
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Visible

if Amount == nil then
    Visible = false
elseif Amount > 0 then
    Visible = true
else
    Visible = false
end

Argument1.Visible = Visible

if Amount then
    Argument1.Size = UDim2.fromScale( Upvalue1 * Amount, Upvalue2 )
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

NextSelectionUp:SetAttribute( "NavManual", true )
NextSelectionUp.NextSelectionLeft = NextSelectionLeft
NextSelectionUp.NextSelectionRight = NextSelectionRight
NextSelectionUp.NextSelectionUp = NextSelectionUp
NextSelectionUp.NextSelectionDown = NextSelectionUp
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local CarId2
local CarId = Self:GetAttribute( "CarId" )
CarId2 = if CarId then CarId else Self:GetAttribute( "Vehicle" )
return CarId2
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Text == Upvalue2 then
    Upvalue1.Text = ""
end
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Text = TextName or ""

if TextName then
    task.delay( 2.5, function()
        if Upvalue1.Text == TextName then
            Upvalue1.Text = ""
        end
    end )
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Text
local Health = Upvalue1:GetAttribute( "Health" ) or 1
local MaxHealth = Upvalue1:GetAttribute( "MaxHealth" ) or 1
local Clamp = math.clamp( Health / math.max( MaxHealth, 1 ), 0, 1 )
local DisplayName = Upvalue1:GetAttribute( "DisplayName" )
Text = if DisplayName then DisplayName else Upvalue1.Name
Upvalue2.Text = Text
local Number = ( tonumber( Upvalue3:GetAttribute( "CarSpawnReadyAt" ) ) or 0 ) - workspace:GetServerTimeNow( )

if Number > 0 then
    local Ceil = math.ceil( Number )
    Upvalue4.Text = ( "%s %d:%02d" ):format( Upvalue5, Ceil // 60, Ceil % 60 )
    Upvalue6.ImageTransparency = 0.5
    Upvalue6.BackgroundTransparency = 0.5
else
    Upvalue4.Text = Upvalue5
    Upvalue6.ImageTransparency = 0
    Upvalue6.BackgroundTransparency = 0
end
if Upvalue7 then
    local VehicleCost = Upvalue8.VehicleCost
    local VehicleCost2 = VehicleCost( Health, MaxHealth, Upvalue1:GetAttribute( "Vehicle" ) )

    if Upvalue9 and Upvalue9.tool == Upvalue1 and Upvalue9.cost then
        VehicleCost2 = Upvalue9.cost
    end

    local Text3

    if VehicleCost2 then
        if VehicleCost2 > 0 then
            local Text2 = "Repair: " .. Upvalue10( VehicleCost2 )

            if Text2 then
                Text3 = Text2
            else
                Text3 = "Repair: FREE"
            end
        else
            Text3 = "Repair: FREE"
        end
    else
        Text3 = "No repair needed"
    end
    if Upvalue7.Text ~= Text3 then
        Upvalue7.Text = Text3
    end

    local TextColor3 = VehicleCost2 and Upvalue11 or Upvalue12
    Upvalue7.TextColor3 = TextColor3
end
if Upvalue9 and Upvalue9.tool == Upvalue1 then
    local Clamp2 = math.clamp( ( os.clock( ) - Upvalue9.t0 ) / Upvalue9.dur, 0, 1 )
    Upvalue13.Text = ( "Repairing... %d%%" ):format( ( math.floor( Clamp2 * 100 ) ) )
    Upvalue14.BackgroundColor3 = Upvalue15
    Upvalue14.Size = UDim2.fromScale( Clamp2, 1 )
    return
end

local Text4

if Clamp <= 0 then
    Text4 = "Wrecked · repair it"
else
    Text4 = ( "Health %d%%" ):format( ( math.floor( Clamp * 100 + 0.5 ) ) )
end

Upvalue13.Text = Text4
Upvalue14.BackgroundColor3 = Upvalue16
Upvalue14.Size = UDim2.fromScale( Clamp, 1 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local CarId2
local Tool = Upvalue1.tool
local CarId = Tool:GetAttribute( "CarId" )
CarId2 = if CarId then CarId else Tool:GetAttribute( "Vehicle" )
Upvalue1 = nil
task.spawn( pcall, Upvalue2.InvokeServer, Upvalue2, "RepairCancel", CarId2 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
Upvalue2 = nil
Upvalue3.Visible = false

if Upvalue4 and Upvalue5 then
    Upvalue5( )
end
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local X3
Upvalue1 = Argument2
Upvalue2 = Argument1
Upvalue3.Text = ""
Upvalue4.Visible = true
local AbsolutePosition = Upvalue5.AbsolutePosition
local AbsoluteSize = Upvalue5.AbsoluteSize
local AbsolutePosition2 = Argument1.AbsolutePosition - AbsolutePosition
local AbsoluteSize2 = Argument1.AbsoluteSize
local AbsoluteSize3 = Upvalue4.AbsoluteSize
local X = AbsolutePosition2.X + AbsoluteSize2.X + 8
local X2 = X + AbsoluteSize3.X
X3 = if AbsoluteSize.X - 4 < X2 then AbsolutePosition2.X - AbsoluteSize3.X - 8 else X
local Y = AbsolutePosition2.Y
local Clamp = math.clamp( Y, 4, ( math.max( AbsoluteSize.Y - AbsoluteSize3.Y - 4, 4 ) ) )
Upvalue4.Position = UDim2.fromScale( X3 / math.max( AbsoluteSize.X, 1 ), Clamp / math.max( AbsoluteSize.Y, 1 ) )
Upvalue6( )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Upvalue2 then
    if Upvalue2.tool ~= Upvalue1 then
        Upvalue3.Text = "Already repairing a vehicle"
        local Text = "Already repairing a vehicle"
        task.delay( 2.5, function()
            if Upvalue3.Text == Text then
                Upvalue3.Text = ""
            end
        end )
    end

    return
end
local CarId2
local InvokeServer = Upvalue4.InvokeServer
local CarId = Upvalue1:GetAttribute( "CarId" )
CarId2 = if CarId then CarId else Upvalue1:GetAttribute( "Vehicle" )
local Success, Result = pcall( InvokeServer, Upvalue4, "RepairStart", CarId2 )

if not Success or type( Result ) ~= "table" or not Result.ok then
    local Err = type( Result ) == "table" and Result.err or "Error"
    Upvalue3.Text = Err or ""

    if Err then
        task.delay( 2.5, function()
            if Upvalue3.Text == Err then
                Upvalue3.Text = ""
            end
        end )
    end

    return
end
if Upvalue1 == Upvalue1 then
    Upvalue2 = {
        tool = Upvalue1,
        t0 = os.clock( ),
        dur = Result.time or 4,
        cost = Result.cost
    }
    Upvalue5.Play( "InventoryDrop" )
    return
end
return
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if not Upvalue2 or Upvalue2.tool ~= Upvalue1 then
        local CarId2
        local InvokeServer = Upvalue3.InvokeServer
        local CarId = Upvalue1:GetAttribute( "CarId" )
        CarId2 = if CarId then CarId else Upvalue1:GetAttribute( "Vehicle" )
        local Success, Result = pcall( InvokeServer, Upvalue3, "Spawn", CarId2 )

        if not Success or type( Result ) ~= "table" or not Result.ok then
            local Err = type( Result ) == "table" and Result.err or "Error"
            Upvalue9.Text = Err or ""

            if Err then
                task.delay( 2.5, function()
                    if Upvalue9.Text == Err then
                        Upvalue9.Text = ""
                    end
                end )
            end
        else
            Upvalue1 = nil
            Upvalue4 = nil
            Upvalue5.Visible = false

            if Upvalue6 and Upvalue7 then
                Upvalue7( )
            end
            if Upvalue8 then
                Upvalue8( false )
                return
            end
        end

        return
    end
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

local CarId2
local InvokeServer = Upvalue1.InvokeServer
local CarId = Upvalue2:GetAttribute( "CarId" )
CarId2 = if CarId then CarId else Upvalue2:GetAttribute( "Vehicle" )
local Success, Result = pcall( InvokeServer, Upvalue1, "RepairDone", CarId2 )

if Success and type( Result ) == "table" and Result.ok then
    Upvalue3.Text = ""
    return
end

local Err = type( Result ) == "table" and Result.err or "Error"
Upvalue3.Text = Err or ""

if Err then
    task.delay( 2.5, function()
        if Upvalue3.Text == Err then
            Upvalue3.Text = ""
        end
    end )
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    if Upvalue1.Parent then
        Upvalue6( )
    else
        Upvalue1 = nil
        Upvalue2 = nil
        Upvalue3.Visible = false

        if Upvalue4 and Upvalue5 then
            Upvalue5( )
        end
    end
end
if Upvalue7 and not Upvalue7.tool.Parent then
    if Upvalue7 then
        local CarId2
        local Tool = Upvalue7.tool
        local CarId = Tool:GetAttribute( "CarId" )
        CarId2 = if CarId then CarId else Tool:GetAttribute( "Vehicle" )
        Upvalue7 = nil
        task.spawn( pcall, Upvalue8.InvokeServer, Upvalue8, "RepairCancel", CarId2 )
    end
end
if Upvalue7 then
    local Clock = os.clock( ) - Upvalue7.t0

    if Upvalue7.dur <= Clock then
        local Tool2 = Upvalue7.tool
        Upvalue7 = nil
        task.spawn( function()
            local CarId2
            local InvokeServer = Upvalue8.InvokeServer
            local CarId = Tool2:GetAttribute( "CarId" )
            CarId2 = if CarId then CarId else Tool2:GetAttribute( "Vehicle" )
            local Success, Result = pcall( InvokeServer, Upvalue8, "RepairDone", CarId2 )

            if Success and type( Result ) == "table" and Result.ok then
                Upvalue9.Text = ""
                return
            end

            local Err = type( Result ) == "table" and Result.err or "Error"
            Upvalue9.Text = Err or ""

            if Err then
                task.delay( 2.5, function()
                    if Upvalue9.Text == Err then
                        Upvalue9.Text = ""
                    end
                end )
            end
        end )
    end
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Object == nil then
    Flag = false
elseif Upvalue1.CASH_BAGS[ Object:GetAttribute( "Item" ) or "" ] == nil then
    Flag = false
else
    Flag = true
end

return Flag
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end
if not Humanoid or Humanoid.Health <= 0 or Upvalue2.Downed or Character:GetAttribute( "Downed" ) then
    return "You can't cash in right now"
end
if Upvalue1:GetAttribute( "InTutorial" ) then
    return "You can't cash in right now"
end
if Humanoid.SeatPart then
    return "Get out of the vehicle first"
end

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
if CombatUntil3 > 0 then
    return "In combat", CombatUntil3
end
return nil
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end
if Upvalue3 then
    Upvalue3.Size = UDim2.fromScale( 0, 1 )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end
if Upvalue3 then
    Upvalue3.Size = UDim2.fromScale( 0, 1 )
end

Upvalue4 = nil
Upvalue5 = nil

if Upvalue6 then
    Upvalue6.Visible = false
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 then
    return
end

local Flag
local Value1, Value2 = Upvalue3( )
Flag = Value1 == nil and true or false
local Text

if not Flag or not Upvalue4 then
    if Value2 then
        local Format = ( "IN COMBAT · %ds" ):format( ( math.ceil( Value2 ) ) )

        if Format then
            Text = Format
        elseif Value1 == "Get out of the vehicle first" then
            Text = "IN A VEHICLE"
        else
            Text = "UNAVAILABLE"
        end
    elseif Value1 == "Get out of the vehicle first" then
        Text = "IN A VEHICLE"
    else
        Text = "UNAVAILABLE"
    end
else
    Text = Upvalue4
end
if Upvalue5 and Upvalue5.Text ~= Text then
    Upvalue5.Text = Text
end
if Upvalue6 == Flag then
    return
end

Upvalue6 = Flag

if Upvalue7 and Upvalue8 then
    local Color = Flag and Upvalue8 or Upvalue9
    Upvalue7.Color = Color
end
if Upvalue10 then
    local TextColor3 = Flag and Upvalue11 or Upvalue12
    Upvalue10.TextColor3 = TextColor3
end
if not Flag then
    Upvalue13 = nil

    if Upvalue14 then
        Upvalue14:Cancel( )
        Upvalue14 = nil
    end
    if Upvalue15 then
        Upvalue15.Size = UDim2.fromScale( 0, 1 )
    end
end
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 then
    return
end

Upvalue3 = nil
Upvalue4 = nil
Upvalue5.Visible = false

if Upvalue6 and Upvalue7 then
    Upvalue7( )
end

Upvalue6 = Object
Upvalue8 = Argument1
Upvalue9 = nil

if Upvalue10 then
    Upvalue10.Text = "+" .. Upvalue11( Upvalue12.CASH_BAGS[ Object:GetAttribute( "Item" ) ] or 0 )
end
if Upvalue13 then
    Upvalue14.SetIcon( Upvalue13, Upvalue14.Icon( Object ) )
end

local X3
Upvalue1.Visible = true
local AbsolutePosition = Upvalue15.AbsolutePosition
local AbsoluteSize = Upvalue15.AbsoluteSize
local AbsolutePosition2 = Argument1.AbsolutePosition - AbsolutePosition
local AbsoluteSize2 = Argument1.AbsoluteSize
local AbsoluteSize3 = Upvalue1.AbsoluteSize
local X = AbsolutePosition2.X + AbsoluteSize2.X + 8
local X2 = X + AbsoluteSize3.X
X3 = if AbsoluteSize.X - 4 < X2 then AbsolutePosition2.X - AbsoluteSize3.X - 8 else X
local Y = AbsolutePosition2.Y
local Clamp = math.clamp( Y, 4, ( math.max( AbsoluteSize.Y - AbsoluteSize3.Y - 4, 4 ) ) )
Upvalue1.Position = UDim2.fromScale( X3 / math.max( AbsoluteSize.X, 1 ), Clamp / math.max( AbsoluteSize.Y, 1 ) )
Upvalue16( )

if Upvalue17.IsGamepad then
    Upvalue18.SelectedObject = Upvalue2
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue3 = nil

if Upvalue4 then
    Upvalue4:Cancel( )
    Upvalue4 = nil
end
if Upvalue5 then
    Upvalue5.Size = UDim2.fromScale( 0, 1 )
end
if not Upvalue1 or not Upvalue1.Parent then
    return
end

Upvalue6:FireServer( Upvalue1 )
Upvalue7( )
Upvalue8 = nil
Upvalue9( )

if Upvalue10.IsGamepad and Upvalue2 then
    Upvalue11.SelectedObject = Upvalue2
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue1 = nil

    if Upvalue5 then
        Upvalue5:Cancel( )
        Upvalue5 = nil
    end
    if Upvalue6 then
        Upvalue6.Size = UDim2.fromScale( 0, 1 )
    end
    if Upvalue3 then
        if not Upvalue3.Parent then
            return
        end

        Upvalue7:FireServer( Upvalue3 )
        Upvalue8( )
        Upvalue9 = nil
        Upvalue10( )

        if Upvalue11.IsGamepad and Upvalue4 then
            Upvalue12.SelectedObject = Upvalue4
        end
    end
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 then
    return
end

local Value1, Value2 = Upvalue3( )

if Value1 then
    local Format2
    local Error = Upvalue4.Error

    if Value2 then
        local Format = ( "You can't cash in a bag during combat (%ds)" ):format( ( math.ceil( Value2 ) ) )

        if Format then
            Format2 = Format
        else
            Format2 = Value1
        end
    else
        Format2 = Value1
    end

    Error( Format2 )
    return
end
local Table = { }
Upvalue1 = Table
local Number = tonumber( Upvalue5:GetAttribute( "HoldTime" ) ) or 1.2

if Upvalue6 then
    Upvalue6.Size = UDim2.fromScale( 0, 1 )
    Upvalue7 = Upvalue8:Create( Upvalue6, TweenInfo.new( Number, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 1, 1 ) } )
    Upvalue7:Play( )
end

task.delay( Number, function()
    if Upvalue1 == Table then
        Upvalue1 = nil

        if Upvalue7 then
            Upvalue7:Cancel( )
            Upvalue7 = nil
        end
        if Upvalue6 then
            Upvalue6.Size = UDim2.fromScale( 0, 1 )
        end
        if Upvalue2 then
            if not Upvalue2.Parent then
                return
            end

            Upvalue10:FireServer( Upvalue2 )
            Upvalue11( )
            Upvalue12 = nil
            Upvalue13( )

            if Upvalue14.IsGamepad and Upvalue9 then
                Upvalue15.SelectedObject = Upvalue9
            end
        end
    end
end )
return
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1( )
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil

    if Upvalue2 then
        Upvalue2:Cancel( )
        Upvalue2 = nil
    end
    if Upvalue3 then
        Upvalue3.Size = UDim2.fromScale( 0, 1 )
    end
end
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil

    if Upvalue2 then
        Upvalue2:Cancel( )
        Upvalue2 = nil
    end
    if Upvalue3 then
        Upvalue3.Size = UDim2.fromScale( 0, 1 )
    end
end
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.KeyCode == Enum.KeyCode.ButtonA and Upvalue1.SelectedObject == Upvalue2 then
    Upvalue3( )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local UserInputType = Argument1.UserInputType

if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch or Argument1.KeyCode == Enum.KeyCode.ButtonA then
    Upvalue1 = nil

    if Upvalue2 then
        Upvalue2:Cancel( )
        Upvalue2 = nil
    end
    if Upvalue3 then
        Upvalue3.Size = UDim2.fromScale( 0, 1 )
    end
end
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Upvalue1.Parent then
    Upvalue3( )
    return
end
Upvalue2( )
return
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1:GetMouseLocation( ) - Upvalue2:GetGuiInset( )
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Grab = Argument1 - Upvalue1.grab - Upvalue2.AbsolutePosition
Upvalue3.Position = Upvalue4.FromAbs( Upvalue3, Grab.X, Grab.Y )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if NoticeName == "broken" then
    Upvalue1.Error( "This weapon is broken: repair it first" )
    return
end
if NoticeName == "never" then
    Upvalue1.Error( "This item is never lost" )
    return
end
if NoticeName == "combat" then
    Upvalue1.Error( "You can't protect items in combat" )
    return
end
if NoticeName == "oneweapon" then
    Upvalue1.Error( "Only one weapon in your hotbar" )
    return
end
if NoticeName == "needweapon" then
    Upvalue1.Error( "Keep a weapon in your hotbar" )
end
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local ZoneLocked = Upvalue1.ZoneLocked( )

if Upvalue2 then
    local Color = ZoneLocked and Upvalue3 or Upvalue4

    if Upvalue2.Color ~= Color then
        Upvalue2.Color = Color
    end
end
if Upvalue5 then
    local Text = if ZoneLocked then "PROTECTED <font color=\"#FF6E6E\">(locked in combat)</font>" else Upvalue6

    if Upvalue5.Text ~= Text then
        Upvalue5.Text = Text
    end
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local AbsolutePosition = Argument1.AbsolutePosition
local AbsoluteSize = Argument1.AbsoluteSize
local X = Argument2.X

if AbsolutePosition.X <= X then
    if Argument2.X <= AbsolutePosition.X + AbsoluteSize.X then
        local Y = Argument2.Y

        if AbsolutePosition.Y <= Y then
            if Argument2.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
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
else
    Flag = false
end

return Flag
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 and Upvalue3 then
    Upvalue2.Text = Upvalue3
end
if Upvalue4 then
    Upvalue4( )
end
if Upvalue5 then
    Upvalue5.Visible = false
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Object == nil then
    Flag = false
elseif Object:GetAttribute( "Unbreakable" ) == true then
    if Upvalue1.KindKey( Object ) == nil then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

local Remotes2
local Remotes = Upvalue1:FindFirstChild( "Remotes" )
Remotes2 = if Remotes then Remotes:FindFirstChild( "Loot" ) else Remotes
return Remotes2
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured2
Upvalue1 = math.clamp( math.floor( Amount + 0.5 ), 1, Upvalue2 )

if Upvalue2 > 1 then
    local Captured = ( Upvalue1 - 1 ) / ( Upvalue2 - 1 )

    if Captured then
        Captured2 = Captured
    else
        Captured2 = 1
    end
else
    Captured2 = 1
end
if Upvalue3 then
    Upvalue3.Size = UDim2.fromScale( Captured2, 1 )
end
if Upvalue4 then
    Upvalue4.Position = UDim2.fromScale( Captured2, 0.5 )
end
if Upvalue5 then
    Upvalue5.Text = ( "x%d" ):format( Upvalue1 )
end
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
Upvalue2 = false

if Upvalue3 then
    Upvalue3.Visible = false
end
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or not Upvalue2 or not Upvalue3 or not Upvalue4 then
    return false
end

Upvalue5 = nil
Upvalue6 = nil
Upvalue7.Visible = false

if Upvalue8 and Upvalue9 then
    Upvalue9( )
end

local Max = math.max( 1, ( math.floor( tonumber( Object:GetAttribute( "Count" ) ) or 1 ) ) )
Upvalue10 = Object
Upvalue11 = Max

if Upvalue12 then
    local Name
    local Entry = Upvalue13[ Object:GetAttribute( "Weapon" ) ]

    if not Entry or not Entry.Name then
        local DisplayName = Object:GetAttribute( "DisplayName" )

        if DisplayName then
            Name = DisplayName
        else
            Name = Object.Name
        end
    else
        Name = Entry.Name
    end

    Upvalue12.Text = "Drop " .. Name
end
if Upvalue14 and Upvalue4:GetAttribute( "CouleurRarete" ) ~= false then
    Upvalue14.BackgroundColor3 = Upvalue15.Color( Object:GetAttribute( "Item" ) )
end

Upvalue16( Upvalue11 )
Upvalue1.Visible = true

if Upvalue17.IsGamepad then
    Upvalue18.SelectedObject = Upvalue2
end

return true
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

local Loot
local Remotes = Upvalue1:FindFirstChild( "Remotes" )

if Remotes then
    Loot = Remotes:FindFirstChild( "Loot" )
else
    Loot = Remotes
end
if not Loot or not Object2 then
    return false
end

local Flag

if Object2 == nil then
    Flag = false
elseif Object2:GetAttribute( "Unbreakable" ) == true then
    if Upvalue2.KindKey( Object2 ) == nil then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end
if Flag and Upvalue3 and Upvalue4 then
    Upvalue5 = nil
    Upvalue6 = nil
    Upvalue7.Visible = false

    if Upvalue8 and Upvalue9 then
        Upvalue9( )
    end
    if Upvalue10 and Upvalue11 then
        Upvalue10.Text = Upvalue11
    end

    Upvalue12 = Object2

    if Upvalue13 and Upvalue14 then
        Upvalue13.Text = Upvalue14
    end

    Upvalue15.Visible = true

    if Upvalue16.IsGamepad then
        Upvalue17.SelectedObject = Upvalue4
    end

    return false
end
if not Upvalue2.Droppable( Object2 ) then
    return false
end
if not Object2:GetAttribute( "Item" ) or not ( ( tonumber( Object2:GetAttribute( "Count" ) ) or 1 ) > 1 ) or not Upvalue18( Object2 ) then
    Loot:FireServer( "drop", Object2 )
    Upvalue19.Play( "InventoryDrop" )
    return true
end
return false
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

local Clamp2
local X = Upvalue1.AbsolutePosition.X
local X2 = Upvalue1.AbsoluteSize.X

if X2 > 0 then
    local Clamp = math.clamp( ( Argument1 - X ) / X2, 0, 1 )

    if Clamp then
        Clamp2 = Clamp
    else
        Clamp2 = 1
    end
else
    Clamp2 = 1
end

Upvalue2( 1 + Clamp2 * ( Upvalue3 - 1 ) )
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
    local Clamp2
    Upvalue2 = true
    local X = ( Upvalue3:GetMouseLocation( ) - Upvalue4:GetGuiInset( ) ).X
    local X2 = Upvalue5.AbsolutePosition.X
    local X3 = Upvalue5.AbsoluteSize.X

    if X3 > 0 then
        local Clamp = math.clamp( ( X - X2 ) / X3, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    else
        Clamp2 = 1
    end

    Upvalue6( 1 + Clamp2 * ( Upvalue7 - 1 ) )
    return
end
if Argument1.UserInputType == Enum.UserInputType.Touch then
    local Clamp4
    Upvalue2 = true
    local X4 = Argument1.Position.X
    local X5 = Upvalue5.AbsolutePosition.X
    local X6 = Upvalue5.AbsoluteSize.X

    if X6 > 0 then
        local Clamp3 = math.clamp( ( X4 - X5 ) / X6, 0, 1 )

        if Clamp3 then
            Clamp4 = Clamp3
        else
            Clamp4 = 1
        end
    else
        Clamp4 = 1
    end

    Upvalue6( 1 + Clamp4 * ( Upvalue7 - 1 ) )
end

return
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Argument1.UserInputType == Enum.UserInputType.MouseMovement then
    local Clamp2
    local X = ( Upvalue2:GetMouseLocation( ) - Upvalue3:GetGuiInset( ) ).X
    local X2 = Upvalue4.AbsolutePosition.X
    local X3 = Upvalue4.AbsoluteSize.X

    if X3 > 0 then
        local Clamp = math.clamp( ( X - X2 ) / X3, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    else
        Clamp2 = 1
    end

    Upvalue5( 1 + Clamp2 * ( Upvalue6 - 1 ) )
    return
end
if Argument1.UserInputType == Enum.UserInputType.Touch then
    local Clamp4
    local X4 = Argument1.Position.X
    local X5 = Upvalue4.AbsolutePosition.X
    local X6 = Upvalue4.AbsoluteSize.X

    if X6 > 0 then
        local Clamp3 = math.clamp( ( X4 - X5 ) / X6, 0, 1 )

        if Clamp3 then
            Clamp4 = Clamp3
        else
            Clamp4 = 1
        end
    else
        Clamp4 = 1
    end

    Upvalue5( 1 + Clamp4 * ( Upvalue6 - 1 ) )
end

return
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1 = false
end
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( Upvalue3 - 1 )
end
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( Upvalue3 + 1 )
end
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil
Upvalue3 = false

if Upvalue4 then
    Upvalue4.Visible = false
end

local Loot
local Remotes = Upvalue5:FindFirstChild( "Remotes" )

if Remotes then
    Loot = Remotes:FindFirstChild( "Loot" )
else
    Loot = Remotes
end
if not Loot or not Upvalue1 or not Upvalue1.Parent then
    return
end
Loot:FireServer( "drop", Upvalue1, Upvalue2 )
Upvalue6.Play( "InventoryDrop" )
Upvalue7 = nil
Upvalue8( )
return
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 and Upvalue3 then
    Upvalue2.Text = Upvalue3
end
if Upvalue4 then
    Upvalue4( )
end
if Upvalue5 then
    Upvalue5.Visible = false
end

local Loot
local Remotes = Upvalue6:FindFirstChild( "Remotes" )

if Remotes then
    Loot = Remotes:FindFirstChild( "Loot" )
else
    Loot = Remotes
end
if not Loot or not Upvalue1 or not Upvalue1.Parent then
    return
end
Loot:FireServer( "discard", Upvalue1 )
Upvalue7.Play( "InventoryDrop" )
Upvalue8 = nil
Upvalue9( )
return
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = nil

if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end
if Upvalue3 then
    Upvalue3.Size = UDim2.fromScale( 0, 1 )
end
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 then
    return
end

Upvalue3( )
Upvalue4 = nil

if Upvalue5 and Upvalue6 then
    Upvalue5.Text = Upvalue6
end
if Upvalue3 then
    Upvalue3( )
end
if Upvalue7 then
    Upvalue7.Visible = false
end

local Loot
local Remotes = Upvalue8:FindFirstChild( "Remotes" )

if Remotes then
    Loot = Remotes:FindFirstChild( "Loot" )
else
    Loot = Remotes
end
if Loot and Upvalue4 then
    if not Upvalue4.Parent then
        return
    end

    Loot:FireServer( "discard", Upvalue4 )
    Upvalue9.Play( "InventoryDrop" )
    Upvalue10 = nil
    Upvalue11( )
end
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 or not Upvalue3.Visible then
    return
end

local Table = { }
Upvalue1 = Table
local Number = tonumber( Upvalue4:GetAttribute( "HoldTime" ) ) or 1.2

if Upvalue5 then
    Upvalue5.Size = UDim2.fromScale( 0, 1 )
    Upvalue6 = Upvalue7:Create( Upvalue5, TweenInfo.new( Number, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 1, 1 ) } )
    Upvalue6:Play( )
end

task.delay( Number, function()
    if Upvalue1 ~= Table then
        return
    end

    Upvalue8( )
    Upvalue2 = nil

    if Upvalue9 and Upvalue10 then
        Upvalue9.Text = Upvalue10
    end
    if Upvalue8 then
        Upvalue8( )
    end
    if Upvalue3 then
        Upvalue3.Visible = false
    end

    local Loot
    local Remotes = Upvalue11:FindFirstChild( "Remotes" )

    if Remotes then
        Loot = Remotes:FindFirstChild( "Loot" )
    else
        Loot = Remotes
    end
    if Loot and Upvalue2 then
        if not Upvalue2.Parent then
            return
        end

        Loot:FireServer( "discard", Upvalue2 )
        Upvalue12.Play( "InventoryDrop" )
        Upvalue13 = nil
        Upvalue14( )
    end
end )
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 or Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1( )
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( )
end
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( )
end
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.KeyCode == Enum.KeyCode.ButtonA and Upvalue1.SelectedObject == Upvalue2 then
    Upvalue3( )
end
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local UserInputType = Argument1.UserInputType

if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch or Argument1.KeyCode == Enum.KeyCode.ButtonA then
    Upvalue2( )
end
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue3 then
    return
end

local Flag

if ( Upvalue1 and Upvalue2.Layout( )[ Upvalue1 ] ) == nil then
    Flag = false
else
    local Droppable = Upvalue4.Droppable( Upvalue1 and Upvalue2.Layout( )[ Upvalue1 ] )

    if Droppable then
        Flag = Droppable
    elseif ( Upvalue1 and Upvalue2.Layout( )[ Upvalue1 ] ) == nil then
        Flag = false
    elseif ( Upvalue1 and Upvalue2.Layout( )[ Upvalue1 ] ):GetAttribute( "Unbreakable" ) == true then
        if Upvalue4.KindKey( Upvalue1 and Upvalue2.Layout( )[ Upvalue1 ] ) == nil then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = false
    end
end

local BackgroundTransparency

if not Flag or not Upvalue5 then
    BackgroundTransparency = math.max( Upvalue5, 0.55 )
else
    BackgroundTransparency = Upvalue5
end
if Upvalue3.BackgroundTransparency ~= BackgroundTransparency then
    Upvalue3.BackgroundTransparency = BackgroundTransparency
end
if Upvalue6 then
    local TextTransparency

    if not Flag or not Upvalue7 then
        TextTransparency = math.max( Upvalue7, 0.45 )
    else
        TextTransparency = Upvalue7
    end
    if Upvalue6.TextTransparency ~= TextTransparency then
        Upvalue6.TextTransparency = TextTransparency
    end
end
]]

--[[
Function #66 has no emitted closure site
It is reproduced here so that nothing is lost

if MoveName == Upvalue1.FISTS or Upvalue1.TOTAL < MoveName then
    return
end

local Layout = Upvalue1.Layout( )
local Entry = Layout[ MoveName ]

if not Entry then
    return
end
if Upvalue2 or Upvalue3 then
    Upvalue2 = nil
    Upvalue4 = nil
    Upvalue5.Visible = false

    if Upvalue3 and Upvalue6 then
        Upvalue6( )
    end
end
if Upvalue7 then
    Upvalue7 = nil

    if Upvalue8 and Upvalue9 then
        Upvalue8.Text = Upvalue9
    end
    if Upvalue10 then
        Upvalue10( )
    end
    if Upvalue11 then
        Upvalue11.Visible = false
    end
end
if Upvalue12 then
    Upvalue12 = nil
    Upvalue13 = false

    if Upvalue14 then
        Upvalue14.Visible = false
    end
end

local Flag = MoveName <= Upvalue1.HOTBAR and true or false
local Value1

if Flag or not Upvalue1.IsWeapon( Entry ) then
    Value1 = nil
else
    local FISTS = Upvalue1.FISTS + 1
    local HOTBAR = Upvalue1.HOTBAR
    local I = FISTS
    Value1 = nil

    for I = FISTS, HOTBAR do
        if Upvalue1.IsWeapon( Layout[ I ] ) then
            Value1 = I
            break
        end

        Value1 = nil
    end
end
if not Value1 then
    local HOTBAR3

    if Flag then
        local HOTBAR2 = Upvalue1.HOTBAR + 1

        if HOTBAR2 then
            HOTBAR3 = HOTBAR2
        else
            HOTBAR3 = Upvalue1.FISTS + 1
        end
    else
        HOTBAR3 = Upvalue1.FISTS + 1
    end

    local TOTAL2

    if Flag then
        local TOTAL = Upvalue1.TOTAL

        if TOTAL then
            TOTAL2 = TOTAL
        else
            TOTAL2 = Upvalue1.HOTBAR
        end
    else
        TOTAL2 = Upvalue1.HOTBAR
    end

    local I2 = HOTBAR3

    for I2 = HOTBAR3, TOTAL2 do
        if Layout[ I2 ] == nil then
            Value1 = I2
            break
        end
    end
end
if Value1 then
    local Move, Move2 = Upvalue1.Move( MoveName, Value1 )

    if Move then
        Upvalue16.Play( "InventoryDrop" )
        Upvalue17 = nil
    else
        Upvalue18( Move2 )
    end

    Upvalue19( )
    return
end
local Text
local Error = Upvalue15.Error
Text = not Flag and "Your hotbar is full" or "Your backpack is full"
Error( Text )
return
]]

--[[
Function #67 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local Entry = Upvalue1.Layout( )[ Upvalue2 ]

if Upvalue2 == Upvalue1.FISTS then
    Text = "Fists"
elseif Entry then
    local Entry2 = Upvalue4[ Entry:GetAttribute( "Weapon" ) ]

    if not Entry2 or not Entry2.Name then
        local DisplayName = Entry:GetAttribute( "DisplayName" )

        if DisplayName then
            Text = DisplayName
        else
            Text = Entry.Name
        end
    else
        Text = Entry2.Name
    end
    if not Text then
        if Upvalue1.IsProtectedCase( Upvalue2 ) then
            Text = "Protected: never lost, can't be used from here"
        else
            Text = Upvalue5
        end
    end
elseif Upvalue1.IsProtectedCase( Upvalue2 ) then
    Text = "Protected: never lost, can't be used from here"
else
    Text = Upvalue5
end

Upvalue3.Text = Text
]]

--[[
Function #68 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    local Text
    local Entry = Upvalue2.Layout( )[ Upvalue3 ]

    if Upvalue3 == Upvalue2.FISTS then
        Text = "Fists"
    elseif Entry then
        local Entry2 = Upvalue5[ Entry:GetAttribute( "Weapon" ) ]

        if not Entry2 or not Entry2.Name then
            local DisplayName = Entry:GetAttribute( "DisplayName" )

            if DisplayName then
                Text = DisplayName
            else
                Text = Entry.Name
            end
        else
            Text = Entry2.Name
        end
        if not Text then
            if Upvalue2.IsProtectedCase( Upvalue3 ) then
                Text = "Protected: never lost, can't be used from here"
            else
                Text = Upvalue6
            end
        end
    elseif Upvalue2.IsProtectedCase( Upvalue3 ) then
        Text = "Protected: never lost, can't be used from here"
    else
        Text = Upvalue6
    end

    Upvalue4.Text = Text
end
]]

--[[
Function #69 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    Upvalue2.Text = Upvalue3
end
]]

--[[
Function #70 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton2 then
    if Upvalue1 and not Upvalue2 and not Upvalue3.IsGamepad then
        Upvalue4( Upvalue5 )
    end

    return
end
if Argument1.UserInputType ~= Enum.UserInputType.MouseButton1 and Argument1.UserInputType ~= Enum.UserInputType.Touch then
    return
end
if Upvalue3.IsGamepad then
    return
end

local Entry = Upvalue6.Layout( )[ Upvalue5 ]

if not Entry then
    return
end

local Vector23

if Argument1.UserInputType == Enum.UserInputType.Touch then
    local Vector22 = Vector2.new( Argument1.Position.X, Argument1.Position.Y )

    if Vector22 then
        Vector23 = Vector22
    else
        Vector23 = Upvalue7:GetMouseLocation( ) - Upvalue8:GetGuiInset( )
    end
else
    Vector23 = Upvalue7:GetMouseLocation( ) - Upvalue8:GetGuiInset( )
end

local Flag

if Upvalue9 == nil or Upvalue9 ~= Entry then
    if Upvalue10 == nil then
        Flag = false
    elseif Upvalue10 == Entry then
        Flag = true
    else
        Flag = false
    end
else
    Flag = true
end
if Upvalue9 or Upvalue10 then
    Upvalue9 = nil
    Upvalue11 = nil
    Upvalue12.Visible = false

    if Upvalue10 and Upvalue13 then
        Upvalue13( )
    end
end
if Upvalue14 then
    Upvalue14 = nil

    if Upvalue15 and Upvalue16 then
        Upvalue15.Text = Upvalue16
    end
    if Upvalue17 then
        Upvalue17( )
    end
    if Upvalue18 then
        Upvalue18.Visible = false
    end
end
if Upvalue19 then
    Upvalue19 = nil
    Upvalue20 = false

    if Upvalue21 then
        Upvalue21.Visible = false
    end
end
if not Upvalue6.IsFixed( Entry ) or Upvalue22 then
    local Touch
    local Table = {
        from = Upvalue5,
        grab = Vector23 - Upvalue24.AbsolutePosition,
        start = Vector23,
        wasOpen = Flag
    }
    Touch = Argument1.UserInputType == Enum.UserInputType.Touch and true or false
    local Visible
    Table.touch = Touch
    Table.t0 = os.clock( )
    Upvalue2 = Table
    Upvalue25 = Upvalue5
    Upvalue26.Size = Upvalue27.FromAbs( Upvalue26, Upvalue24.AbsoluteSize.X, Upvalue24.AbsoluteSize.Y )
    Upvalue28.Color = Upvalue29( Upvalue30( Entry ) )
    Upvalue31( Upvalue32, Entry )
    Upvalue33.SetIcon( Upvalue32, Upvalue33.Icon( Entry ) )
    local Value1 = Upvalue35( Entry )

    if Value1 == nil then
        Visible = false
    elseif Value1 > 0 then
        Visible = true
    else
        Visible = false
    end

    Upvalue34.Visible = Visible

    if Value1 then
        Upvalue34.Size = UDim2.fromScale( Upvalue36 * Value1, Upvalue37 )
    end

    Upvalue38.Text = Upvalue39( Entry )

    if Upvalue40 then
        Upvalue40.Visible = Upvalue6.IsBroken( Entry )
    end

    local Vector24 = Vector23 - Upvalue2.grab - Upvalue41.AbsolutePosition
    Upvalue26.Position = Upvalue27.FromAbs( Upvalue26, Vector24.X, Vector24.Y )
    Upvalue26.Visible = true
    Upvalue42( )
    return
end
if not Flag then
    Upvalue23( Upvalue24, Entry )
end

return
]]

-- Could not structure function #71

--[[
Function #72 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = if ( ReadyName and Upvalue1[ ReadyName ] ) == nil then false else ( ReadyName and Upvalue1[ ReadyName ] ).IsLoaded
return Flag
]]

--[[
Function #73 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 == Enum.AssetFetchStatus.Success and Upvalue1[ Key ] then
    Upvalue2[ Upvalue1[ Key ] ] = true
end
]]

--[[
Function #74 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local VehicleModels = Upvalue1:WaitForChild( "VehicleModels", 10 )
local Table = { }
local Table2 = { }
local Table3 = { }
local ICONS = Upvalue2.ICONS
Value1 = nil

for Key, Value in ICONS, nil, nil do
    if not Table3[ Value ] then
        Table3[ Value ] = true
        table.insert( Table, Value )
    end
    if VehicleModels and VehicleModels:FindFirstChild( Key ) then
        Table2[ Value ] = Key
    end
end
if Upvalue2.FIST_ICON then
    table.insert( Table, Upvalue2.FIST_ICON )
end

local Value2
local Table4 = { }
Value2 = nil

for Key2, Value3 in Table, nil, nil do
    local ImageLabel = Instance.new( "ImageLabel" )
    ImageLabel.Image = Value3
    table.insert( Table4, ImageLabel )
end

game:GetService( "ContentProvider" ):PreloadAsync( Table4, function( Key, Argument2 )
    if Argument2 == Enum.AssetFetchStatus.Success and Table2[ Key ] then
        Upvalue3[ Table2[ Key ] ] = true
    end
end )

if Upvalue4 then
    Upvalue4( )
end
]]

--[[
Function #75 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Key ]

if Entry and Entry.name == Argument3 then
    return
end
if Entry then
    Entry.frame:Destroy( )
    Upvalue1[ Key ] = nil
end
if not Argument3 then
    return
end

local X2
local AbsoluteSize = Value.icon.AbsoluteSize
local CarRender = Upvalue2.CarRender

if AbsoluteSize.Y > 1 then
    local X = AbsoluteSize.X / AbsoluteSize.Y

    if X then
        X2 = X
    else
        X2 = 1.7
    end
else
    X2 = 1.7
end

local CarRender2 = CarRender( Argument3, X2 )
CarRender2.Parent = Value.icon
Upvalue1[ Key ] = { name = Argument3, frame = CarRender2 }
]]

--[[
Function #76 has no emitted closure site
It is reproduced here so that nothing is lost

local ScaleTarget = not Argument2 and 1 or 1.07

if Argument1.scaleTarget ~= ScaleTarget then
    Argument1.scaleTarget = ScaleTarget
    Upvalue1:Create( Argument1.scale, Upvalue2, { Scale = ScaleTarget } ):Play( )
end
]]

--[[
Function #77 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1 == nil then
    Flag = false
elseif Upvalue2 == Argument2 then
    if Upvalue1.from == Argument2 then
        Flag = false
    else
        Flag = true
    end
else
    Flag = false
end

local Color
local Stroke = Argument1.stroke

if Upvalue3 ~= Argument2 or not Upvalue4 then
    Color = Color3.new( 1, 1, 1 )
else
    Color = Upvalue4
end

local Transparency
Stroke.Color = Color
local Stroke2 = Argument1.stroke
Transparency = ( Upvalue3 == Argument2 or Flag ) and 0 or 1
Stroke2.Transparency = Transparency
]]

--[[
Function #78 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Layout = Upvalue1.Layout( )
local Character = Upvalue2.Character
local Entry = Upvalue3[ Upvalue1.FISTS ]
local Grad = Entry.grad
Grad.Color = Upvalue4( "fist" )
Entry.button.BackgroundTransparency = Upvalue5

if Upvalue6.FistsSelected == true then
    local Character2 = if Character then Character:FindFirstChildOfClass( "Tool" ) else Character
    Flag = not Character2
else
    Flag = false
end

local ScaleTarget = not Flag and 1 or 1.07

if Entry.scaleTarget ~= ScaleTarget then
    Entry.scaleTarget = ScaleTarget
    Upvalue7:Create( Entry.scale, Upvalue8, { Scale = ScaleTarget } ):Play( )
end

local Flag2
local FISTS = Upvalue1.FISTS

if Upvalue9 == nil then
    Flag2 = false
elseif Upvalue10 == FISTS then
    if Upvalue9.from == FISTS then
        Flag2 = false
    else
        Flag2 = true
    end
else
    Flag2 = false
end

local Color
local Stroke = Entry.stroke

if Upvalue11 ~= FISTS or not Upvalue12 then
    Color = Color3.new( 1, 1, 1 )
else
    Color = Upvalue12
end

local Transparency
Stroke.Color = Color
local Stroke2 = Entry.stroke
Transparency = ( Upvalue11 == FISTS or Flag2 ) and 0 or 1
local Value1, Number
Stroke2.Transparency = Transparency
Value1 = nil
Number = 0

for Key, Value in Upvalue3, nil, nil do
    if Key ~= Upvalue1.FISTS then
        local Entry2 = Layout[ Key ]

        if Entry2 and Key <= Upvalue1.TOTAL then
            Number = Number + 1
        end

        local Flag3

        if Upvalue9 == nil or Upvalue9.from ~= Key then
            if Upvalue11 == Key then
                Flag3 = true
            else
                Flag3 = false
            end
        else
            Flag3 = true
        end

        local Flag4

        if Entry2 == nil then
            Flag4 = false
        elseif Entry2.Parent == Character then
            Flag4 = true
        else
            Flag4 = false
        end
        if Entry2 then
            Upvalue13( Value.icon, Entry2 )
        end

        local Vehicle

        if Entry2 then
            Vehicle = Entry2:GetAttribute( "Vehicle" )
        else
            Vehicle = Entry2
        end

        local Entry4

        if Entry2 then
            local NotEntry = not Vehicle

            if NotEntry then
                Entry4 = NotEntry
            else
                local Entry3 = Upvalue14[ Vehicle ]

                if Entry3 then
                    Entry4 = Entry3
                else
                    local Icon2
                    local Icon = Upvalue15.Icon( Entry2 )
                    Icon2 = if Icon then Upvalue16[ Icon ] else Icon

                    if Icon2 == nil then
                        Entry4 = false
                    else
                        Entry4 = Icon2.IsLoaded
                    end
                end
            end
        else
            Entry4 = Entry2
        end

        local Icon5
        local SetIcon = Upvalue15.SetIcon
        local Icon3 = Value.icon

        if Entry4 then
            local Icon4 = Upvalue15.Icon( Entry2 )

            if Icon4 then
                Icon5 = Icon4
            else
                Icon5 = ""
            end
        else
            Icon5 = ""
        end

        local Entry5
        SetIcon( Icon3, Icon5 )
        Entry5 = if not Vehicle or Entry4 or not Vehicle then nil else Vehicle
        local ImageTransparency
        Upvalue17( Value, Key, Entry5 )
        local Icon6 = Value.icon
        ImageTransparency = not Flag3 and 0 or 0.6
        local Text3
        Icon6.ImageTransparency = ImageTransparency
        local Text2 = Value.text

        if not Entry2 or Flag3 then
            Text3 = ""
        else
            local Value2 = Upvalue18( Entry2 )

            if Value2 then
                Text3 = Value2
            else
                Text3 = ""
            end
        end

        local Enabled
        Text2.Text = Text3
        local Grad2 = Value.grad
        Enabled = Entry2 ~= nil and true or false
        Grad2.Enabled = Enabled

        if Entry2 then
            local Grad3 = Value.grad
            Grad3.Color = Upvalue4( Upvalue19( Entry2 ) )
        end

        local Flag5 = if Flag4 then not Flag3 else Flag4
        local ScaleTarget2 = not Flag5 and 1 or 1.07

        if Value.scaleTarget ~= ScaleTarget2 then
            Value.scaleTarget = ScaleTarget2
            Upvalue7:Create( Value.scale, Upvalue8, { Scale = ScaleTarget2 } ):Play( )
        end

        local BackgroundColor3
        local Button = Value.button

        if Entry2 then
            local Color32 = Color3.new( 1, 1, 1 )

            if Color32 then
                BackgroundColor3 = Color32
            else
                BackgroundColor3 = Upvalue20
            end
        else
            BackgroundColor3 = Upvalue20
        end

        local BackgroundTransparency
        Button.BackgroundColor3 = BackgroundColor3
        local Button2 = Value.button

        if Entry2 then
            if Flag3 then
                BackgroundTransparency = 0.5
            elseif Upvalue5 then
                BackgroundTransparency = Upvalue5
            else
                BackgroundTransparency = Upvalue21
            end
        else
            BackgroundTransparency = Upvalue21
        end

        local Value4
        Button2.BackgroundTransparency = BackgroundTransparency
        local Bar = Value.bar

        if not Entry2 or Flag3 then
            Value4 = nil
        else
            local Value3 = Upvalue22( Entry2 )

            if Value3 then
                Value4 = Value3
            else
                Value4 = nil
            end
        end

        local Visible

        if Value4 == nil then
            Visible = false
        elseif Value4 > 0 then
            Visible = true
        else
            Visible = false
        end

        Bar.Visible = Visible

        if Value4 then
            Bar.Size = UDim2.fromScale( Upvalue23 * Value4, Upvalue24 )
        end
        if Value.broken then
            local Visible2
            local Broken = Value.broken

            if Entry2 == nil then
                Visible2 = false
            else
                local NotFlag = not Flag3

                if NotFlag then
                    Visible2 = Upvalue1.IsBroken( Entry2 )
                else
                    Visible2 = NotFlag
                end
            end

            Broken.Visible = Visible2
        end

        local Flag6

        if Upvalue9 == nil then
            Flag6 = false
        elseif Upvalue10 == Key then
            if Upvalue9.from == Key then
                Flag6 = false
            else
                Flag6 = true
            end
        else
            Flag6 = false
        end

        local Color4
        local Stroke3 = Value.stroke

        if Upvalue11 ~= Key or not Upvalue12 then
            Color4 = Color3.new( 1, 1, 1 )
        else
            Color4 = Upvalue12
        end

        local Transparency2
        Stroke3.Color = Color4
        local Stroke4 = Value.stroke
        Transparency2 = ( Upvalue11 == Key or Flag6 ) and 0 or 1
        Stroke4.Transparency = Transparency2
    end
end

Upvalue25.Text = Number .. "/" .. Upvalue26
Upvalue27( )
local ZoneLocked = Upvalue1.ZoneLocked( )

if Upvalue28 then
    local Color2 = ZoneLocked and Upvalue29 or Upvalue30

    if Upvalue28.Color ~= Color2 then
        Upvalue28.Color = Color2
    end
end
if Upvalue31 then
    local Text = if ZoneLocked then "PROTECTED <font color=\"#FF6E6E\">(locked in combat)</font>" else Upvalue32

    if Upvalue31.Text ~= Text then
        Upvalue31.Text = Text
    end
end
]]

--[[
Function #79 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local AbsolutePosition = Value.button.AbsolutePosition
    local AbsoluteSize = Value.button.AbsoluteSize
    local X = MouseLocation.X

    if AbsolutePosition.X <= X and MouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y <= MouseLocation.Y then
        if MouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y then
            return Key
        end
    end
end

return nil
]]

--[[
Function #80 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag2 = Object:GetAttribute( "Vehicle" ) ~= nil and true or false
local Number = 0

for Key, Value in Upvalue1.Tools( ) do
    if not Value:GetAttribute( "TestKit" ) and not Value:GetAttribute( "AdminTest" ) and not Value:GetAttribute( "BetaLent" ) then
        if not Flag2 or not Value:GetAttribute( "Vehicle" ) then
            if not Flag2 and Upvalue1.IsWeapon( Value ) then
                Number = Number + 1
            end
        else
            Number = Number + 1
        end
    end
end

local Flag = Number <= 1 and true or false
return Flag
]]

-- Could not structure function #81

--[[
Function #82 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 or Upvalue3 or Upvalue4 then
    return
end

local Captured

if Upvalue5 then
    Captured = Upvalue5
else
    local Value1
    local SelectedObject = Upvalue6.SelectedObject
    Value1 = nil

    for Key, Value in Upvalue7, nil, nil do
        if Value.button == SelectedObject then
            Captured = Key
            break
        end

        Captured = Upvalue5
    end
end
if not Captured then
    local Value2 = nil

    for Key2, Value3 in Upvalue7, nil, nil do
        if Upvalue8 or Upvalue9 then
            if Value3.button == ( Upvalue8 or Upvalue9 ) then
                Captured = Key2
                break
            end
        end
    end
end
if not Captured or Captured == Upvalue10.FISTS or not Upvalue10.Layout( )[ Captured ] then
    return
end
if Upvalue11 or Upvalue12 then
    Upvalue11 = nil
    Upvalue9 = nil
    Upvalue13.Visible = false

    if Upvalue12 and Upvalue14 then
        Upvalue14( )
    end
end

Upvalue5 = nil
Upvalue2 = { from = Captured, wasOpen = false }
Upvalue15( true, Upvalue16 )

if Upvalue1 and Upvalue7[ Captured ] and not Upvalue3 and not Upvalue4 then
    Upvalue6.SelectedObject = Upvalue7[ Captured ].button
end
]]

--[[
Function #83 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 or Upvalue3 or Upvalue4 then
    return
end

local Captured

if Upvalue5 then
    Captured = Upvalue5
else
    local Value1
    local SelectedObject = Upvalue6.SelectedObject
    Value1 = nil

    for Key, Value in Upvalue7, nil, nil do
        if Value.button == SelectedObject then
            Captured = Key
            break
        end

        Captured = Upvalue5
    end
end
if not Captured then
    local Value2 = nil

    for Key2, Value3 in Upvalue7, nil, nil do
        if Upvalue8 or Upvalue9 then
            if Value3.button == ( Upvalue8 or Upvalue9 ) then
                Captured = Key2
                break
            end
        end
    end
end
if not Captured then
    return
end

Upvalue10( Captured )

if not Upvalue1 then
    return
end

local Value4, Captured2
local SelectedObject2 = Upvalue6.SelectedObject
Value4 = nil

for Key3, Value5 in Upvalue7, nil, nil do
    if Value5.button == SelectedObject2 then
        Captured2 = Key3
        break
    end

    Captured2 = nil
end
if not Captured2 and Upvalue7[ Captured ] then
    Upvalue6.SelectedObject = Upvalue7[ Captured ].button
    Captured2 = Captured
end
if not Captured2 then
    return
end

local Text
local Entry = Upvalue11.Layout( )[ Captured2 ]

if Captured2 == Upvalue11.FISTS then
    Text = "Fists"
elseif Entry then
    local Entry2 = Upvalue13[ Entry:GetAttribute( "Weapon" ) ]

    if not Entry2 or not Entry2.Name then
        local DisplayName = Entry:GetAttribute( "DisplayName" )

        if DisplayName then
            Text = DisplayName
        else
            Text = Entry.Name
        end
    else
        Text = Entry2.Name
    end
    if not Text then
        if Upvalue11.IsProtectedCase( Captured2 ) then
            Text = "Protected: never lost, can't be used from here"
        else
            Text = Upvalue14
        end
    end
elseif Upvalue11.IsProtectedCase( Captured2 ) then
    Text = "Protected: never lost, can't be used from here"
else
    Text = Upvalue14
end

Upvalue12.Text = Text
]]

--[[
Function #84 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local MouseLocation

if Argument1.UserInputType == Enum.UserInputType.MouseMovement then
    MouseLocation = Upvalue2:GetMouseLocation( ) - Upvalue3:GetGuiInset( )
    local MouseLocation2 = MouseLocation - Upvalue1.grab - Upvalue4.AbsolutePosition
    Upvalue5.Position = Upvalue6.FromAbs( Upvalue5, MouseLocation2.X, MouseLocation2.Y )
    local Value1 = Upvalue7( MouseLocation )

    if Value1 ~= Upvalue8 then
        Upvalue8 = Value1
        Upvalue9( )
    end

    return
end
if Argument1.UserInputType ~= Enum.UserInputType.Touch then
    return
end

MouseLocation = Vector2.new( Argument1.Position.X, Argument1.Position.Y )
local MouseLocation2 = MouseLocation - Upvalue1.grab - Upvalue4.AbsolutePosition
Upvalue5.Position = Upvalue6.FromAbs( Upvalue5, MouseLocation2.X, MouseLocation2.Y )
local Value1 = Upvalue7( MouseLocation )

if Value1 ~= Upvalue8 then
    Upvalue8 = Value1
    Upvalue9( )
end

return
]]

--[[
Function #85 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.UserInputType == Enum.UserInputType.MouseButton1 then
    Upvalue1( true )
    return
end
if Argument1.UserInputType == Enum.UserInputType.Touch then
    Upvalue1( true, Vector2.new( Argument1.Position.X, Argument1.Position.Y ) )
end
]]

--[[
Function #86 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1[ 1 ].button
]]

--[[
Function #87 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil

    if Upvalue2 and Upvalue3 then
        Upvalue2.Text = Upvalue3
    end
    if Upvalue4 then
        Upvalue4( )
    end
    if Upvalue5 then
        Upvalue5.Visible = false
        return
    end
elseif Upvalue6 then
    Upvalue6 = nil
    Upvalue7 = false

    if Upvalue8 then
        Upvalue8.Visible = false
        return
    end
elseif Upvalue9 then
    Upvalue9 = nil
    Upvalue10 = nil
    Upvalue11.Visible = false

    if Upvalue12 and Upvalue13 then
        Upvalue13( )
    end
    if Upvalue10 then
        Upvalue14.SelectedObject = Upvalue10
        return
    end
elseif Upvalue12 then
    Upvalue9 = nil
    Upvalue10 = nil
    Upvalue11.Visible = false

    if Upvalue12 and Upvalue13 then
        Upvalue13( )
    end
    if Upvalue15 then
        Upvalue14.SelectedObject = Upvalue15
        return
    end
else
    if Upvalue16 then
        Upvalue16 = nil
        Upvalue17( )
        return
    end

    Upvalue18( false )
end
]]

--[[
Function #88 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

--[[
Function #89 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Visible

if not Visible then
    if Upvalue2 then
        local From = Upvalue2.from
        local Start = Upvalue2.start
        local WasOpen = Upvalue2.wasOpen

        if Upvalue2.touch == true then
            if os.clock( ) - ( Upvalue2.t0 or 0 ) < 0.4 then
            end
        end

        Upvalue2 = nil
        Upvalue3 = nil
        Upvalue4.Visible = false
        local MouseLocation = Upvalue5:GetMouseLocation( ) - Upvalue6:GetGuiInset( )
        Upvalue7( )
    end

    Upvalue8 = nil
    Upvalue9 = nil
    Upvalue10.Visible = false

    if Upvalue11 and Upvalue12 then
        Upvalue12( )
    end

    Upvalue13 = nil

    if Upvalue14 and Upvalue15 then
        Upvalue14.Text = Upvalue15
    end
    if Upvalue16 then
        Upvalue16( )
    end
    if Upvalue17 then
        Upvalue17.Visible = false
    end

    Upvalue18 = nil
    Upvalue19 = false

    if Upvalue20 then
        Upvalue20.Visible = false
    end
end

Upvalue21 = nil
Upvalue22.Visible = Visible
Upvalue23.Visible = Visible

if Visible or Upvalue24.WardrobeOpen ~= true then
    Upvalue24.CursorFree = Visible
end
if Upvalue25 then
    Upvalue25:Cancel( )
end
if Visible then
    Upvalue26.Scale = 0.92
    Upvalue25 = Upvalue27:Create( Upvalue26, TweenInfo.new( 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } )
    Upvalue25:Play( )
end
if Visible then
    Upvalue28.Open( "Inventory", {
        root = Upvalue23,
        first = function()
            return Upvalue29[ 1 ].button
        end,
        onBack = function()
            if Upvalue13 then
                Upvalue13 = nil

                if Upvalue14 and Upvalue15 then
                    Upvalue14.Text = Upvalue15
                end
                if Upvalue16 then
                    Upvalue16( )
                end
                if Upvalue17 then
                    Upvalue17.Visible = false
                    return
                end
            elseif Upvalue18 then
                Upvalue18 = nil
                Upvalue19 = false

                if Upvalue20 then
                    Upvalue20.Visible = false
                    return
                end
            elseif Upvalue8 then
                Upvalue8 = nil
                Upvalue9 = nil
                Upvalue10.Visible = false

                if Upvalue11 and Upvalue12 then
                    Upvalue12( )
                end
                if Upvalue9 then
                    Upvalue6.SelectedObject = Upvalue9
                    return
                end
            elseif Upvalue11 then
                Upvalue8 = nil
                Upvalue9 = nil
                Upvalue10.Visible = false

                if Upvalue11 and Upvalue12 then
                    Upvalue12( )
                end
                if Upvalue30 then
                    Upvalue6.SelectedObject = Upvalue30
                    return
                end
            else
                if Upvalue21 then
                    Upvalue21 = nil
                    Upvalue7( )
                    return
                end

                Upvalue31( false )
            end
        end,
        actions = {
            [ Enum.KeyCode.ButtonSelect ] = {
                label = "Close",
                fn = function()
                    Upvalue31( false )
                end
            },
            [ Enum.KeyCode.ButtonX ] = { label = "Drop", fn = Upvalue32 },
            [ Enum.KeyCode.ButtonY ] = { label = "Quick move", fn = Upvalue33 }
        },
        selectLabel = "Take / Place"
    } )
else
    Upvalue28.Close( "Inventory" )
end

local Captured

if not Upvalue35.IsGamepad or not Upvalue36 then
    if Upvalue5:GetLastInputType( ) ~= Enum.UserInputType.Touch or not Upvalue37 then
        Captured = Upvalue38
    else
        Captured = Upvalue37
    end
else
    Captured = Upvalue36
end

Upvalue34 = Captured

if Visible then
    Upvalue39.Text = Upvalue34
    Upvalue7( )
end
]]

--[[
Function #90 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = false

    if Upvalue2 then
        local From = Upvalue2.from
        local Start = Upvalue2.start
        local WasOpen = Upvalue2.wasOpen

        if Upvalue2.touch == true then
            if os.clock( ) - ( Upvalue2.t0 or 0 ) < 0.4 then
            end
        end

        Upvalue2 = nil
        Upvalue3 = nil
        Upvalue4.Visible = false
        local MouseLocation = Upvalue5:GetMouseLocation( ) - Upvalue6:GetGuiInset( )
        Upvalue7( )
    end

    Upvalue8 = nil
    Upvalue9 = nil
    Upvalue10.Visible = false

    if Upvalue11 and Upvalue12 then
        Upvalue12( )
    end

    Upvalue13 = nil

    if Upvalue14 and Upvalue15 then
        Upvalue14.Text = Upvalue15
    end
    if Upvalue16 then
        Upvalue16( )
    end
    if Upvalue17 then
        Upvalue17.Visible = false
    end

    Upvalue18 = nil
    Upvalue19 = false

    if Upvalue20 then
        Upvalue20.Visible = false
    end

    Upvalue21 = nil
    Upvalue22.Visible = false
    Upvalue23.Visible = false

    if Upvalue24.WardrobeOpen ~= true then
        Upvalue24.CursorFree = false
    end
    if Upvalue25 then
        Upvalue25:Cancel( )
    end

    local Captured
    Upvalue26.Close( "Inventory" )

    if not Upvalue28.IsGamepad or not Upvalue29 then
        if Upvalue5:GetLastInputType( ) ~= Enum.UserInputType.Touch or not Upvalue30 then
            Captured = Upvalue31
        else
            Captured = Upvalue30
        end
    else
        Captured = Upvalue29
    end

    Upvalue27 = Captured
end
]]

--[[
Function #91 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Text == "Select an item, then DROP" then
    Upvalue1.Text = Upvalue2
end
]]

--[[
Function #92 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if Upvalue2 and Upvalue3.Layout( )[ Upvalue2 ] and Upvalue4( Upvalue2 and Upvalue3.Layout( )[ Upvalue2 ] ) then
    Upvalue2 = nil
    Upvalue5( )
    return
end
if Upvalue6.Text ~= "Select an item, then DROP" then
    Upvalue6.Text = "Select an item, then DROP"
    task.delay( 2, function()
        if Upvalue6.Text == "Select an item, then DROP" then
            Upvalue6.Text = Upvalue7
        end
    end )
end
]]

--[[
Function #93 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue2.WardrobeOpen == true then
    Upvalue1 = false

    if Upvalue3 then
        local From = Upvalue3.from
        local Start = Upvalue3.start
        local WasOpen = Upvalue3.wasOpen

        if Upvalue3.touch == true then
            if os.clock( ) - ( Upvalue3.t0 or 0 ) < 0.4 then
            end
        end

        Upvalue3 = nil
        Upvalue4 = nil
        Upvalue5.Visible = false
        local MouseLocation = Upvalue6:GetMouseLocation( ) - Upvalue7:GetGuiInset( )
        Upvalue8( )
    end

    Upvalue9 = nil
    Upvalue10 = nil
    Upvalue11.Visible = false

    if Upvalue12 and Upvalue13 then
        Upvalue13( )
    end

    Upvalue14 = nil

    if Upvalue15 and Upvalue16 then
        Upvalue15.Text = Upvalue16
    end
    if Upvalue17 then
        Upvalue17( )
    end
    if Upvalue18 then
        Upvalue18.Visible = false
    end

    Upvalue19 = nil
    Upvalue20 = false

    if Upvalue21 then
        Upvalue21.Visible = false
    end

    Upvalue22 = nil
    Upvalue23.Visible = false
    Upvalue24.Visible = false

    if Upvalue2.WardrobeOpen ~= true then
        Upvalue2.CursorFree = false
    end
    if Upvalue25 then
        Upvalue25:Cancel( )
    end

    local Captured
    Upvalue26.Close( "Inventory" )

    if not Upvalue28.IsGamepad or not Upvalue29 then
        if Upvalue6:GetLastInputType( ) ~= Enum.UserInputType.Touch or not Upvalue30 then
            Captured = Upvalue31
        else
            Captured = Upvalue30
        end
    else
        Captured = Upvalue29
    end

    Upvalue27 = Captured
end
]]

--[[
Function #94 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    task.wait( 0.2 )

    if Upvalue1 and Upvalue2.Downed then
        Upvalue1 = false

        if Upvalue3 then
            local From = Upvalue3.from
            local Start = Upvalue3.start
            local WasOpen = Upvalue3.wasOpen

            if Upvalue3.touch == true then
                if os.clock( ) - ( Upvalue3.t0 or 0 ) < 0.4 then
                end
            end

            Upvalue3 = nil
            Upvalue4 = nil
            Upvalue5.Visible = false
            local MouseLocation = Upvalue6:GetMouseLocation( ) - Upvalue7:GetGuiInset( )
            Upvalue8( )
        end

        Upvalue9 = nil
        Upvalue10 = nil
        Upvalue11.Visible = false

        if Upvalue12 and Upvalue13 then
            Upvalue13( )
        end

        Upvalue14 = nil

        if Upvalue15 and Upvalue16 then
            Upvalue15.Text = Upvalue16
        end
        if Upvalue17 then
            Upvalue17( )
        end
        if Upvalue18 then
            Upvalue18.Visible = false
        end

        Upvalue19 = nil
        Upvalue20 = false

        if Upvalue21 then
            Upvalue21.Visible = false
        end

        Upvalue22 = nil
        Upvalue23.Visible = false
        Upvalue24.Visible = false

        if Upvalue2.WardrobeOpen ~= true then
            Upvalue2.CursorFree = false
        end
        if Upvalue25 then
            Upvalue25:Cancel( )
        end

        local Captured
        Upvalue26.Close( "Inventory" )

        if not Upvalue28.IsGamepad or not Upvalue29 then
            if Upvalue6:GetLastInputType( ) ~= Enum.UserInputType.Touch or not Upvalue30 then
                Captured = Upvalue31
            else
                Captured = Upvalue30
            end
        else
            Captured = Upvalue29
        end

        Upvalue27 = Captured
    end
end
]]

--[[
Function #95 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Is( "Inventory", Argument1 ) then
    return
end
if Argument2 then
    return
end
if Upvalue2:GetFocusedTextBox( ) then
    return
end
if not Upvalue3 and Upvalue4.CursorFree then
    return
end
if Upvalue3 or not Upvalue4.Downed then
    Upvalue5( not Upvalue3 )
    return
end
return
]]

--[[
Function #96 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #97 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #98 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.ChildAdded:Connect( function()
    Upvalue1( )
end )
Argument1.ChildRemoved:Connect( function()
    Upvalue1( )
end )
]]

--[[
Function #99 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Backpack" ) then
    Upvalue1( Object )
end
]]

--[[
Function #100 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #101 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #102 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while os.clock( ) - Clock < 30 do
    if Upvalue1.LayoutReady( ) and Upvalue2:GetAttribute( "CarriedBack" ) then
        break
    end

    task.wait( 0.25 )
end
while Upvalue3 do
    if not ( os.clock( ) - Clock < 60 ) then
        break
    end

    task.wait( 0.25 )
end
if Upvalue3 or not Upvalue4.Parent then
    return
end

local Value1, Value2
local Layout = Upvalue1.Layout( )
Value1 = nil

for Key, Value in Layout, nil, nil do
    if Value == Upvalue4 then
        Value2 = Key
        break
    end

    Value2 = nil
end
if not Value2 or Value2 <= Upvalue1.HOTBAR then
    return
end

local Value3
local FISTS = Upvalue1.FISTS + 1
local HOTBAR = Upvalue1.HOTBAR
local I = FISTS
Value3 = nil

for I = FISTS, HOTBAR do
    if Upvalue1.IsWeapon( Layout[ I ] ) then
        Value3 = I
        break
    end

    Value3 = nil
end
if not Value3 then
    local FISTS2 = Upvalue1.FISTS + 1
    local HOTBAR2 = Upvalue1.HOTBAR
    local I2 = FISTS2

    for I2 = FISTS2, HOTBAR2 do
        if Layout[ I2 ] == nil then
            Value3 = I2
            break
        end
    end
end
if Value3 then
    Upvalue1.Move( Value2, Value3 )
end
]]

--[[
Function #103 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Key ] or not Key:IsA( "Tool" ) or Key:GetAttribute( "ToBar" ) ~= true then
    return
end
Upvalue1[ Key ] = true
task.spawn( function()
    local Clock = os.clock( )

    while os.clock( ) - Clock < 30 do
        if Upvalue2.LayoutReady( ) and Upvalue3:GetAttribute( "CarriedBack" ) then
            break
        end

        task.wait( 0.25 )
    end
    while Upvalue4 do
        if not ( os.clock( ) - Clock < 60 ) then
            break
        end

        task.wait( 0.25 )
    end
    if Upvalue4 or not Key.Parent then
        return
    end

    local Value1, Value2
    local Layout = Upvalue2.Layout( )
    Value1 = nil

    for KeyInner, Value in Layout, nil, nil do
        if Value == Key then
            Value2 = KeyInner
            break
        end

        Value2 = nil
    end
    if not Value2 or Value2 <= Upvalue2.HOTBAR then
        return
    end

    local Value3
    local FISTS = Upvalue2.FISTS + 1
    local HOTBAR = Upvalue2.HOTBAR
    local I = FISTS
    Value3 = nil

    for I = FISTS, HOTBAR do
        if Upvalue2.IsWeapon( Layout[ I ] ) then
            Value3 = I
            break
        end

        Value3 = nil
    end
    if not Value3 then
        local FISTS2 = Upvalue2.FISTS + 1
        local HOTBAR2 = Upvalue2.HOTBAR
        local I2 = FISTS2

        for I2 = FISTS2, HOTBAR2 do
            if Layout[ I2 ] == nil then
                Value3 = I2
                break
            end
        end
    end
    if Value3 then
        Upvalue2.Move( Value2, Value3 )
    end
end )
return
]]

--[[
Function #104 has no emitted closure site
It is reproduced here so that nothing is lost

Self.ChildAdded:Connect( Upvalue1 )

for Key, Value in Self:GetChildren( ) do
    Upvalue1( Value )
end
]]

--[[
Function #105 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Backpack" ) then
    Self.ChildAdded:Connect( Upvalue1 )

    for Key, Value in Self:GetChildren( ) do
        Upvalue1( Value )
    end
end
]]

--[[
Function #106 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2( )
end
]]

--[[
Function #107 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    task.wait( 0.25 )

    if Upvalue1 and not Upvalue2 then
        Upvalue3( )
    end
end
]]

--[[
Function #108 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IsLoaded then
    Upvalue2( )
end
]]
