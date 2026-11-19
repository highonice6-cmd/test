-- ReplicatedStorage.ScaleUI
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { REF = Vector2.new( 1920, 1080 ), INSET = 58 }

local function RootRef( Object )
    local LayerCollector

    if not Object:IsA( "LayerCollector" ) or not Object then
        LayerCollector = Object:FindFirstAncestorWhichIsA( "LayerCollector" )
    else
        LayerCollector = Object
    end
    if not LayerCollector or not LayerCollector:IsA( "ScreenGui" ) or LayerCollector.IgnoreGuiInset then
        return Table.REF
    end
    return Vector2.new( Table.REF.X, Table.REF.Y - Table.INSET )
end

function Table.Px( Amount, Amount2 )
    return UDim2.fromScale( ( Amount or 0 ) / Table.REF.X, ( Amount2 or 0 ) / Table.REF.Y )
end
function Table.FromPx( Argument1, Argument2, Argument3 )
    return UDim2.fromScale( Argument1 / math.max( Argument3.X, 1 ), Argument2 / math.max( Argument3.Y, 1 ) )
end
function Table.FromAbs( Argument1, Argument2, Argument3 )
    local AbsoluteSize
    local Parent = Argument1.Parent
    local FromPx = Table.FromPx
    AbsoluteSize = Parent and Parent:IsA( "GuiBase2d" ) and Parent.AbsoluteSize or Vector2.one
    return FromPx( Argument2, Argument3, AbsoluteSize )
end

local function HasOffset( Argument1 )
    local Flag

    if Argument1.X.Offset == 0 then
        if Argument1.Y.Offset == 0 then
            Flag = false
        else
            Flag = true
        end
    else
        Flag = true
    end

    return Flag
end

local Class = setmetatable( { }, { __mode = "k" } )

local function CapScale()
    local Y2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Y = CurrentCamera.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 0
        end
    else
        Y2 = 0
    end
    if Y2 < 200 then
        return 1
    end
    return Y2 / Table.REF.Y
end

local function ApplyCap( Argument1, List )
    local Y2
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Y = CurrentCamera.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 0
        end
    else
        Y2 = 0
    end

    local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
    Argument1.MaxTextSize = math.clamp( math.round( List[ 1 ] * Number ), 1, 100 )
    local Round = math.round( List[ 2 ] * Number )
    Argument1.MinTextSize = math.clamp( Round, 1, Argument1.MaxTextSize )
end

local function WatchCap( CapName )
    if Class[ CapName ] then
        return
    end

    local Y2
    Class[ CapName ] = { CapName.MaxTextSize, CapName.MinTextSize }
    local Entry = Class[ CapName ]
    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        local Y = CurrentCamera.ViewportSize.Y

        if Y then
            Y2 = Y
        else
            Y2 = 0
        end
    else
        Y2 = 0
    end

    local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
    CapName.MaxTextSize = math.clamp( math.round( Entry[ 1 ] * Number ), 1, 100 )
    local Round = math.round( Entry[ 2 ] * Number )
    CapName.MinTextSize = math.clamp( Round, 1, CapName.MaxTextSize )
end

local function RefreshAll()
    local Value1 = nil

    for Key, Value in Class, nil, nil do
        if Key.Parent then
            local Y2
            local CurrentCamera = workspace.CurrentCamera

            if CurrentCamera then
                local Y = CurrentCamera.ViewportSize.Y

                if Y then
                    Y2 = Y
                else
                    Y2 = 0
                end
            else
                Y2 = 0
            end

            local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
            Key.MaxTextSize = math.clamp( math.round( Value[ 1 ] * Number ), 1, 100 )
            local Round = math.round( Value[ 2 ] * Number )
            Key.MinTextSize = math.clamp( Round, 1, Key.MaxTextSize )
        end
    end
end

local Flag = false
local Value1 = nil

