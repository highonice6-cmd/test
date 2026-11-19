-- StarterPlayer.PlayerModule.ControlModule.ClickToMoveDisplay
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #38

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Adornee = Instance.new( "Part" )
Adornee.Size = Vector3.new( 1, 1, 1 )
Adornee.Anchored = true
Adornee.CanCollide = false
Adornee.Name = "TrailDot"
Adornee.Transparency = 1
local ImageHandleAdornment = Instance.new( "ImageHandleAdornment" )
ImageHandleAdornment.Name = "TrailDotImage"
ImageHandleAdornment.Size = Upvalue1
ImageHandleAdornment.SizeRelativeOffset = Vector3.new( 0, 0, -0.10000000149011612 )
ImageHandleAdornment.AlwaysOnTop = Upvalue2
ImageHandleAdornment.Image = Upvalue3
ImageHandleAdornment.Adornee = Adornee
ImageHandleAdornment.Parent = Adornee
local Adornee2 = Instance.new( "Part" )
Adornee2.Size = Vector3.new( 2, 2, 2 )
Adornee2.Anchored = true
Adornee2.CanCollide = false
Adornee2.Name = "EndWaypoint"
Adornee2.Transparency = 1
local ImageHandleAdornment2 = Instance.new( "ImageHandleAdornment" )
ImageHandleAdornment2.Name = "TrailDotImage"
ImageHandleAdornment2.Size = Upvalue1
ImageHandleAdornment2.SizeRelativeOffset = Vector3.new( 0, 0, -0.10000000149011612 )
ImageHandleAdornment2.AlwaysOnTop = Upvalue2
ImageHandleAdornment2.Image = Upvalue3
ImageHandleAdornment2.Adornee = Adornee2
ImageHandleAdornment2.Parent = Adornee2
local Parent = Instance.new( "BillboardGui" )
Parent.Name = "EndWaypointBillboard"
Parent.Size = Upvalue4
Parent.LightInfluence = 0
Parent.SizeOffset = Upvalue5
Parent.AlwaysOnTop = true
Parent.Adornee = Adornee2
Parent.Parent = Adornee2
local ImageLabel = Instance.new( "ImageLabel" )
ImageLabel.Image = Upvalue6
ImageLabel.BackgroundTransparency = 1
ImageLabel.Size = UDim2.new( 1, 0, 1, 0 )
ImageLabel.Parent = Parent
local Adornee3 = Instance.new( "Part" )
Adornee3.Size = Vector3.new( 2, 2, 2 )
Adornee3.Anchored = true
Adornee3.CanCollide = false
Adornee3.Name = "FailureWaypoint"
Adornee3.Transparency = 1
local ImageHandleAdornment3 = Instance.new( "ImageHandleAdornment" )
ImageHandleAdornment3.Name = "TrailDotImage"
ImageHandleAdornment3.Size = Upvalue1
ImageHandleAdornment3.SizeRelativeOffset = Vector3.new( 0, 0, -0.10000000149011612 )
ImageHandleAdornment3.AlwaysOnTop = Upvalue2
ImageHandleAdornment3.Image = Upvalue3
ImageHandleAdornment3.Adornee = Adornee3
ImageHandleAdornment3.Parent = Adornee3
local Parent2 = Instance.new( "BillboardGui" )
Parent2.Name = "FailureWaypointBillboard"
Parent2.Size = Upvalue4
Parent2.LightInfluence = 0
Parent2.SizeOffset = Upvalue7
Parent2.AlwaysOnTop = true
Parent2.Adornee = Adornee3
Parent2.Parent = Adornee3
local Parent3 = Instance.new( "Frame" )
Parent3.BackgroundTransparency = 1
Parent3.Size = UDim2.new( 0, 0, 0, 0 )
Parent3.Position = UDim2.new( 0.5, 0, 1, 0 )
Parent3.Parent = Parent2
local ImageLabel2 = Instance.new( "ImageLabel" )
ImageLabel2.Image = Upvalue6
ImageLabel2.BackgroundTransparency = 1
local Amount = -Upvalue4.X.Offset / 2
ImageLabel2.Position = UDim2.new( 0, Amount, 0, -Upvalue4.Y.Offset )
ImageLabel2.Size = Upvalue4
ImageLabel2.Parent = Parent3
return Adornee, Adornee2, Adornee3
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local ClickToMoveDisplay2
local Parent = Upvalue1.CurrentCamera
local ClickToMoveDisplay = Parent:FindFirstChild( "ClickToMoveDisplay" )

