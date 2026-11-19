-- Players.perkbrokeyou.PlayerScripts.ScrollCanvasClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local PlayerGui = Players.LocalPlayer:WaitForChild( "PlayerGui" )

local function Ignored( Argument1 )
    local Flag
    local LayerCollector = Argument1:FindFirstAncestorWhichIsA( "LayerCollector" )

    if LayerCollector == nil then
        Flag = true
    elseif LayerCollector.Name:sub( 1, 6 ) == "Topbar" then
        Flag = true
    else
        Flag = false
    end

    return Flag
end

local function Padding( Self, Name )
    local UIPadding = Self:FindFirstChildWhichIsA( "UIPadding" )

    if not UIPadding then
        return 0
    end

    local AbsoluteSize = Self.AbsoluteSize

    if Name == "Y" then
        return UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset + ( UIPadding.PaddingTop.Scale + UIPadding.PaddingBottom.Scale ) * AbsoluteSize.Y
    end
    return UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset + ( UIPadding.PaddingLeft.Scale + UIPadding.PaddingRight.Scale ) * AbsoluteSize.X
end

local Table = { }

local function Track( Value )
    if not Table[ Value ] then
        local Flag
        local LayerCollector = Value:FindFirstAncestorWhichIsA( "LayerCollector" )

        if LayerCollector == nil then
            Flag = true
        elseif LayerCollector.Name:sub( 1, 6 ) == "Topbar" then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            local UIGridStyleLayout = Value:FindFirstChildWhichIsA( "UIGridStyleLayout" )

            if not UIGridStyleLayout then
                return
            end

            Table[ Value ] = true
            local TableInner = { }
            local Flag2 = false
            local Value1 = nil
            local Value2 = nil
            local Value3 = nil

            local function Update()
                local X3, Y3, Max4

                if Flag2 or Value.AutomaticCanvasSize == Enum.AutomaticSize.None then
                    return
                end

                local Parent = Value.Parent

                if not Parent or not Parent:IsA( "GuiBase2d" ) then
                    return
                end

                local AbsoluteSize = Parent.AbsoluteSize

                if AbsoluteSize.X < 1 or AbsoluteSize.Y < 1 then
                    return
                end

                local AbsoluteContentSize = UIGridStyleLayout.AbsoluteContentSize
                local AutomaticCanvasSize = Value.AutomaticCanvasSize

                if AutomaticCanvasSize == Enum.AutomaticSize.X or AutomaticCanvasSize == Enum.AutomaticSize.XY then
                    local Number
                    local X = AbsoluteContentSize.X
                    local UIPadding = Value:FindFirstChildWhichIsA( "UIPadding" )

                    if UIPadding then
                        local AbsoluteSize2 = Value.AbsoluteSize
                        Number = UIPadding.PaddingLeft.Offset + UIPadding.PaddingRight.Offset + ( UIPadding.PaddingLeft.Scale + UIPadding.PaddingRight.Scale ) * AbsoluteSize2.X
                    else
                        Number = 0
                    end

                    local X2 = ( X + Number ) / AbsoluteSize.X

                    if X2 then
                        X3 = X2
                    else
                        X3 = 0
                    end
                else
                    X3 = 0
                end
                if AutomaticCanvasSize == Enum.AutomaticSize.Y or AutomaticCanvasSize == Enum.AutomaticSize.XY then
                    local Number2
                    local Y = AbsoluteContentSize.Y
                    local UIPadding2 = Value:FindFirstChildWhichIsA( "UIPadding" )

                    if UIPadding2 then
                        local AbsoluteSize3 = Value.AbsoluteSize
                        Number2 = UIPadding2.PaddingTop.Offset + UIPadding2.PaddingBottom.Offset + ( UIPadding2.PaddingTop.Scale + UIPadding2.PaddingBottom.Scale ) * AbsoluteSize3.Y
                    else
                        Number2 = 0
                    end

                    local Y2 = ( Y + Number2 ) / AbsoluteSize.Y

                    if Y2 then
                        Y3 = Y2
                    else
                        Y3 = 0
                    end
                else
                    Y3 = 0
                end

                local CanvasSize = Value.CanvasSize

                if math.abs( CanvasSize.X.Scale - X3 ) * AbsoluteSize.X < 1 and math.abs( CanvasSize.Y.Scale - Y3 ) * AbsoluteSize.Y < 1 and CanvasSize.X.Offset == 0 and CanvasSize.Y.Offset == 0 then
                    return
                end

                local X4 = AbsoluteContentSize.X
                local Max = math.max( X4, AbsoluteContentSize.Y )

                if not Value1 or not Value2 or not ( Value1 + 1 < Max ) then
                    Max4 = Max
                else
                    local X5 = Value.AbsoluteCanvasSize.X
                    local Max2 = math.max( X5, Value.AbsoluteCanvasSize.Y )

                    if not ( Value2 + 1 < Max2 ) or not ( math.abs( Max / Value1 - Max2 / Value2 ) < 0.02 ) then
                        Value3 = 0
                        Max4 = Max
                    else
                        Value3 = ( Value3 or 0 ) + 1

                        if Value3 >= 8 then
                            Flag2 = true

                            if RunService:IsStudio( ) then
                                warn( "[ScrollCanvas] arrêté (le contenu grandit avec le canevas) : " .. Value:GetFullName( ) )
                            end

                            return
                        end
                        Max4 = Max
                    end
                end

                Value.CanvasSize = UDim2.fromScale( X3, Y3 )
                local X6 = Value.AbsoluteCanvasSize.X
                local Max3 = math.max( X6, Value.AbsoluteCanvasSize.Y )
                Value1 = Max4
                Value2 = Max3
            end

            table.insert( TableInner, UIGridStyleLayout:GetPropertyChangedSignal( "AbsoluteContentSize" ):Connect( Update ) )
            table.insert( TableInner, Value:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Update ) )
            table.insert( TableInner, Value:GetPropertyChangedSignal( "AutomaticCanvasSize" ):Connect( Update ) )
            local Connect = nil

            local function WatchParent()
                if Connect then
                    Connect:Disconnect( )
                end

                local Parent = Value.Parent

                if Parent and Parent:IsA( "GuiBase2d" ) then
                    Connect = Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Update )
                end
            end

            if Connect then
                Connect:Disconnect( )
            end

            local Parent = Value.Parent

            if Parent and Parent:IsA( "GuiBase2d" ) then
                Connect = Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Update )
            end

            table.insert( TableInner, Value.AncestryChanged:Connect( function()
                if Value:IsDescendantOf( PlayerGui ) then
                    if Connect then
                        Connect:Disconnect( )
                    end

                    local Parent = Value.Parent

                    if Parent and Parent:IsA( "GuiBase2d" ) then
                        Connect = Parent:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( Update )
                    end

                    Update( )
                    return
                end
                local Value1 = nil

                for Key, ValueInner in TableInner, nil, nil do
                    ValueInner:Disconnect( )
                end
                if Connect then
                    Connect:Disconnect( )
                end

                Table[ Value ] = nil
                return
            end ) )
            Update( )
            return
        end
    end
end

for Key, Value in PlayerGui:GetDescendants( ) do
    if Value:IsA( "ScrollingFrame" ) then
        Track( Value )
    end
end

PlayerGui.DescendantAdded:Connect( function( Object )
    if Object:IsA( "ScrollingFrame" ) then
        task.defer( Track, Object )
        return
    end
    if Object:IsA( "UIGridStyleLayout" ) and Object.Parent and Object.Parent:IsA( "ScrollingFrame" ) then
        task.defer( Track, Object.Parent )
    end
end )
