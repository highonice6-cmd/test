-- ReplicatedStorage.TopbarPlus.Icon.Elements.Notice
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

return function( Argument1, Argument2 )
    local Parent = Instance.new( "Frame" )
    Parent.Name = "Notice"
    Parent.ZIndex = 25
    Parent.AutomaticSize = Enum.AutomaticSize.X
    Parent.BorderColor3 = Color3.fromRGB( 0, 0, 0 )
    Parent.BorderSizePixel = 0
    Parent.BackgroundTransparency = 0.1
    Parent.BackgroundColor3 = Color3.fromRGB( 255, 255, 255 )
    Parent.Visible = false
    Parent.Parent = Argument1.widget
    local UICorner = Instance.new( "UICorner" )
    UICorner.CornerRadius = UDim.new( 1, 0 )
    UICorner.Parent = Parent
    Instance.new( "UIStroke" ).Parent = Parent
    local TextLabel = Instance.new( "TextLabel" )
    TextLabel.Name = "NoticeLabel"
    TextLabel.ZIndex = 26
    TextLabel.AnchorPoint = Vector2.new( 0.5, 0.5 )
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.new( 1, 0, 1, 0 )
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new( 0.5, 0, 0.515, 0 )
    TextLabel.BackgroundColor3 = Color3.fromRGB( 0, 0, 0 )
    TextLabel.FontSize = Enum.FontSize.Size14
    TextLabel.TextColor3 = Color3.fromRGB( 0, 0, 0 )
    TextLabel.Text = "1"
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.Font = Enum.Font.Arial
    TextLabel.Parent = Parent
    local Parent2 = script.Parent.Parent
    local Packages = Parent2.Packages
    local Janitor = require( Packages.Janitor )
    local GoodSignal = require( Packages.GoodSignal )
    local Utility = require( Parent2.Utility )
    Argument1.noticeChanged:Connect( function( Text )
        if not Text then
            return
        end

        local Flag = Text > 99 and true or false
        local Text2 = if Flag then "99+" else Text
        TextLabel.Text = Text2

        if Flag then
            TextLabel.TextSize = 11
        end

        local Flag3

        if Text < 1 then
            Flag3 = false
        else
            Flag3 = true
        end

        local Flag2
        local IconByUID = Argument2.getIconByUID( Argument1.parentIconUID )

        if #Argument1.dropdownIcons > 0 then
            Flag2 = true
        elseif #Argument1.menuIcons > 0 then
            Flag2 = true
        else
            Flag2 = false
        end
        if not Argument1.isSelected or not Flag2 then
            if IconByUID and not IconByUID.isSelected then
                Flag3 = false
            end
        else
            Flag3 = false
        end

        Utility.setVisible( Parent, Flag3, "NoticeHandler" )
    end )
    Argument1.noticeStarted:Connect( function( Argument1Inner, Key )
        local IconByUID = Argument2.getIconByUID( Argument1.parentIconUID )

        if IconByUID then
            IconByUID:notify( Argument1Inner or Argument1.deselected )
        end

        local UID
        local Add = Argument1.janitor:add( Janitor.new( ) )
        local Add2 = Add:add( GoodSignal.new( ) )
        Add:add( Argument1.endNotices:Connect( function()
            Add2:Fire( )
        end ) )
        Add:add( ( Argument1Inner or Argument1.deselected ):Connect( function()
            Add2:Fire( )
        end ) )

        if Key then
            UID = Key
        else
            UID = Utility.generateUID( )
        end

        Argument1.notices[ UID ] = {
            completeSignal = Add2,
            clearNoticeEvent = Argument1Inner or Argument1.deselected
        }

        local function UpdateNotice()
            Argument1.noticeChanged:Fire( Argument1.totalNotices )
        end

        Argument1.notified:Fire( UID )
        Argument1.totalNotices = Argument1.totalNotices + 1
        Argument1.noticeChanged:Fire( Argument1.totalNotices )
        Add2:Once( function()
            Add:destroy( )
            Argument1.totalNotices = Argument1.totalNotices - 1
            Argument1.notices[ UID ] = nil
            Argument1.noticeChanged:Fire( Argument1.totalNotices )
        end )
    end )
    Parent:SetAttribute( "ClipToJoinedParent", true )
    Argument1:clipOutside( Parent )
    return Parent
end