if ClickToMoveDisplay then
    ClickToMoveDisplay2 = ClickToMoveDisplay
else
    local Model = Instance.new( "Model" )
    Model.Name = "ClickToMoveDisplay"
    Model.Parent = Parent
    ClickToMoveDisplay2 = Model
end

return ClickToMoveDisplay2
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue2.FilterDescendantsInstances = { Upvalue3.CurrentCamera, Upvalue4.Character }
    local Raycast = Upvalue3:Raycast( Argument2 + Vector3.new( 0, 2.5, 0 ), Vector3.new( -0, -10, -0 ), Upvalue2 )

    if Raycast then
        local Parent2
        Argument1.CFrame = CFrame.lookAlong( Raycast.Position, Raycast.Normal )
        local Parent = Upvalue3.CurrentCamera
        local ClickToMoveDisplay = Parent:FindFirstChild( "ClickToMoveDisplay" )

        if ClickToMoveDisplay then
            Parent2 = ClickToMoveDisplay
        else
            local Model = Instance.new( "Model" )
            Model.Name = "ClickToMoveDisplay"
            Model.Parent = Parent
            Parent2 = Model
        end

        Argument1.Parent = Parent2
        return
    end
else
    local Ray2 = Ray.new( Argument2 + Vector3.new( 0, 2.5, 0 ), Vector3.new( 0, -10, 0 ) )
    local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList3 = Upvalue3:FindPartOnRayWithIgnoreList( Ray2, { Upvalue3.CurrentCamera, Upvalue4.Character } )

    if FoundPartOnRayWithIgnoreList then
        local Parent4
        Argument1.CFrame = CFrame.new( FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList2 + FoundPartOnRayWithIgnoreList3 )
        local Parent3 = Upvalue3.CurrentCamera
        local ClickToMoveDisplay2 = Parent3:FindFirstChild( "ClickToMoveDisplay" )

        if ClickToMoveDisplay2 then
            Parent4 = ClickToMoveDisplay2
        else
            local Model2 = Instance.new( "Model" )
            Model2.Name = "ClickToMoveDisplay"
            Model2.Parent = Parent3
            Parent4 = Model2
        end

        Argument1.Parent = Parent4
    end
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.DisplayModel:Destroy( )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Clone = Upvalue1:Clone( )
Upvalue2( Clone, Argument2 )
return Clone
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Self = setmetatable( { }, Upvalue1 )
Self.DisplayModel = Self:NewDisplayModel( Argument1 )
Self.ClosestWayPoint = ClosestWayPoint
return Self
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.Destroyed = true
Argument1.Tween:Cancel( )
Argument1.DisplayModel:Destroy( )
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Clone = Upvalue1:Clone( )
Upvalue2( Clone, Argument2 )
return Clone
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local TweenInfo2 = TweenInfo.new( 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true )
local Create = Upvalue1:Create( Argument1.DisplayModel.EndWaypointBillboard, TweenInfo2, { SizeOffset = Upvalue2 } )
Create:Play( )
return Create
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Position = Argument2 - Argument1.DisplayModel.Position
local EndWaypointBillboard = Argument1.DisplayModel.EndWaypointBillboard
EndWaypointBillboard.StudsOffset = Vector3.new( 0, Position.Y, 0 )
local TweenInfo2 = TweenInfo.new( 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out )
local Create = Upvalue1:Create( Argument1.DisplayModel.EndWaypointBillboard, TweenInfo2, { StudsOffset = Vector3.new( 0, 0, 0 ) } )
Create:Play( )
return Create
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Tween.Completed:Wait( )

if not Upvalue1.Destroyed then
    Upvalue1.Tween = Upvalue1:CreateTween( )
end
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Self = setmetatable( { }, Upvalue1 )
Self.DisplayModel = Self:NewDisplayModel( Argument1 )
Self.Destroyed = false

if not Argument3 or not ( ( Argument3 - Argument1 ).Magnitude > 5 ) then
    Self.Tween = Self:CreateTween( )
else
    Self.Tween = Self:TweenInFrom( Argument3 )
    coroutine.wrap( function()
        Self.Tween.Completed:Wait( )

        if not Self.Destroyed then
            Self.Tween = Self:CreateTween( )
        end
    end )( )
end

