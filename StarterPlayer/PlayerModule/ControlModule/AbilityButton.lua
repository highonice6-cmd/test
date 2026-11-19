-- StarterPlayer.PlayerModule.ControlModule.AbilityButton
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local UserFlag = require( script.Parent.Parent:WaitForChild( "CommonUtils" ) ).get( "FlagUtil" ).getUserFlag( "UserAbilitiesUserInterfaceD" )
local Get = require( script.Parent:WaitForChild( "AvatarAbilitiesInterface" ) ).get( Players.LocalPlayer )
return {
    create = function( Argument1, Text, Argument3, Object, Argument5, Argument6, Argument7 )
        local Image
        local Flag = false
        local Flag2 = false
        Image = if Argument3.ButtonAssetId then Argument3.ButtonAssetId else "rbxassetid://136780077406114"
        local Text2 = if Argument3.ButtonPressedAssetId then Argument3.ButtonPressedAssetId else "rbxassetid://76895455502876"
        local ButtonInvalidAssetId = if Argument3.ButtonInvalidAssetId then Argument3.ButtonInvalidAssetId else nil
        local UIButton = Instance.new( "ImageButton" )
        UIButton.Name = Text .. "Button"
        UIButton.Visible = false
        UIButton.BackgroundTransparency = 1
        UIButton.Image = Image
        UIButton.Parent = Argument1.parentUIFrame

        for Key, Value in Object:GetChildren( ) do
            if string.find( Value.Name, "Touch" ) then
                if Value:IsA( "InputBinding" ) then
                    Value.UIButton = UIButton
                    break
                end
            end
        end

        local function ResizeButton()
            local Flag
            local X = Argument1.parentUIFrame.AbsoluteSize.x
            Flag = math.min( X, Argument1.parentUIFrame.AbsoluteSize.y ) <= 500 and true or false
            local Small2

            if Flag then
                local Small = Argument5.small

                if Small then
                    Small2 = Small
                else
                    Small2 = Argument5.large
                end
            else
                Small2 = Argument5.large
            end

            local Item = Small2[ 1 ]
            local Item2 = Small2[ 2 ]
            local Item3 = Small2[ 3 ]
            local Amount = -Item2 - Item
            UIButton.Size = UDim2.new( 0, Item, 0, Item )

            if Argument6 then
                UIButton.Position = UDim2.new( 1, Amount, 0, Item3 )
                return
            end
            UIButton.Position = UDim2.new( 1, Amount, 1, -Item3 - Item )
            return
        end

        ResizeButton( )
        local Table = { }
        table.insert( Table, Argument1.parentUIFrame:GetPropertyChangedSignal( "AbsoluteSize" ):Connect( ResizeButton ) )

        local function UpdateButtonState()
            if UIButton.Parent == nil then
                return
            end
            if UserFlag then
                local AbilityUIState = Get:GetAbilityUIState( Text )
                local FlagInner = AbilityUIState == 0 and true or false
                local Visible
                local Enabled = Argument1.enabled

                if Enabled then
                    local Enabled2 = Object.Enabled

                    if Enabled2 then
                        if Argument7 then
                            Visible = Argument7
                        else
                            Visible = not FlagInner
                        end
                    else
                        Visible = Enabled2
                    end
                else
                    Visible = Enabled
                end

                UIButton.Visible = Visible

                if UIButton.Visible then
                    if AbilityUIState == 1 or FlagInner then
                        if ButtonInvalidAssetId then
                            UIButton.Image = ButtonInvalidAssetId
                            UIButton.ImageTransparency = 0
                            return
                        end
                        UIButton.Image = Image
                        UIButton.ImageTransparency = 0.6
                        return
                    elseif AbilityUIState == 3 or Flag or Flag2 then
                        UIButton.Image = Text2
                        UIButton.ImageTransparency = 0
                        return
                    else
                        UIButton.Image = Image
                        UIButton.ImageTransparency = 0
                        return
                    end
                end
            else
                local AbilityValid = Get:GetAbilityValid( Text )
                local AbilityActive = Get:GetAbilityActive( Text )
                local Visible2
                local Enabled3 = Argument1.enabled
                Visible2 = if Enabled3 then Object.Enabled else Enabled3
                UIButton.Visible = Visible2

                if UIButton.Visible then
                    if AbilityActive then
                        UIButton.Image = Text2
                        UIButton.ImageTransparency = 0
                        return
                    end
                    if ( Flag or Flag2 ) and AbilityValid then
                        UIButton.Image = Text2
                        UIButton.ImageTransparency = 0
                        return
                    end
                    if AbilityValid then
                        UIButton.Image = Image
                        UIButton.ImageTransparency = 0
                        return
                    end
                    if ButtonInvalidAssetId then
                        UIButton.Image = ButtonInvalidAssetId
                        UIButton.ImageTransparency = 0
                        return
                    end

                    UIButton.Image = Image
                    UIButton.ImageTransparency = 0.6
                end
            end
        end

        UpdateButtonState( )

        local function FireSelectionActivation( Argument1 )
            local SelectionActivateBinding2
            local SelectionActivateBinding = Object:FindFirstChild( "SelectionActivateBinding" )

            if SelectionActivateBinding then
                SelectionActivateBinding2 = SelectionActivateBinding
            else
                local InputBinding = Instance.new( "InputBinding" )
                InputBinding.Name = "SelectionActivateBinding"
                InputBinding.Type = Enum.InputBindingType.Scriptable
                InputBinding.Parent = Object
                SelectionActivateBinding2 = InputBinding
            end

            SelectionActivateBinding2:Fire( Argument1 )
        end

        UIButton.MouseButton1Down:Connect( function()
            Flag = true
            UpdateButtonState( )
        end )
        UIButton.MouseButton1Up:Connect( function()
            Flag = false
            UpdateButtonState( )
        end )
        UIButton.MouseLeave:Connect( function()
            Flag = false
            UpdateButtonState( )
        end )

        if UserFlag then
            table.insert( Table, Get:GetAbilityUIStateChangedSignal( Text ):Connect( UpdateButtonState ) )
        else
            table.insert( Table, Get:GetAbilityActiveChangedSignal( Text ):Connect( UpdateButtonState ) )
            table.insert( Table, Get:GetAbilityValidChangedSignal( Text ):Connect( UpdateButtonState ) )
        end

        table.insert( Table, Argument1.enabledChangedEvent.Event:Connect( UpdateButtonState ) )
        table.insert( Table, Object:GetPropertyChangedSignal( "Enabled" ):Connect( UpdateButtonState ) )
        UIButton.Destroying:Connect( function()
            local Value1 = nil

            for Key, Value in Table, nil, nil do
                Value:Disconnect( )
            end

            table.clear( Table )
        end )
        local Table2 = { instance = UIButton }
        function Table2.Destroy( Argument1 )
            UIButton:Destroy( )
        end
        function Table2.SetSelectionPressed( Argument1, Argument2 )
            if Flag2 == Argument2 then
                return
            end

            local SelectionActivateBinding2
            Flag2 = Argument2
            local SelectionActivateBinding = Object:FindFirstChild( "SelectionActivateBinding" )

            if SelectionActivateBinding then
                SelectionActivateBinding2 = SelectionActivateBinding
            else
                local InputBinding = Instance.new( "InputBinding" )
                InputBinding.Name = "SelectionActivateBinding"
                InputBinding.Type = Enum.InputBindingType.Scriptable
                InputBinding.Parent = Object
                SelectionActivateBinding2 = InputBinding
            end

            SelectionActivateBinding2:Fire( Argument2 )
            UpdateButtonState( )
        end
        return Table2
    end
}
