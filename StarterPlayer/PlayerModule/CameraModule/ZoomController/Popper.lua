-- StarterPlayer.PlayerModule.CameraModule.ZoomController.Popper
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local New
local Players = game:GetService( "Players" )
local CommonUtils = require( script.Parent.Parent.Parent:WaitForChild( "CommonUtils" ) )
local Get = CommonUtils.get( "FlagUtil" )
local Get2 = CommonUtils.get( "CameraWrapper" )
local Get3 = CommonUtils.get( "ConnectionUtil" )
local UserFlag = Get.getUserFlag( "UserRaycastUpdateAPI2" )
local UserFlag2 = Get.getUserFlag( "UserCurrentCameraUpdate2" )
local UserFlag3 = Get.getUserFlag( "UserPlayerConnectionMemoryLeak" )

if UserFlag2 then
    New = Get2.new( )
else
    New = nil
end

local CurrentCamera = if UserFlag2 then nil else game.Workspace.CurrentCamera

if UserFlag2 then
    New:Enable( )
end

local New2
local Min = math.min
local Tan = math.tan
local Rad = math.rad
local Ray2 = Ray.new
local RaycastParams2 = RaycastParams.new( )
RaycastParams2.IgnoreWater = true
RaycastParams2.FilterType = Enum.RaycastFilterType.Exclude
RaycastParams2.RespectCanCollide = true
local RaycastParams3 = RaycastParams.new( )
RaycastParams3.IgnoreWater = true
RaycastParams3.FilterType = Enum.RaycastFilterType.Include

if UserFlag3 then
    New2 = Get3.new( )
else
    New2 = nil
end

local NearPlaneZ, NearPlaneZ2, Tan3

local function GetTotalTransparency( Argument1 )
    return 1 - ( 1 - Argument1.Transparency ) * ( 1 - Argument1.LocalTransparencyModifier )
end

local function EraseFromEnd( List, Amount )
    local Count = #List
    local Total = Amount + 1
    local I = Count

    for I = Count, Total, -1 do
        List[ I ] = nil
    end
end

local X = nil
local Tan2 = nil

if UserFlag2 then
    local function UpdateProjection()
        local GetCamera = New:getCamera( )
        local Rad2 = Rad( GetCamera.FieldOfView )
        local ViewportSize = GetCamera.ViewportSize
        local XInner = ViewportSize.X / ViewportSize.Y
        Tan2 = Tan( Rad2 / 2 ) * 2
        X = XInner * Tan2
    end

    New:Connect( "FieldOfView", UpdateProjection )
    New:Connect( "ViewportSize", UpdateProjection )
    local GetCamera = New:getCamera( )
    local Rad2 = Rad( GetCamera.FieldOfView )
    local ViewportSize = GetCamera.ViewportSize
    local X2 = ViewportSize.X / ViewportSize.Y
    Tan2 = Tan( Rad2 / 2 ) * 2
    X = X2 * Tan2
    NearPlaneZ = New:getCamera( ).NearPlaneZ
    New:Connect( "NearPlaneZ", function()
        NearPlaneZ = New:getCamera( ).NearPlaneZ
    end )
    NearPlaneZ2 = NearPlaneZ
    Tan3 = Tan2
else
    local function UpdateProjection2()
        local Rad2 = Rad( CurrentCamera.FieldOfView )
        local ViewportSize = CurrentCamera.ViewportSize
        local XInner = ViewportSize.X / ViewportSize.Y
        Tan2 = Tan( Rad2 / 2 ) * 2
        X = XInner * Tan2
    end

    CurrentCamera:GetPropertyChangedSignal( "FieldOfView" ):Connect( UpdateProjection2 )
    CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( UpdateProjection2 )
    local Rad3 = Rad( CurrentCamera.FieldOfView )
    local ViewportSize2 = CurrentCamera.ViewportSize
    local X3 = ViewportSize2.X / ViewportSize2.Y
    Tan2 = Tan( Rad3 / 2 ) * 2
    X = X3 * Tan2
    NearPlaneZ = CurrentCamera.NearPlaneZ
    CurrentCamera:GetPropertyChangedSignal( "NearPlaneZ" ):Connect( function()
        NearPlaneZ = CurrentCamera.NearPlaneZ
    end )
    NearPlaneZ2 = NearPlaneZ
    Tan3 = Tan2
end

local Table = { }
local Table2 = { }

local function RefreshIgnoreList()
    local Number
    Table = { }
    Number = 1

    for Key, Value in pairs( Table2 ) do
        Table[ Number ] = Value
        Number = Number + 1
    end
end