Self.ClosestWayPoint = ClosestWayPoint
return Self
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.DisplayModel.Parent = nil
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.DisplayModel:Destroy( )
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Clone = Upvalue1:Clone( )
Upvalue2( Clone, Argument2 )

if Upvalue3 then
    Upvalue4.FilterDescendantsInstances = { Upvalue5.CurrentCamera, Upvalue6.Character }
    local Raycast = Upvalue5:Raycast( Argument2 + Vector3.new( 0, 2.5, 0 ), Vector3.new( -0, -10, -0 ), Upvalue4 )

    if Raycast then
        local Parent2
        Clone.CFrame = CFrame.lookAlong( Raycast.Position, Raycast.Normal )
        local Parent = Upvalue5.CurrentCamera
        local ClickToMoveDisplay = Parent:FindFirstChild( "ClickToMoveDisplay" )

        if ClickToMoveDisplay then
            Parent2 = ClickToMoveDisplay
        else
            local Model = Instance.new( "Model" )
            Model.Name = "ClickToMoveDisplay"
            Model.Parent = Parent
            Parent2 = Model
        end

        Clone.Parent = Parent2
        return Clone
    end
else
    local Ray2 = Ray.new( Argument2 + Vector3.new( 0, 2.5, 0 ), Vector3.new( 0, -10, 0 ) )
    local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList3 = Upvalue5:FindPartOnRayWithIgnoreList( Ray2, { Upvalue5.CurrentCamera, Upvalue6.Character } )

    if FoundPartOnRayWithIgnoreList then
        local Parent4
        Clone.CFrame = CFrame.new( FoundPartOnRayWithIgnoreList2, FoundPartOnRayWithIgnoreList2 + FoundPartOnRayWithIgnoreList3 )
        local Parent3 = Upvalue5.CurrentCamera
        local ClickToMoveDisplay2 = Parent3:FindFirstChild( "ClickToMoveDisplay" )

        if ClickToMoveDisplay2 then
            Parent4 = ClickToMoveDisplay2
        else
            local Model2 = Instance.new( "Model" )
            Model2.Name = "ClickToMoveDisplay"
            Model2.Parent = Parent3
            Parent4 = Model2
        end

        Clone.Parent = Parent4
    end
end

return Clone
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

