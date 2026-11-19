-- ReplicatedStorage.TopbarPlus.Icon.Elements.Selection
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Argument1 )
    local Parent = Instance.new( "Frame" )
    Parent.Name = "SelectionContainer"
    Parent.Visible = false
    local Parent2 = Instance.new( "Frame" )
    Parent2.Name = "Selection"
    Parent2.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Parent2.BackgroundTransparency = 1
    Parent2.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent2.BorderSizePixel = 0
    Parent2.Parent = Parent
    local Parent3 = Instance.new( "UIStroke" )
    Parent3.Name = "UIStroke"
    Parent3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Parent3.Color = Color3.fromRGB( 255, 255, 255 )
    Parent3.Thickness = 3
    Parent3.Parent = Parent2
    local UIGradient = Instance.new( "UIGradient" )
    UIGradient.Name = "SelectionGradient"
    UIGradient.Parent = Parent3
    local UICorner = Instance.new( "UICorner" )
    UICorner:SetAttribute( "Collective", "IconCorners" )
    UICorner.Name = "UICorner"
    UICorner.CornerRadius = UDim.new( 1, 0 )
    UICorner.Parent = Parent2
    local RunService = game:GetService( "RunService" )
    local GuiService = game:GetService( "GuiService" )
    local Number = 1
    Parent2:GetAttributeChangedSignal( "RotationSpeed" ):Connect( function()
        Number = Parent2:GetAttribute( "RotationSpeed" )
    end )
    RunService.Heartbeat:Connect( function()
        if GuiService.SelectedObject then
            UIGradient.Rotation = os.clock( ) * Number * 100 % 360
            return
        end
        return
    end )
    return Parent
end
