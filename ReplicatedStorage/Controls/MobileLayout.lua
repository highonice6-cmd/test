-- ReplicatedStorage.Controls.MobileLayout
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #21

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Home = Value.home
local AbsoluteSize = Home.Parent.AbsoluteSize
local X = AbsoluteSize.X
local Y = AbsoluteSize.Y

if Home.SizeConstraint == Enum.SizeConstraint.RelativeYY then
    X = AbsoluteSize.Y
elseif Home.SizeConstraint == Enum.SizeConstraint.RelativeXX then
    Y = AbsoluteSize.X
end

return Vector2.new( Home.Size.X.Scale * X + Home.Size.X.Offset, Home.Size.Y.Scale * Y + Home.Size.Y.Offset )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local UIAspectRatioConstraint = Value.button:FindFirstChildOfClass( "UIAspectRatioConstraint" )

if not UIAspectRatioConstraint or not ( UIAspectRatioConstraint.AspectRatio > 0 ) or UIAspectRatioConstraint.AspectType ~= Enum.AspectType.FitWithinMaxSize then
    return Argument2
end
local X = Argument2.X
local Min = math.min( X, Argument2.Y * UIAspectRatioConstraint.AspectRatio )
return Vector2.new( Min, Min / UIAspectRatioConstraint.AspectRatio )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Home = Value.home
local AbsoluteSize = Home.Parent.AbsoluteSize
return Home.Parent.AbsolutePosition + Vector2.new( Home.Position.X.Scale * AbsoluteSize.X + Home.Position.X.Offset, Home.Position.Y.Scale * AbsoluteSize.Y + Home.Position.Y.Offset ) + ( Vector2.new( 0.5, 0.5 ) - Home.AnchorPoint ) * Upvalue1( Value, Upvalue2( Value ) ) - Upvalue3.AbsolutePosition
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Opacity = O * ( Upvalue1.Settings.TouchOpacity or 1 )

if Argument1.opacity == Opacity then
    return
end

local Value1
Argument1.opacity = Opacity
local Fade = Argument1.fade
Value1 = nil

for Key, Value in Fade, nil, nil do
    local Value2 = nil

    for Key2, Value3 in Value, nil, nil do
        Key[ Key2 ] = 1 - ( 1 - Value3 ) * Opacity
    end
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

return math.round( Amount * 1000 ) / 1000
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Apply( Upvalue2 )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local MobileLayout = Upvalue1.Settings.MobileLayout

if type( MobileLayout ) ~= "table" then
    return
end

local Value1
local Table = { }
Value1 = nil

for Key, Value in MobileLayout, nil, nil do
    local Clone2

    if type( Value ) == "table" then
        local Clone = table.clone( Value )

        if Clone then
            Clone2 = Clone
        else
            Clone2 = Value
        end
    else
        Clone2 = Value
    end

    Table[ Key ] = Clone2
end
if Upvalue2.TakeAimMode( Table ) then
    Upvalue1.Set( "MobileLayout", Table )
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "MobileLayout" and not Upvalue1.Editing then
    Upvalue2( )
end
if Name == "MobileLayout" and not Upvalue1.Editing then
    Upvalue1.Apply( Upvalue3.Settings.MobileLayout )
end
if Name == "TouchOpacity" then
    Upvalue1.Apply( Upvalue4 )
end
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return Upvalue2
end

local Value1
Upvalue1 = Argument1
Upvalue2 = Instance.new( "Frame" )
Upvalue2.Name = "Moved"
Upvalue2.BackgroundTransparency = 1
Upvalue2.Size = UDim2.fromScale( 1, 1 )
Upvalue2.Visible = false
Upvalue2.Parent = Upvalue1
Value1 = nil

for Key, Value in List, nil, nil do
    local Name
    local Button = Value.button
    local Group = Value.group
    local Table = { button = Button, group = Group, opacity = 1 }
    Name = Group and Group.Name or "Gui"
    local Value2
    Table.key = Name .. "." .. Button.Name
    Table.fade = { }
    Table.home = {
        Parent = Button.Parent,
        Position = Button.Position,
        Size = Button.Size,
        AnchorPoint = Button.AnchorPoint,
        SizeConstraint = Button.SizeConstraint
    }
    local Table2 = { Button, table.unpack( Button:GetDescendants( ) ) }
    Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        local Value4
        local Table3 = { }
        Value4 = nil

        for Key3, Value5 in Upvalue3, nil, nil do
            if Value3:IsA( Key3 ) then
                local Value6 = nil

                for Key4, Value7 in Value5, nil, nil do
                    Table3[ Value7 ] = Value3[ Value7 ]
                end
            end
        end
        if next( Table3 ) then
            Table.fade[ Value3 ] = Table3
        end
    end

    table.insert( Upvalue4, Table )
    Upvalue5[ Button ] = Table