local function HookCam()
    if Value1 then
        Value1:Disconnect( )
        Value1 = nil
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Value1 = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( RefreshAll )
    end

    local Value1Inner = nil

    for Key, Value in Class, nil, nil do
        if Key.Parent then
            local Y2
            local CurrentCamera2 = workspace.CurrentCamera

            if CurrentCamera2 then
                local Y = CurrentCamera2.ViewportSize.Y

                if Y then
                    Y2 = Y
                else
                    Y2 = 0
                end
            else
                Y2 = 0
            end

            local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
            Key.MaxTextSize = math.clamp( math.round( Value[ 1 ] * Number ), 1, 100 )
            local Round = math.round( Value[ 2 ] * Number )
            Key.MinTextSize = math.clamp( Round, 1, Key.MaxTextSize )
        end
    end
end

local function HookViewport()
    if Flag or not game:GetService( "RunService" ):IsClient( ) then
        return
    end

    Flag = true
    workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( HookCam )

    if Value1 then
        Value1:Disconnect( )
        Value1 = nil
    end

    local CurrentCamera = workspace.CurrentCamera

    if CurrentCamera then
        Value1 = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( RefreshAll )
    end

    local Value1Inner = nil

    for Key, Value in Class, nil, nil do
        if Key.Parent then
            local Y2
            local CurrentCamera2 = workspace.CurrentCamera

            if CurrentCamera2 then
                local Y = CurrentCamera2.ViewportSize.Y

                if Y then
                    Y2 = Y
                else
                    Y2 = 0
                end
            else
                Y2 = 0
            end

            local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
            Key.MaxTextSize = math.clamp( math.round( Value[ 1 ] * Number ), 1, 100 )
            local Round = math.round( Value[ 2 ] * Number )
            Key.MinTextSize = math.clamp( Round, 1, Key.MaxTextSize )
        end
    end
end

function Table.WatchCaps( Self, Callback )
    local function Consider( Key )
        if Key.Parent and Key:IsA( "UITextSizeConstraint" ) then
            if not Callback or not Callback( Key ) then
                if Class[ Key ] then
                    return
                end

                local Y2
                Class[ Key ] = { Key.MaxTextSize, Key.MinTextSize }
                local Entry = Class[ Key ]
                local CurrentCamera = workspace.CurrentCamera

                if CurrentCamera then
                    local Y = CurrentCamera.ViewportSize.Y

                    if Y then
                        Y2 = Y
                    else
                        Y2 = 0
                    end
                else
                    Y2 = 0
                end

                local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
                Key.MaxTextSize = math.clamp( math.round( Entry[ 1 ] * Number ), 1, 100 )
                local Round = math.round( Entry[ 2 ] * Number )
                Key.MinTextSize = math.clamp( Round, 1, Key.MaxTextSize )
            end
        end
    end

    for Key, Value in Self:GetDescendants( ) do
        if Value.Parent and Value:IsA( "UITextSizeConstraint" ) then
            if not Callback or not Callback( Value ) then
                if not Class[ Value ] then
                    local Y2
                    Class[ Value ] = { Value.MaxTextSize, Value.MinTextSize }
                    local Entry = Class[ Value ]
                    local CurrentCamera = workspace.CurrentCamera

                    if CurrentCamera then
                        local Y = CurrentCamera.ViewportSize.Y

                        if Y then
                            Y2 = Y
                        else
                            Y2 = 0
                        end
                    else
                        Y2 = 0
                    end

                    local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
                    Value.MaxTextSize = math.clamp( math.round( Entry[ 1 ] * Number ), 1, 100 )
                    local Round = math.round( Entry[ 2 ] * Number )
                    Value.MinTextSize = math.clamp( Round, 1, Value.MaxTextSize )
                end
            end
        end
    end

    Self.DescendantAdded:Connect( function( Object )
        if Object:IsA( "UITextSizeConstraint" ) then
            task.defer( Consider, Object )
        end
    end )
    HookViewport( )
