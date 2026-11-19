-- StarterPlayer.StarterPlayerScripts.BestPlayersScroll
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local UserInputService = game:GetService( "UserInputService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LocalPlayer = Players.LocalPlayer
local Success, Result = pcall( function()
    return require( ReplicatedStorage:WaitForChild( "Controls" ) )
end )

if not Success then
    Result = nil
end

local Ranked = workspace:WaitForChild( "Ranked", 60 )

if Ranked then
    local Table = { }

    local function Screens()
        local Table = { }
        local Table2 = { }

        for Key, Value in Ranked:GetChildren( ) do
            if Value:IsA( "Model" ) and Value.Name:sub( 1, 12 ) == "BestPlayers_" then
                local Board
                local Screen = Value:FindFirstChild( "Screen" )

                if Screen then
                    Board = Screen:FindFirstChild( "Board" )
                else
                    Board = Screen
                end
                if Screen and Screen:IsA( "BasePart" ) and Board and Board:IsA( "SurfaceGui" ) then
                    table.insert( Table, Screen )
                    Table2[ Screen ] = Board
                end
            end
        end

        return Table, Table2
    end

    local function VisibleList( Entry )
        local Children
        local Window = Entry:FindFirstChild( "Window" )
        Children = Window and Window:GetChildren( ) or { }
        local Value1 = nil

        for Key, Value in Children, nil, nil do
            if Value:IsA( "GuiObject" ) and Value.Name:sub( 1, 5 ) == "Page_" and Value.Visible and Value:FindFirstChild( "List" ) then
                if Value:FindFirstChild( "List" ):IsA( "ScrollingFrame" ) then
                    return Value:FindFirstChild( "List" )
                end
            end
        end

        return nil
    end

    local function Aimed( Argument1 )
        local FilterDescendantsInstances, Value1 = Screens( )

        if #FilterDescendantsInstances == 0 then
            return nil
        end

        local RaycastParams2 = RaycastParams.new( )
        RaycastParams2.FilterType = Enum.RaycastFilterType.Include
        RaycastParams2.FilterDescendantsInstances = FilterDescendantsInstances
        local Origin = Argument1.Origin
        local Raycast = workspace:Raycast( Origin, Argument1.Direction * 300, RaycastParams2 )

        if not Raycast then
            return nil
        end

        local HumanoidRootPart
        local Character = LocalPlayer.Character

        if Character then
            HumanoidRootPart = LocalPlayer.Character:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Character
        end
        if not HumanoidRootPart or ( Raycast.Position - HumanoidRootPart.Position ).Magnitude > 30 then
            return nil
        end

        local VectorToWorldSpace
        local Entry = Value1[ Raycast.Instance ]

        if Entry then
            VectorToWorldSpace = Raycast.Instance.CFrame:VectorToWorldSpace( Vector3.FromNormalId( Entry.Face ) )
        else
            VectorToWorldSpace = Entry
        end
        if not VectorToWorldSpace or VectorToWorldSpace:Dot( Raycast.Normal ) < 0.9 then
            return nil
        end

        local VisibleList2 = VisibleList( Entry )

        if VisibleList2 then
            return VisibleList2, Entry, Raycast.Position
        end
        return nil
    end

    local function MaxY( Argument1 )
        return ( math.max( Argument1.AbsoluteCanvasSize.Y - Argument1.AbsoluteWindowSize.Y, 0 ) )
    end

    local function RowStep( Self )
        return Self.AbsoluteWindowSize.Y / math.max( Self:GetAttribute( "VisibleRows" ) or 8, 1 )
    end

    UserInputService.InputChanged:Connect( function( Argument1, Argument2 )
        if Argument2 or Argument1.UserInputType ~= Enum.UserInputType.MouseWheel then
            return
        end

        local MouseLocation = UserInputService:GetMouseLocation( )
        local Aimed2 = Aimed( workspace.CurrentCamera:ViewportPointToRay( MouseLocation.X, MouseLocation.Y ) )

        if not Aimed2 then
            return
        end

        local Entry2
        local Entry = Table[ Aimed2 ]
        Entry2 = if Entry then Entry else Aimed2.CanvasPosition.Y
        local Entry3 = Entry2 - Argument1.Position.Z * ( Aimed2.AbsoluteWindowSize.Y / math.max( Aimed2:GetAttribute( "VisibleRows" ) or 8, 1 ) )
        Table[ Aimed2 ] = math.clamp( Entry3, 0, ( math.max( Aimed2.AbsoluteCanvasSize.Y - Aimed2.AbsoluteWindowSize.Y, 0 ) ) )
    end )
    RunService.RenderStepped:Connect( function( Amount )
        local Value1 = nil

        for Key, Value in Table, nil, nil do
            if Key.Parent then
                local Y2
                local Y = Key.CanvasPosition.Y
                Y2 = math.abs( Value - Y ) < 0.5 and Value or Y + ( Value - Y ) * math.min( 1, Amount * 16 )
                Key.CanvasPosition = Vector2.new( 0, Y2 )

                if Y2 == Value then
                    Table[ Key ] = nil
                end
            else
                Table[ Key ] = nil
            end
        end
    end )
    local Table2 = { }

    local function CanvasPerPixel( Argument1, Argument2 )
        local PixelsPerStud
        local Parent = Argument1.Parent
        local CurrentCamera = workspace.CurrentCamera
        local WorldToScreenPoint = CurrentCamera:WorldToScreenPoint( Argument2 )
        local WorldToScreenPoint2 = CurrentCamera:WorldToScreenPoint( Argument2 + Parent.CFrame.UpVector )
        local Max = math.max( ( Vector2.new( WorldToScreenPoint.X, WorldToScreenPoint.Y ) - Vector2.new( WorldToScreenPoint2.X, WorldToScreenPoint2.Y ) ).Magnitude, 1 )
        PixelsPerStud = Argument1.SizingMode == Enum.SurfaceGuiSizingMode.PixelsPerStud and Argument1.PixelsPerStud or Argument1.CanvasSize.Y / Parent.Size.Y
        return PixelsPerStud / Max
    end

    UserInputService.TouchStarted:Connect( function( Key, Argument2 )
        if Argument2 then
            return
        end

        local Position = Key.Position
        local Value1, Value2, Value3 = Aimed( workspace.CurrentCamera:ScreenPointToRay( Position.X, Position.Y ) )

        if not Value1 then
            return
        end
        if Result and Result.ReleaseTouch then
            pcall( Result.ReleaseTouch, Key )
        end

        Table2[ Key ] = {
            list = Value1,
            start = Vector2.new( Position.X, Position.Y ),
            k = CanvasPerPixel( Value2, Value3 ),
            decided = false
        }
    end )
    UserInputService.TouchMoved:Connect( function( Key )
        local Entry = Table2[ Key ]

        if not Entry then
            return
        end

        local Last = Vector2.new( Key.Position.X, Key.Position.Y )

        if not Entry.decided then
            local Vector22 = Last - Entry.start

            if Vector22.Magnitude < 8 then
                return
            end

            Entry.decided = true
            local Abs = math.abs( Vector22.X )

            if math.abs( Vector22.Y ) < Abs then
                Table2[ Key ] = nil

                if Result and Result.LookTouch then
                    pcall( Result.LookTouch, Key )
                end

                return
            end
            Entry.last = Entry.start
        end

        local Y = Entry.list.CanvasPosition.Y - ( Last.Y - Entry.last.Y ) * Entry.k
        local List = Entry.list
        local Clamp = math.clamp( Y, 0, ( math.max( List.AbsoluteCanvasSize.Y - List.AbsoluteWindowSize.Y, 0 ) ) )
        Entry.last = Last
        Table[ Entry.list ] = nil
        local List2 = Entry.list
        List2.CanvasPosition = Vector2.new( 0, Clamp )
    end )
    UserInputService.TouchEnded:Connect( function( Key )
        Table2[ Key ] = nil
    end )
    return
end
return