end

Upvalue1:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( function()
    Upvalue6.Apply( Upvalue7 )
end )

local function MigrateAim()
    local MobileLayout = Upvalue8.Settings.MobileLayout

    if type( MobileLayout ) ~= "table" then
        return
    end

    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in MobileLayout, nil, nil do
        local Clone2

        if type( Value ) == "table" then
            local Clone = table.clone( Value )

            if Clone then
                Clone2 = Clone
            else
                Clone2 = Value
            end
        else
            Clone2 = Value
        end

        Table[ Key ] = Clone2
    end
    if Upvalue6.TakeAimMode( Table ) then
        Upvalue8.Set( "MobileLayout", Table )
    end
end

Upvalue8.SettingsChanged:Connect( function( Name )
    if Name == "MobileLayout" and not Upvalue6.Editing then
        MigrateAim( )
    end
    if Name == "MobileLayout" and not Upvalue6.Editing then
        Upvalue6.Apply( Upvalue8.Settings.MobileLayout )
    end
    if Name == "TouchOpacity" then
        Upvalue6.Apply( Upvalue7 )
    end
end )
MigrateAim( )
Upvalue6.Apply( Upvalue8.Settings.MobileLayout )
return Upvalue2
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1 ~= nil and true or false
return Flag
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument1 or Argument1.Name == "Global" then
    return true
end
if Argument1.Name == "Car" then
    local Flag = PageName == "Car" and true or false
    return Flag
end
local Flag2 = PageName == "Foot" and true or false
return Flag2
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Setting = Object:GetAttribute( "Setting" )

if type( Setting ) == "string" then
    if Upvalue1.Settings[ Setting ] == false then
        Flag = false
    else
        Flag = true
    end
else
    Flag = true
end

return Flag
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Button = Argument1.button
return Button.AbsolutePosition + Button.AbsoluteSize / 2
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local AbsoluteSize = Upvalue1.AbsoluteSize
local X = AbsoluteSize.X
local Y = AbsoluteSize.Y

if X < 2 or Y < 2 then
    return
end

local Entry2
local Entry = List[ Argument1.key ]
Entry2 = if Entry then Entry else { }
local H
local Result = Upvalue2( Argument1, Upvalue3( Argument1 ) * ( Entry2.s or 1 ) ) / 2
local AbsolutePosition = Argument3 - Upvalue1.AbsolutePosition
local X2 = AbsolutePosition.X
local X3 = Result.X
local X4 = Result.X
local Clamp = math.clamp( X2, X3, ( math.max( X4, X - Result.X ) ) )
local Y2 = AbsolutePosition.Y
local Y3 = Result.Y
local Y4 = Result.Y
local Clamp2 = math.clamp( Y2, Y3, ( math.max( Y4, Y - Result.Y ) ) )

if Clamp < X / 3 then
    H = "L"
elseif X * 2 / 3 < Clamp then
    H = "R"
else
    H = "C"
end

local Clamp3
Entry2.h = H

if H ~= "L" or not Clamp then
    if H ~= "R" or not ( X - Clamp ) then
        Clamp3 = Clamp - X / 2
    else
        Clamp3 = X - Clamp
    end
else
    Clamp3 = Clamp
end

Entry2.x = math.round( Clamp3 / Y * 1000 ) / 1000
Entry2.y = math.round( Clamp2 / Y * 1000 ) / 1000
List[ Argument1.key ] = Entry2
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = type( Argument1 ) == "table" and Argument1 or { }
Upvalue1 = Table

if not Upvalue2 then
    return
end

local AbsoluteSize = Upvalue2.AbsoluteSize
local X = AbsoluteSize.X
local Y = AbsoluteSize.Y

if X < 2 or Y < 2 then
    return
end

local Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    local S
    local Entry = Upvalue1[ Value.key ]
    local Button = Value.button
    local Home = Value.home
    S = Entry and Entry.s or 1

    if Entry then
        if Entry.h or S ~= 1 then
            local Vector22
            local S2 = Upvalue4( Value ) * S
            local Result = Upvalue5( Value, S2 ) / 2

            if Entry.h then
                local X4

                if Entry.h == "L" then
                    local X2 = Entry.x * Y

                    if X2 then
                        X4 = X2
                    elseif Entry.h == "R" then
                        local X3 = X - Entry.x * Y

                        if X3 then
                            X4 = X3
                        else
                            X4 = X / 2 + Entry.x * Y
                        end
                    else
                        X4 = X / 2 + Entry.x * Y
                    end
                elseif Entry.h == "R" then
                    local X3 = X - Entry.x * Y

                    if X3 then
                        X4 = X3
                    else
                        X4 = X / 2 + Entry.x * Y
                    end
                else
                    X4 = X / 2 + Entry.x * Y
                end

                Vector22 = Vector2.new( X4, Entry.y * Y )
            else
                Vector22 = Upvalue6( Value )
            end

            local X5 = Vector22.X
            local X6 = Result.X
            local X7 = Result.X
            local Clamp = math.clamp( X5, X6, ( math.max( X7, X - Result.X ) ) )
            local Y2 = Vector22.Y
            local Y3 = Result.Y
            local Y4 = Result.Y
            local Vector23 = Vector2.new( Clamp, ( math.clamp( Y2, Y3, ( math.max( Y4, Y - Result.Y ) ) ) ) )
            Button.AnchorPoint = Vector2.new( 0.5, 0.5 )
            Button.SizeConstraint = Enum.SizeConstraint.RelativeXY
            Button.Size = UDim2.fromScale( S2.X / X, S2.Y / Y )
            Button.Position = UDim2.fromScale( Vector23.X / X, Vector23.Y / Y )

            if Button.Parent ~= Upvalue7 then
                Button.Parent = Upvalue7
            end
        else
            if Button.Parent ~= Home.Parent then
                Button.Parent = Home.Parent
            end

            local AnchorPoint = Home.AnchorPoint
            local SizeConstraint = Home.SizeConstraint
            local Size = Home.Size
            local Position = Home.Position
            Button.AnchorPoint = AnchorPoint
            Button.SizeConstraint = SizeConstraint
            Button.Size = Size
            Button.Position = Position
        end
    else
        if Button.Parent ~= Home.Parent then
            Button.Parent = Home.Parent
        end

        local AnchorPoint = Home.AnchorPoint
        local SizeConstraint = Home.SizeConstraint
        local Size = Home.Size
        local Position = Home.Position
        Button.AnchorPoint = AnchorPoint
        Button.SizeConstraint = SizeConstraint
        Button.Size = Size
        Button.Position = Position
    end

    local O = Entry and Entry.o or 1
    Upvalue8( Value, O )
end
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Action = Self:GetAttribute( "Action" )

if Action == "Aim" then
    if Upvalue1.Settings.HoldToAim == true then
        return "h"
    end
    if Self:GetAttribute( "Toggle" ) == false then
        return "h"
    end
end

return Upvalue2[ Action ]
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local DefaultMode = Upvalue1.DefaultMode( Key )

if not DefaultMode then
    return nil
end
if not List and Key:GetAttribute( "Action" ) == "Aim" then
    return DefaultMode
end

local Entry2
local Entry = Upvalue2[ Key ]
Entry2 = if Entry then ( List or Upvalue3 )[ Entry.key ] else Entry
local M2

if Entry2 then
    if Entry2.m == "t" or Entry2.m == "h" then
        local M = Entry2.m

        if M then
            M2 = M
        else
            M2 = DefaultMode
        end
    else
        M2 = DefaultMode
    end
else
    M2 = DefaultMode
end

return M2
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if type( List ) ~= "table" then
    return false
end

local Value1, Flag
Value1 = nil
Flag = false

for Key, Value in Upvalue1, nil, nil do
    local Flag2 = if Value.button:GetAttribute( "Action" ) == "Aim" then List[ Value.key ] else false

    if type( Flag2 ) == "table" then
        if Flag2.m == "t" or Flag2.m == "h" then
            local Flag3
            local Set = Upvalue2.Set
            Flag3 = Flag2.m == "h" and true or false
            Set( "HoldToAim", Flag3 )
            Flag2.m = nil
            Flag = true
        end
    end
end

return Flag
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2:Fire( )
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Fire( )
]]