end
function Table.Convert( Object, Argument2 )
    local function Walk( Parent, Argument2 )
        if Parent:GetAttribute( "OffsetOK" ) then
            return
        end

        local Vector23

        if Parent:IsA( "GuiObject" ) then
            local Flag
            local Size = Parent.Size
            local Position = Parent.Position
            local Vector22 = Vector2.new( Argument2.X * Size.X.Scale + Size.X.Offset, Argument2.Y * Size.Y.Scale + Size.Y.Offset )

            if Size.X.Offset == 0 then
                if Size.Y.Offset == 0 then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = true
            end
            if Flag and Parent.AutomaticSize ~= Enum.AutomaticSize.None and Parent.AutomaticSize ~= Enum.AutomaticSize.XY then
                if Parent.AutomaticSize ~= Enum.AutomaticSize.Y or Size.X.Offset == 0 then
                    if Parent.AutomaticSize == Enum.AutomaticSize.X and Size.Y.Offset ~= 0 then
                        local Scale2 = Size.X.Scale
                        local Offset = Size.X.Offset
                        Parent.Size = UDim2.new( Scale2, Offset, Size.Y.Scale + Size.Y.Offset / math.max( Argument2.Y, 1 ), 0 )
                    end
                else
                    local Scale = Size.X.Scale + Size.X.Offset / math.max( Argument2.X, 1 )
                    Parent.Size = UDim2.new( Scale, 0, Size.Y.Scale, Size.Y.Offset )
                end
            end

            local Flag2

            if Size.X.Offset == 0 then
                if Size.Y.Offset == 0 then
                    Flag2 = false
                else
                    Flag2 = true
                end
            else
                Flag2 = true
            end
            if Flag2 and Parent.AutomaticSize == Enum.AutomaticSize.None then
                local Flag3

                if Size.X.Scale == 0 then
                    if Size.Y.Scale == 0 then
                        if Size.X.Offset > 0 then
                            if Size.Y.Offset > 0 then
                                Flag3 = true
                            else
                                Flag3 = false
                            end
                        else
                            Flag3 = false
                        end
                    else
                        Flag3 = false
                    end
                else
                    Flag3 = false
                end

                Parent.Size = UDim2.fromScale( Vector22.X / math.max( Argument2.X, 1 ), Vector22.Y / math.max( Argument2.Y, 1 ) )

                if Flag3 and not Parent:GetAttribute( "FreeAspect" ) and not Parent:FindFirstChildOfClass( "UIAspectRatioConstraint" ) then
                    local UIAspectRatioConstraint = Instance.new( "UIAspectRatioConstraint" )
                    UIAspectRatioConstraint.AspectRatio = Vector22.X / Vector22.Y
                    UIAspectRatioConstraint.Parent = Parent
                end
            end

            local Flag4

            if Position.X.Offset == 0 then
                if Position.Y.Offset == 0 then
                    Flag4 = false
                else
                    Flag4 = true
                end
            else
                Flag4 = true
            end
            if Flag4 then
                Parent.Position = UDim2.fromScale( Position.X.Scale + Position.X.Offset / math.max( Argument2.X, 1 ), Position.Y.Scale + Position.Y.Offset / math.max( Argument2.Y, 1 ) )
            end
            if Parent:IsA( "ScrollingFrame" ) then
                local Flag5
                local CanvasSize = Parent.CanvasSize

                if CanvasSize.X.Offset == 0 then
                    if CanvasSize.Y.Offset == 0 then
                        Flag5 = false
                    else
                        Flag5 = true
                    end
                else
                    Flag5 = true
                end
                if Flag5 then
                    local CanvasSize2 = Parent.CanvasSize
                    Parent.CanvasSize = UDim2.fromScale( CanvasSize2.X.Scale + CanvasSize2.X.Offset / math.max( Vector22.X, 1 ), CanvasSize2.Y.Scale + CanvasSize2.Y.Offset / math.max( Vector22.Y, 1 ) )
                end
            end
            if Parent:IsA( "TextLabel" ) or Parent:IsA( "TextButton" ) or Parent:IsA( "TextBox" ) then
                if Parent.TextScaled then
                    Vector23 = Vector22
                else
                    if not Parent:FindFirstChildOfClass( "UITextSizeConstraint" ) then
                        local UITextSizeConstraint = Instance.new( "UITextSizeConstraint" )
                        UITextSizeConstraint.MaxTextSize = math.clamp( Parent.TextSize, 1, 100 )
                        UITextSizeConstraint.Parent = Parent
                    end

                    Parent.TextScaled = true
                    Vector23 = Vector22
                end
            else
                Vector23 = Vector22
            end
        elseif Parent:IsA( "UITextSizeConstraint" ) then
            if Class[ Parent ] then
                Vector23 = Argument2
            else
                local Y2
                Class[ Parent ] = { Parent.MaxTextSize, Parent.MinTextSize }
                local Entry = Class[ Parent ]
                local CurrentCamera = workspace.CurrentCamera

                if CurrentCamera then
                    local Y = CurrentCamera.ViewportSize.Y

                    if Y then
                        Y2 = Y
                    else
                        Y2 = 0
                    end
                else
                    Y2 = 0
                end

                local Number = if Y2 < 200 then 1 else Y2 / Table.REF.Y
                Parent.MaxTextSize = math.clamp( math.round( Entry[ 1 ] * Number ), 1, 100 )
                local Round = math.round( Entry[ 2 ] * Number )
                Parent.MinTextSize = math.clamp( Round, 1, Parent.MaxTextSize )
                Vector23 = Argument2
            end
        elseif Parent:IsA( "UIStroke" ) then
            if Parent.StrokeSizingMode == Enum.StrokeSizingMode.ScaledSize then
                Vector23 = Argument2
            else
                local Thickness = Parent.Thickness
                local X = Argument2.X
                local Thickness2 = Thickness / math.max( math.min( X, Argument2.Y ), 1 )
                Parent.StrokeSizingMode = Enum.StrokeSizingMode.ScaledSize
                Parent.Thickness = Thickness2
                Vector23 = Argument2
            end
        elseif Parent:IsA( "UICorner" ) then
            local CornerRadius = Parent.CornerRadius

            if CornerRadius.Offset == 0 then
                Vector23 = Argument2
            else
                local Scale3 = CornerRadius.Scale
                local Offset2 = CornerRadius.Offset
                local X2 = Argument2.X
                Parent.CornerRadius = UDim.new( Scale3 + Offset2 / math.max( math.min( X2, Argument2.Y ), 1 ), 0 )
                Vector23 = Argument2
            end
        elseif Parent:IsA( "UIPadding" ) then
            local PaddingTop2

            local function Conv( Argument1, Argument2 )
                local UDim3

                if Argument1.Offset == 0 then
                    UDim3 = Argument1
                else
                    local UDim2 = UDim.new( Argument1.Scale + Argument1.Offset / math.max( Argument2, 1 ), 0 )

                    if UDim2 then
                        UDim3 = UDim2
                    else
                        UDim3 = Argument1
                    end
                end

                return UDim3
            end

            local PaddingTop = Parent.PaddingTop
            local Y3 = Argument2.Y

            if PaddingTop.Offset == 0 then
                PaddingTop2 = PaddingTop
            else
                local UDim3 = UDim.new( PaddingTop.Scale + PaddingTop.Offset / math.max( Y3, 1 ), 0 )

                if UDim3 then
                    PaddingTop2 = UDim3
                else
                    PaddingTop2 = PaddingTop
                end
            end

            local PaddingBottom2
            local PaddingBottom = Parent.PaddingBottom
            local Y4 = Argument2.Y

            if PaddingBottom.Offset == 0 then
                PaddingBottom2 = PaddingBottom
            else
                local UDim4 = UDim.new( PaddingBottom.Scale + PaddingBottom.Offset / math.max( Y4, 1 ), 0 )

                if UDim4 then
                    PaddingBottom2 = UDim4
                else
                    PaddingBottom2 = PaddingBottom
                end
            end

            local PaddingLeft2
            Parent.PaddingTop = PaddingTop2
            Parent.PaddingBottom = PaddingBottom2
            local PaddingLeft = Parent.PaddingLeft
            local X3 = Argument2.X

            if PaddingLeft.Offset == 0 then
                PaddingLeft2 = PaddingLeft
            else
                local UDim5 = UDim.new( PaddingLeft.Scale + PaddingLeft.Offset / math.max( X3, 1 ), 0 )

                if UDim5 then
                    PaddingLeft2 = UDim5
                else
                    PaddingLeft2 = PaddingLeft
                end
            end

            local PaddingRight2
            local PaddingRight = Parent.PaddingRight
            local X4 = Argument2.X

            if PaddingRight.Offset == 0 then
                PaddingRight2 = PaddingRight
            else
                local UDim6 = UDim.new( PaddingRight.Scale + PaddingRight.Offset / math.max( X4, 1 ), 0 )

                if UDim6 then
                    PaddingRight2 = UDim6
                else
                    PaddingRight2 = PaddingRight
                end
            end

            Parent.PaddingLeft = PaddingLeft2
            Parent.PaddingRight = PaddingRight2
            Vector23 = Argument2
        elseif Parent:IsA( "UIListLayout" ) then
            local Padding = Parent.Padding

            if Padding.Offset == 0 then
                Vector23 = Argument2
            else
                local Y5 = Parent.FillDirection == Enum.FillDirection.Vertical and Argument2.Y or Argument2.X
                Parent.Padding = UDim.new( Padding.Scale + Padding.Offset / math.max( Y5, 1 ), 0 )
                Vector23 = Argument2
            end
        elseif Parent:IsA( "UIGridLayout" ) then
            local Flag6

            local function Conv2( Argument1 )
                return UDim2.fromScale( Argument1.X.Scale + Argument1.X.Offset / math.max( Argument2.X, 1 ), Argument1.Y.Scale + Argument1.Y.Offset / math.max( Argument2.Y, 1 ) )
            end

            local CellSize = Parent.CellSize

            if CellSize.X.Offset == 0 then
                if CellSize.Y.Offset == 0 then
                    Flag6 = false
                else
                    Flag6 = true
                end
            else
                Flag6 = true
            end
            if Flag6 then
                local CellSize2 = Parent.CellSize
                Parent.CellSize = UDim2.fromScale( CellSize2.X.Scale + CellSize2.X.Offset / math.max( Argument2.X, 1 ), CellSize2.Y.Scale + CellSize2.Y.Offset / math.max( Argument2.Y, 1 ) )
            end

            local Flag7
            local CellPadding = Parent.CellPadding

            if CellPadding.X.Offset == 0 then
                if CellPadding.Y.Offset == 0 then
                    Flag7 = false
                else
                    Flag7 = true
                end
            else
                Flag7 = true
            end
            if Flag7 then
                local CellPadding2 = Parent.CellPadding
                Parent.CellPadding = UDim2.fromScale( CellPadding2.X.Scale + CellPadding2.X.Offset / math.max( Argument2.X, 1 ), CellPadding2.Y.Scale + CellPadding2.Y.Offset / math.max( Argument2.Y, 1 ) )
                Vector23 = Argument2
            else
                Vector23 = Argument2
            end
        else
            Vector23 = Argument2
        end

        local UIPadding
        local IsA = Parent:IsA( "GuiObject" )

        if IsA then
            UIPadding = Parent:FindFirstChildOfClass( "UIPadding" )
        else
            UIPadding = IsA
        end

        local Vector24

        if UIPadding then
            local function Px( Argument1, Argument2 )
                return Argument1.Scale * Argument2 + Argument1.Offset
            end

            local X5 = Vector23.X
            local PaddingLeft3 = UIPadding.PaddingLeft
            local X6 = Vector23.X
            local X7 = X5 - ( PaddingLeft3.Scale * X6 + PaddingLeft3.Offset )
            local PaddingRight3 = UIPadding.PaddingRight
            local X8 = Vector23.X
            local Max = math.max( X7 - ( PaddingRight3.Scale * X8 + PaddingRight3.Offset ), 1 )
            local Y6 = Vector23.Y
            local PaddingTop3 = UIPadding.PaddingTop
            local Y7 = Vector23.Y
            local Y8 = Y6 - ( PaddingTop3.Scale * Y7 + PaddingTop3.Offset )
            local PaddingBottom3 = UIPadding.PaddingBottom
            local Y9 = Vector23.Y
            Vector24 = Vector2.new( Max, ( math.max( Y8 - ( PaddingBottom3.Scale * Y9 + PaddingBottom3.Offset ), 1 ) ) )
        else
            Vector24 = Vector23
        end
        for Key, Value in Parent:GetChildren( ) do
            local Vector25 = if not Value:IsA( "GuiObject" ) or not Vector24 then Vector23 else Vector24
            Walk( Value, Vector25 )
        end
    end

    HookViewport( )
    Walk( Object, Argument2 or RootRef( Object ) )
end
return Table
