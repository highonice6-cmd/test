-- Players.perkbrokeyou.PlayerScripts.DiverPreviewClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #13

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = ( Object:GetAttribute( "Order" ) or 0 ) < ( Object2:GetAttribute( "Order" ) or 0 ) and true or false
return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent2
local WorldModel = Parent:FindFirstChildOfClass( "WorldModel" )

if WorldModel then
    Parent2 = WorldModel
else
    Parent2 = Instance.new( "WorldModel", Parent )
end
for Key, Value in Parent2:GetChildren( ) do
    Value:Destroy( )
end

local CurrentCamera3
local Clone = Object:Clone( )
Clone.Parent = Parent2
local CurrentCamera = Parent.CurrentCamera

if CurrentCamera then
    CurrentCamera3 = CurrentCamera
else
    local CurrentCamera2 = Instance.new( "Camera" )
    CurrentCamera2.FieldOfView = 26
    CurrentCamera2.Parent = Parent
    Parent.CurrentCamera = CurrentCamera2
    CurrentCamera3 = CurrentCamera2
end

local BoundingBox, BoundingBox2 = Clone:GetBoundingBox( )
return {
    cam = CurrentCamera3,
    center = BoundingBox.Position,
    dist = BoundingBox2.Y * 0.54 / math.tan( ( math.rad( CurrentCamera3.FieldOfView / 2 ) ) ),
    lift = BoundingBox2.Y * 0.03
}
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Center = Argument1.center
local Cam = Argument1.cam
local Sin = math.sin( Argument2 ) * Argument1.dist
local Lift = Argument1.lift
Cam.CFrame = CFrame.lookAt( Center + Vector3.new( Sin, Lift, math.cos( Argument2 ) * Argument1.dist ), Center )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

local Parent
Upvalue1 = true
local WorldModel = Upvalue2:FindFirstChildOfClass( "WorldModel" )

if WorldModel then
    Parent = WorldModel
else
    Parent = Instance.new( "WorldModel", Upvalue2 )
end

local CurrentCamera3
Parent:ClearAllChildren( )
local CurrentCamera = Upvalue2.CurrentCamera

if CurrentCamera then
    CurrentCamera3 = CurrentCamera
else
    local CurrentCamera2 = Instance.new( "Camera" )
    CurrentCamera2.FieldOfView = 26
    CurrentCamera2.Parent = Upvalue2
    Upvalue2.CurrentCamera = CurrentCamera2
    CurrentCamera3 = CurrentCamera2
end

local Value1 = nil

for Key, Value in Upvalue3, nil, nil do
    local Clone = Value:Clone( )
    Clone:PivotTo( CFrame.new( ( Key - 1 ) * 60, 0, 0 ) * Clone:GetPivot( ) )
    Clone.Parent = Parent
    local BoundingBox, BoundingBox2 = Clone:GetBoundingBox( )
    Upvalue4[ Key ] = {
        cam = CurrentCamera3,
        center = BoundingBox.Position,
        dist = BoundingBox2.Y * 0.54 / math.tan( ( math.rad( CurrentCamera3.FieldOfView / 2 ) ) ),
        lift = BoundingBox2.Y * 0.03
    }
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue2:Disconnect( )
    task.defer( Upvalue3 )
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
Upvalue2 = ( Amount - 1 ) % #Upvalue3 + 1
local Entry = Upvalue3[ Upvalue2 ]
Upvalue4 = Upvalue5[ Upvalue2 ]
local Center = Upvalue4.center
local Cam = Upvalue4.cam
local Dist = 0 * Upvalue4.dist
local Lift = Upvalue4.lift
Cam.CFrame = CFrame.lookAt( Center + Vector3.new( Dist, Lift, 1 * Upvalue4.dist ), Center )
local ColorName = Upvalue6.ColorName
ColorName.Text = Entry.Name
local Counter = Upvalue6.Counter
Counter.Text = Upvalue2 .. " / " .. #Upvalue3

for Key, Value in Upvalue7:GetChildren( ) do
    local UIStroke
    local Number = tonumber( string.match( Value.Name, "^C(%d+)$" ) )
    local IsA = Value:IsA( "GuiObject" )

    if IsA then
        UIStroke = Value:FindFirstChildOfClass( "UIStroke" )
    else
        UIStroke = IsA
    end
    if Number and UIStroke then
        local Thickness = Number ~= Upvalue2 and 0.06 or 0.14
        local Color
        UIStroke.Thickness = Thickness

        if Number == Upvalue2 then
            local FromRGB = Color3.fromRGB( 90, 180, 255 )

            if FromRGB then
                Color = FromRGB
            else
                Color = Color3.new( 1, 1, 1 )
            end
        else
            Color = Color3.new( 1, 1, 1 )
        end

        UIStroke.Color = Color
    end
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = false
local Showcase = Upvalue2:FindFirstChild( "Showcase" )

if Showcase then
    Showcase.Visible = true
end
if Upvalue3 then
    Upvalue3:Disconnect( )
    Upvalue3 = nil
end
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Visible or not Upvalue1:IsDescendantOf( game ) then
    Upvalue1.Visible = false
    local Showcase = Upvalue2:FindFirstChild( "Showcase" )

    if Showcase then
        Showcase.Visible = true
    end
    if Upvalue3 then
        Upvalue3:Disconnect( )
        Upvalue3 = nil
    end

    return
end
if Upvalue4 then
    local Sin = math.sin( ( os.clock( ) - Upvalue5 ) * 0.9 ) * 0.45
    local Center = Upvalue4.center
    local Cam = Upvalue4.cam
    local Sin2 = math.sin( Sin ) * Upvalue4.dist
    local Lift = Upvalue4.lift
    Cam.CFrame = CFrame.lookAt( Center + Vector3.new( Sin2, Lift, math.cos( Sin ) * Upvalue4.dist ), Center )
end

return
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
Upvalue3.Visible = true

if Upvalue4 then
    Upvalue4 = false
    Upvalue5.ImageTransparency = 1
    game:GetService( "TweenService" ):Create( Upvalue5, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { ImageTransparency = 0 } ):Play( )
end

local Showcase = Upvalue6:FindFirstChild( "Showcase" )

if Showcase then
    Showcase.Visible = false
end
if Upvalue7 then
    Upvalue7:Disconnect( )
end

local Clock = os.clock( )
Upvalue7 = Upvalue8.RenderStepped:Connect( function()
    if not Upvalue3.Visible or not Upvalue3:IsDescendantOf( game ) then
        Upvalue3.Visible = false
        local Showcase = Upvalue6:FindFirstChild( "Showcase" )

        if Showcase then
            Showcase.Visible = true
        end
        if Upvalue7 then
            Upvalue7:Disconnect( )
            Upvalue7 = nil
        end

        return
    end
    if Upvalue9 then
        local Sin = math.sin( ( os.clock( ) - Clock ) * 0.9 ) * 0.45
        local Center = Upvalue9.center
        local Cam = Upvalue9.cam
        local Sin2 = math.sin( Sin ) * Upvalue9.dist
        local Lift = Upvalue9.lift
        Cam.CFrame = CFrame.lookAt( Center + Vector3.new( Sin2, Lift, math.cos( Sin ) * Upvalue9.dist ), Center )
    end

    return
end )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 - 1 )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 + 1 )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Visible and Upvalue2.Visible then
    Upvalue2.Visible = false
    local Showcase = Upvalue3:FindFirstChild( "Showcase" )

    if Showcase then
        Showcase.Visible = true
    end
    if Upvalue4 then
        Upvalue4:Disconnect( )
        Upvalue4 = nil
    end
end
]]