wait( 0.125 )
local TweenInfo2 = TweenInfo.new( 0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out )
local Create = Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard, TweenInfo2, { SizeOffset = Upvalue2 } )
Create:Play( )
Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo2, { Rotation = 10 } ):Play( )
Create.Completed:wait( )
local TweenInfo3 = TweenInfo.new( 0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true )
local Create2 = Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard, TweenInfo3, { SizeOffset = Upvalue3 } )
Create2:Play( )
local TweenInfo4 = TweenInfo.new( 0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true )
local ImageLabel = Argument1.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel
Upvalue1:Create( ImageLabel, TweenInfo4, { ImageColor3 = Color3.new( 0.75, 0.75, 0.75 ) } ):Play( )
Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo4, { Rotation = -10 } ):Play( )
Create2.Completed:wait( )
local TweenInfo5 = TweenInfo.new( 0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out )
local Create3 = Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard, TweenInfo5, { SizeOffset = Upvalue4 } )
Create3:Play( )
Upvalue1:Create( Argument1.DisplayModel.FailureWaypointBillboard.Frame, TweenInfo5, { Rotation = 0 } ):Play( )
Create3.Completed:wait( )
wait( 0.125 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Self = setmetatable( { }, Upvalue1 )
Self.DisplayModel = Self:NewDisplayModel( Argument1 )
return Self
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if Humanoid == nil then
    return Upvalue1
end
Upvalue1 = Humanoid:LoadAnimation( Upvalue2 )
assert( Upvalue1, "" )
Upvalue1.Priority = Enum.AnimationPriority.Action
Upvalue1.Looped = false
return Upvalue1
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Character = Upvalue1.Character

if Character then
    return Character:FindFirstChildOfClass( "Humanoid" )
end
return
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local Table = { }
local Count = #List - 1
local I = 1
Number = 1

for I = 1, Count do
    local Flag = ( List[ I ].Position - List[ #List ].Position ).Magnitude < 3 and true or false
    local Flag2 = if I % 2 == 0 then not Flag else false

    if Flag2 then
        local New = Upvalue1.new
        Table[ Number ] = New( List[ I ].Position, I )
        Number = Number + 1
    end
end

local Number2
local New2 = Upvalue2.new
local Position = List[ #List ].Position
table.insert( Table, ( New2( Position, #List, Argument2 ) ) )
local Table2 = { }
local Count2 = #Table
local I2 = Count2
Number2 = 1

for I2 = Count2, 1, -1 do
    Table2[ Number2 ] = Table[ I2 ]
    Number2 = Number2 + 1
end

return Table2
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

return Argument2 * ( math.clamp( Amount - 10, 0, 90 ) / 90 * 1.5 + 1 )
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local Count = #Upvalue1
local I = Count

for I = Count, 1, -1 do
    local Entry = Upvalue1[ I ]

    if not ( Entry.ClosestWayPoint <= Argument1 ) then
        break
    end

    Entry:Destroy( )
    Upvalue1[ I ] = nil
end
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

if #Upvalue1 == 0 then
    Upvalue2:UnbindFromRenderStep( Upvalue3 )
    return
end

local Position = Upvalue4.CurrentCamera.CFrame.Position
local Count = #Upvalue1
local I = 1

for I = 1, Count do
    local TrailDotImage = Upvalue1[ I ].DisplayModel:FindFirstChild( "TrailDotImage" )

    if TrailDotImage then
        TrailDotImage.Size = Upvalue5 * ( math.clamp( ( Upvalue1[ I ].DisplayModel.Position - Position ).Magnitude - 10, 0, 90 ) / 90 * 1.5 + 1 )
    end
end
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( #Upvalue2 )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
local Value1 = Upvalue2( Argument1, Argument2 )

local function RemovePathBeforePoint( Argument1 )
    local Count = #Value1
    local I = Count

    for I = Count, 1, -1 do
        local Entry = Value1[ I ]

        if not ( Entry.ClosestWayPoint <= Argument1 ) then
            break
        end

        Entry:Destroy( )
        Value1[ I ] = nil
    end
end

local Text = "ClickToMoveResizeTrail" .. Upvalue1

local function ResizeTrailDots()
    if #Value1 == 0 then
        Upvalue3:UnbindFromRenderStep( Text )
        return
    end

    local Position = Upvalue4.CurrentCamera.CFrame.Position
    local Count = #Value1
    local I = 1

    for I = 1, Count do
        local TrailDotImage = Value1[ I ].DisplayModel:FindFirstChild( "TrailDotImage" )

        if TrailDotImage then
            TrailDotImage.Size = Upvalue5 * ( math.clamp( ( Value1[ I ].DisplayModel.Position - Position ).Magnitude - 10, 0, 90 ) / 90 * 1.5 + 1 )
        end
    end
end

Upvalue3:BindToRenderStep( Text, Enum.RenderPriority.Camera.Value - 1, ResizeTrailDots )
return function()
    RemovePathBeforePoint( #Argument1 )
end, RemovePathBeforePoint
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:RunFailureTween( )
Upvalue1:Destroy( )
Upvalue1 = nil
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Hide( )
end

local New = Upvalue2.new( Waypoint )
Upvalue1 = New
coroutine.wrap( function()
    New:RunFailureTween( )
    New:Destroy( )
    New = nil
end )( )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.new( Argument1 )
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Character = Upvalue1.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = nil
end
if Humanoid then
    local Captured

    if Humanoid == nil then
        Captured = Upvalue2
    else
        Upvalue2 = Humanoid:LoadAnimation( Upvalue3 )
        assert( Upvalue2, "" )
        Upvalue2.Priority = Enum.AnimationPriority.Action
        Upvalue2.Looped = false
        Captured = Upvalue2
    end

    Captured:Play( )
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= nil and Upvalue1.IsPlaying then
    Upvalue1:Stop( )
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Texture
local Value1, Value2, Value3 = Upvalue5( )
Upvalue2 = Value1
Upvalue3 = Value2
Upvalue4 = Value3
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Vector2.new( Radius, Radius )
local Value1, Value2, Value3 = Upvalue5( )
Upvalue2 = Value1
Upvalue3 = Value2
Upvalue4 = Value3
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.X
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Texture
local Value1, Value2, Value3 = Upvalue5( )
Upvalue2 = Value1
Upvalue3 = Value2
Upvalue4 = Value3
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Top
local Value1, Value2, Value3 = Upvalue5( )
Upvalue2 = Value1
Upvalue3 = Value2
Upvalue4 = Value3
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1
]]