local function PlayerAdded( Player )
    local function CharacterAdded( Argument1 )
        local Number
        Table2[ Player ] = Argument1
        Table = { }
        Number = 1

        for Key, Value in pairs( Table2 ) do
            Table[ Number ] = Value
            Number = Number + 1
        end
    end

    local function CharacterRemoving()
        local Number
        Table2[ Player ] = nil
        Table = { }
        Number = 1

        for Key, Value in pairs( Table2 ) do
            Table[ Number ] = Value
            Number = Number + 1
        end
    end

    if UserFlag3 then
        New2:trackConnection( ( "%*CharacterAdded" ):format( Player.UserId ), Player.CharacterAdded:Connect( CharacterAdded ) )
        New2:trackConnection( ( "%*CharacterRemoving" ):format( Player.UserId ), Player.CharacterRemoving:Connect( CharacterRemoving ) )
    else
        Player.CharacterAdded:Connect( CharacterAdded )
        Player.CharacterRemoving:Connect( CharacterRemoving )
    end
    if Player.Character then
        local Number
        Table2[ Player ] = Player.Character
        Table = { }
        Number = 1

        for Key, Value in pairs( Table2 ) do
            Table[ Number ] = Value
            Number = Number + 1
        end
    end
end

local function PlayerRemoving( Player )
    local Number
    Table2[ Player ] = nil
    Table = { }
    Number = 1

    for Key, Value in pairs( Table2 ) do
        Table[ Number ] = Value
        Number = Number + 1
    end
    if UserFlag3 then
        New2:disconnect( ( ( "%*CharacterAdded" ):format( Player.UserId ) ) )
        New2:disconnect( ( ( "%*CharacterRemoving" ):format( Player.UserId ) ) )
    end
end

Players.PlayerAdded:Connect( PlayerAdded )
Players.PlayerRemoving:Connect( PlayerRemoving )

for Index, Value in ipairs( Players:GetPlayers( ) ) do
    PlayerAdded( Value )
end

local Number
Table = { }
Number = 1

for Key, Value3 in pairs( Table2 ) do
    Table[ Number ] = Value3
    Number = Number + 1
end

local Value4 = nil
local Value5 = nil

if UserFlag2 then
    New:Connect( "CameraSubject", function()
        local CameraSubject = New:getCamera( ).CameraSubject

        if CameraSubject and CameraSubject:IsA( "Humanoid" ) then
            Value5 = CameraSubject.RootPart
            return
        end
        if not CameraSubject or not CameraSubject:IsA( "BasePart" ) then
            Value5 = nil
            return
        end
        Value5 = CameraSubject
        return
    end )
else
    CurrentCamera:GetPropertyChangedSignal( "CameraSubject" ):Connect( function()
        local CameraSubject = CurrentCamera.CameraSubject

        if CameraSubject:IsA( "Humanoid" ) then
            Value5 = CameraSubject.RootPart
            return
        end
        if CameraSubject:IsA( "BasePart" ) then
            Value5 = CameraSubject
            return
        end
        Value5 = nil
        return
    end )
end

local function CanOcclude( Part )
    local Flag

    if 1 - ( 1 - Part.Transparency ) * ( 1 - Part.LocalTransparencyModifier ) < 0.25 then
        if UserFlag or Part.CanCollide then
            if Value4 == ( Part:GetRootPart( ) or Part ) then
                Flag = false
            else
                Flag = not Part:IsA( "TrussPart" )
            end
        else
            Flag = Part.CanCollide
        end
    else
        Flag = false
    end

    return Flag
end

local Table3 = {
    Vector2.new( 0.4, 0 ),
    Vector2.new( -0.4, 0 ),
    Vector2.new( 0, -0.4 ),
    Vector2.new( 0, 0.4 ),
    Vector2.new( 0, 0.2 )
}

