-- ReplicatedStorage.TopbarPlus.Icon.Elements.Container
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Flag = false
local Number = 0

local function Callback( Argument1 )
    local GuiService = game:GetService( "GuiService" )
    local Players = game:GetService( "Players" )
    local UserInputService = game:GetService( "UserInputService" )
    local Table = { }
    local New = require( script.Parent.Parent.Packages.GoodSignal ).new( )
    local GuiInset = GuiService:GetGuiInset( )
    local NumberInner = 0
    local Number2 = 0
    local Number3 = 0
    local Number4 = 0
    local FlagInner = false
    local Flag2 = false

    local function CheckInset( InsetName )
        local IsOldTopbar
        local Height = GuiService.TopbarInset.Height
        IsOldTopbar = Height <= 36 and true or false
        FlagInner = GuiService:IsTenFootInterface( )
        Flag2 = UserInputService.VREnabled
        Argument1.isOldTopbar = IsOldTopbar
        Number4 = Number4 + 1

        if Height ~= 0 or InsetName ~= nil then
            if Number4 == 1 then
                task.delay( 5, function()
                    Players.LocalPlayer:WaitForChild( "PlayerGui" )

                    if Number4 == 1 then
                        CheckInset( )
                    end
                end )
            end
        else
            task.defer( function()
                task.wait( 8 )
                CheckInset( "ForceConvertToOld" )
            end )
        end
        if Argument1.isOldTopbar and not FlagInner and not Flag2 and Flag == false then
            if Height ~= 0 or InsetName == "ForceConvertToOld" then
                Flag = true
                task.defer( function()
                    local Classic = require( script.Parent.Parent.Features.Themes.Classic )
                    Argument1.modifyBaseTheme( Classic )

                    local function DecideToHideTopbar()
                        if GuiService.MenuIsOpen then
                            Argument1.setTopbarEnabled( false, true )
                            return
                        end
                        Argument1.setTopbarEnabled( )
                        return
                    end

                    GuiService:GetPropertyChangedSignal( "MenuIsOpen" ):Connect( DecideToHideTopbar )

                    if GuiService.MenuIsOpen then
                        Argument1.setTopbarEnabled( false, true )
                        return
                    end
                    Argument1.setTopbarEnabled( )
                    return
                end )
            end
        end

        local NumberInner2
        GuiInset = GuiService:GetGuiInset( )
        NumberInner2 = if IsOldTopbar then 12 else GuiInset.Y - 50
        local Number2Inner
        NumberInner = NumberInner2
        Number2Inner = not IsOldTopbar and 0 or 2
        Number2 = Number2Inner
        Number3 = -2

        if FlagInner then
            NumberInner = 10
            Number2 = 0
        end
        if GuiService.TopbarInset.Height == 0 and not Flag then
            Number2 = Number2 + 13
            Number3 = 50
        end

        New:Fire( GuiInset )
        local Y = GuiInset.Y

        if Y ~= Number then
            Number = Y
            task.defer( function()
                Argument1.insetHeightChanged:Fire( Y )
            end )
        end
    end

    GuiService:GetPropertyChangedSignal( "TopbarInset" ):Connect( CheckInset )
    CheckInset( "FirstTime" )
    local Parent = Instance.new( "ScreenGui" )
    New:Connect( function()
        Parent:SetAttribute( "StartInset", NumberInner )
    end )
    Parent.Name = "TopbarStandard"
    Parent.Enabled = true
    Parent.DisplayOrder = Argument1.baseDisplayOrder
    Parent.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Parent.IgnoreGuiInset = true
    Parent.ResetOnSpawn = false
    Parent.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    Table[ Parent.Name ] = Parent
    Argument1.baseDisplayOrderChanged:Connect( function()
        Parent.DisplayOrder = Argument1.baseDisplayOrder
    end )
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "Holders"
    Parent2.BackgroundTransparency = 1
    New:Connect( function()
        local Number = not Flag2 and 56 or 36
        local Size

        if FlagInner then
            Size = UDim2.new( 1, 0, 0, Number )
        else
            Size = UDim2.new( 1, 0, 1, Number3 )
        end

        Parent2.Position = UDim2.new( 0, 0, 0, Number2 )
        Parent2.Size = Size
    end )
    Parent2.Visible = true
    Parent2.ZIndex = 1
    Parent2.Parent = Parent
    local Clone = Parent:Clone( )
    local Parent3 = Clone.Holders

    local function UpdateCenteredHoldersHeight()
        Parent3.Size = UDim2.new( 1, 0, 0, GuiService.TopbarInset.Height + Number3 )
    end

    Clone.Name = "TopbarCentered"
    Clone.DisplayOrder = Argument1.baseDisplayOrder
    Clone.ScreenInsets = Enum.ScreenInsets.None
    Argument1.baseDisplayOrderChanged:Connect( function()
        Clone.DisplayOrder = Argument1.baseDisplayOrder
    end )
    Table[ Clone.Name ] = Clone
    New:Connect( UpdateCenteredHoldersHeight )
    Parent3.Size = UDim2.new( 1, 0, 0, GuiService.TopbarInset.Height + Number3 )
    local Clone2 = Parent:Clone( )
    Clone2.Name = Clone2.Name .. "Clipped"
    Clone2.DisplayOrder = Argument1.baseDisplayOrder + 1
    Argument1.baseDisplayOrderChanged:Connect( function()
        Clone2.DisplayOrder = Argument1.baseDisplayOrder + 1
    end )
    Table[ Clone2.Name ] = Clone2
    local Clone3 = Clone:Clone( )
    Clone3.Name = Clone3.Name .. "Clipped"
    Clone3.DisplayOrder = Argument1.baseDisplayOrder + 1
    Argument1.baseDisplayOrderChanged:Connect( function()
        Clone3.DisplayOrder = Argument1.baseDisplayOrder + 1
    end )
    Table[ Clone3.Name ] = Clone3
    local Parent4 = Instance.new( "ScrollingFrame" )
    Parent4:SetAttribute( "IsAHolder", true )
    Parent4.Name = "Left"
    New:Connect( function()
        Parent4.Position = UDim2.fromOffset( NumberInner, 0 )
    end )
    Parent4.Size = UDim2.new( 1, -24, 1, 0 )
    Parent4.BackgroundTransparency = 1
    Parent4.Visible = true
    Parent4.ZIndex = 1
    Parent4.Active = false
    Parent4.ClipsDescendants = true
    Parent4.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    Parent4.CanvasSize = UDim2.new( 0, 0, 1, -1 )
    Parent4.AutomaticCanvasSize = Enum.AutomaticSize.X
    Parent4.ScrollingDirection = Enum.ScrollingDirection.X
    Parent4.ScrollBarThickness = 0
    Parent4.BorderSizePixel = 0
    Parent4.Selectable = false
    Parent4.ScrollingEnabled = false
    Parent4.ElasticBehavior = Enum.ElasticBehavior.Never
    Parent4.Parent = Parent2
    local UIListLayout = Instance.new( "UIListLayout" )
    New:Connect( function()
        UIListLayout.Padding = UDim.new( 0, NumberInner )
    end )
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = Parent4
    local Clone4 = Parent4:Clone( )
    New:Connect( function()
        local UIListLayout = Clone4.UIListLayout
        UIListLayout.Padding = UDim.new( 0, NumberInner )
    end )
    Clone4.ScrollingEnabled = false
    Clone4.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Clone4.Name = "Center"
    Clone4.Parent = Parent3
    local Clone5 = Parent4:Clone( )
    New:Connect( function()
        local UIListLayout = Clone5.UIListLayout
        UIListLayout.Padding = UDim.new( 0, NumberInner )
    end )
    Clone5.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    Clone5.Name = "Right"
    Clone5.AnchorPoint = Vector2.new( 1, 0 )
    Clone5.Position = UDim2.new( 1, -12, 0, 0 )
    Clone5.Parent = Parent2
    New:Fire( GuiInset )
    return Table
end

return Callback