local function GetCollisionPoint( Position, Argument2 )
    local Value1, Value2

    if UserFlag then
        RaycastParams2.FilterDescendantsInstances = Table
        local Raycast = workspace:Raycast( Position, Argument2, RaycastParams2 )

        if Raycast then
            return Raycast.Position, true
        end
        Value1 = Position
        Value2 = Argument2
    else
        local Count = #Table

        while true do
            local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2 = workspace:FindPartOnRayWithIgnoreList( Ray2( Position, Argument2 ), Table, false, true )

            if FoundPartOnRayWithIgnoreList then
                if FoundPartOnRayWithIgnoreList.CanCollide then
                    local Count2 = #Table
                    local Count3 = Count + 1
                    local I = Count2

                    for I = Count2, Count3, -1 do
                        Table[ I ] = nil
                    end

                    return FoundPartOnRayWithIgnoreList2, true
                end
                Table[ #Table + 1 ] = FoundPartOnRayWithIgnoreList
            end
            if not FoundPartOnRayWithIgnoreList then
                break
            end
        end

        local Count4 = #Table
        local Count5 = Count + 1
        local I2 = Count4
        Value1 = Position
        Value2 = Argument2

        for I2 = Count4, Count5, -1 do
            Table[ I2 ] = nil
            Value1 = Position
            Value2 = Argument2
        end
    end

    return Value1 + Value2, false
end

local function QueryPoint( Argument1, Amount, Argument3, Argument4 )
    local Magnitude, Number3, Total, Number4
    debug.profilebegin( "queryPoint" )
    local Count = #Table
    local Captured = Argument3 + NearPlaneZ2
    local Captured2 = Argument1 + Amount * Captured

    if UserFlag then
        local Position, Number
        RaycastParams2.FilterDescendantsInstances = Table
        Position = Argument1
        Number = 0
        Number3 = math.huge
        Magnitude = math.huge

        while true do
            local Raycast = workspace:Raycast( Position, Captured2 - Position, RaycastParams2 )

            if not Raycast then
                break
            end

            local Number2 = Number + 1
            local Instance = Raycast.Instance
            local Position2 = Raycast.Position
            Magnitude = ( Position2 - Argument1 ).Magnitude

            if not ( Number2 >= 64 ) then
                local Flag

                if 1 - ( 1 - Instance.Transparency ) * ( 1 - Instance.LocalTransparencyModifier ) < 0.25 then
                    if UserFlag or Instance.CanCollide then
                        if Value4 == ( Instance:GetRootPart( ) or Instance ) then
                            Flag = false
                        else
                            Flag = not Instance:IsA( "TrussPart" )
                        end
                    else
                        Flag = Instance.CanCollide
                    end
                else
                    Flag = false
                end
                if Flag then
                    RaycastParams3.FilterDescendantsInstances = { Instance }

                    if workspace:Raycast( Captured2, Position2 - Captured2, RaycastParams3 ) then
                        local Raycast3

                        if Argument4 then
                            local Raycast2 = workspace:Raycast( Argument4, Captured2 - Argument4, RaycastParams3 )

                            if Raycast2 then
                                Raycast3 = Raycast2
                            else
                                Raycast3 = workspace:Raycast( Captured2, Argument4 - Captured2, RaycastParams3 )
                            end
                        else
                            Raycast3 = false
                        end
                        if not Raycast3 then
                            if Captured < Number3 then
                                Number3 = Magnitude
                            end
                        end
                    end
                end
            end

            RaycastParams2:AddToFilter( Instance )
            Position = Position2 - Amount * 0.001

            if Magnitude < math.huge or not Instance then
                break
            end

            Number = Number2
        end
    else
        Total = Argument1
        Number4 = 0
        Number3 = math.huge
        Magnitude = math.huge

        while true do
            local FoundPartOnRayWithIgnoreList, FoundPartOnRayWithIgnoreList2 = workspace:FindPartOnRayWithIgnoreList( Ray2( Total, Captured2 - Total ), Table, false, true )
            local Number5 = Number4 + 1

            if FoundPartOnRayWithIgnoreList then
                local Flag3 = Number5 >= 64 and true or false
                local Flag2

                if 1 - ( 1 - FoundPartOnRayWithIgnoreList.Transparency ) * ( 1 - FoundPartOnRayWithIgnoreList.LocalTransparencyModifier ) < 0.25 then
                    if UserFlag or FoundPartOnRayWithIgnoreList.CanCollide then
                        if Value4 == ( FoundPartOnRayWithIgnoreList:GetRootPart( ) or FoundPartOnRayWithIgnoreList ) then
                            Flag2 = false
                        else
                            Flag2 = not FoundPartOnRayWithIgnoreList:IsA( "TrussPart" )
                        end
                    else
                        Flag2 = FoundPartOnRayWithIgnoreList.CanCollide
                    end
                else
                    Flag2 = false
                end
                if Flag2 or Flag3 then
                    local TableInner = { FoundPartOnRayWithIgnoreList }
                    local FoundPartOnRayWithWhitelist = workspace:FindPartOnRayWithWhitelist( Ray2( Captured2, FoundPartOnRayWithIgnoreList2 - Captured2 ), TableInner, true )
                    Magnitude = ( FoundPartOnRayWithIgnoreList2 - Argument1 ).Magnitude

                    if not FoundPartOnRayWithWhitelist or Flag3 then
                    else
                        local Flag4

                        if Argument4 then
                            local FoundPartOnRayWithWhitelist3
                            local FoundPartOnRayWithWhitelist2 = workspace:FindPartOnRayWithWhitelist( Ray2( Argument4, Captured2 - Argument4 ), TableInner, true )
                            FoundPartOnRayWithWhitelist3 = if FoundPartOnRayWithWhitelist2 then FoundPartOnRayWithWhitelist2 else workspace:FindPartOnRayWithWhitelist( Ray2( Captured2, Argument4 - Captured2 ), TableInner, true )
                            Flag4 = FoundPartOnRayWithWhitelist3
                        else
                            Flag4 = false
                        end
                        if not Flag4 then
                            if Captured < Number3 then
                                Number3 = Magnitude
                            end
                        end
                    end
                end

                Table[ #Table + 1 ] = FoundPartOnRayWithIgnoreList
                Total = FoundPartOnRayWithIgnoreList2 - Amount * 0.001
            end
            if Magnitude < math.huge or not FoundPartOnRayWithIgnoreList then
                break
            end

            Number4 = Number5
        end

        local Count2 = #Table
        local Count3 = Count + 1
        local I = Count2

        for I = Count2, Count3, -1 do
            Table[ I ] = nil
        end
    end

    debug.profileend( )
    return Number3 - NearPlaneZ2, Magnitude - NearPlaneZ2
end

local function QueryViewport( Argument1, Argument2 )
    local GetCamera
    debug.profilebegin( "queryViewport" )
    local Position = Argument1.Position
    local RightVector = Argument1.rightVector
    local UpVector = Argument1.upVector
    local Amount = -Argument1.lookVector

    if UserFlag2 then
        GetCamera = New:getCamera( )
    else
        GetCamera = CurrentCamera
    end

    local Number, Number2
    CurrentCamera = GetCamera
    local ViewportSize = CurrentCamera.ViewportSize
    local I = 0
    Number = math.huge
    Number2 = math.huge

    for I = 0, 1 do
        local RightVector2 = RightVector * ( ( I - 0.5 ) * X )
        local J = 0

        for J = 0, 1 do
            local Position2 = Position + NearPlaneZ2 * ( RightVector2 + UpVector * ( ( J - 0.5 ) * Tan3 ) )
            local Value1, Value2 = QueryPoint( Position2, Amount, Argument2, CurrentCamera:ViewportPointToRay( ViewportSize.x * I, ViewportSize.y * J ).Origin )

            if Value2 < Number then
                Number = Value2
            end
            if Value1 < Number2 then
                Number2 = Value1
            end
        end
    end

    debug.profileend( )
    return Number2, Number
end

local function TestPromotion( Argument1, Argument2, Argument3 )
    debug.profilebegin( "testPromotion" )
    local Position = Argument1.Position
    local RightVector = Argument1.rightVector
    local UpVector = Argument1.upVector
    local Amount = -Argument1.lookVector
    debug.profilebegin( "extrapolate" )
    local Magnitude = ( GetCollisionPoint( Position, Argument3.posVelocity * 1.25 ) - Position ).Magnitude
    local Magnitude2 = Argument3.posVelocity.magnitude
    local Min2 = Min( 1.25, Argument3.rotVelocity.magnitude + Magnitude / Magnitude2 )
    local I = 0

    for I = 0, Min2, 0.0625 do
        local Extrapolate = Argument3.extrapolate( I )
        local Position2 = Extrapolate.Position

        if Argument2 <= QueryPoint( Position2, -Extrapolate.lookVector, Argument2 ) then
            return false
        end
    end

    debug.profileend( )
    debug.profilebegin( "testOffsets" )

    for Index, Value in ipairs( Table3 ) do
        local CollisionPoint = GetCollisionPoint( Position, RightVector * Value.x + UpVector * Value.y )

        if QueryPoint( CollisionPoint, ( Position + Amount * Argument2 - CollisionPoint ).Unit, Argument2 ) == math.huge then
            return false
        end
    end

    debug.profileend( )
    debug.profileend( )
    return true
end

local function Popper( Argument1, Argument2, Argument3 )
    local RootPart2
    debug.profilebegin( "popper" )

    if Value5 then
        local RootPart = Value5:GetRootPart( )

        if RootPart then
            RootPart2 = RootPart
        else
            RootPart2 = Value5
        end
    else
        RootPart2 = Value5
    end

    local Value3
    Value4 = RootPart2
    local Value1, Value2 = QueryViewport( Argument1, Argument2 )

    if Value2 < Argument2 then
        Value3 = Value2
    else
        Value3 = Argument2
    end
    if Value1 < Value3 and TestPromotion( Argument1, Argument2, Argument3 ) then
        Value3 = Value1
    end

    Value4 = nil
    debug.profileend( )
    return Value3
end

return Popper
