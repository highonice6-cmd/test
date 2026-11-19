-- Players.perkbrokeyou.PlayerScripts.VipNameClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local RunService = game:GetService( "RunService" )
local Table = { }

local function Add( Key )
    if Key:IsA( "UIGradient" ) then
        Table[ Key ] = { shift = math.random( ) * 3, ratio = -1, w = 0 }
    end
end

CollectionService:GetInstanceAddedSignal( "VipName" ):Connect( Add )
CollectionService:GetInstanceRemovedSignal( "VipName" ):Connect( function( Key )
    Table[ Key ] = nil

    if Key:IsA( "UIGradient" ) then
        Key.Offset = Vector2.new( -1, 0 )
    end
end )

for Key, Value in CollectionService:GetTagged( "VipName" ) do
    if Value:IsA( "UIGradient" ) then
        Table[ Value ] = { shift = math.random( ) * 3, ratio = -1, w = 0 }
    end
end

local function Band( Self, Ratio )
    local Clamp = math.clamp( ( tonumber( Self:GetAttribute( "Width" ) ) or 0.14 ) * Ratio, 0.005, 0.45 )
    local Clamp2 = math.clamp( tonumber( Self:GetAttribute( "Peak" ) ) or 0.3, 0, 1 )
    Self.Transparency = NumberSequence.new( {
        NumberSequenceKeypoint.new( 0, 1 ),
        NumberSequenceKeypoint.new( 0.5 - Clamp, 1 ),
        NumberSequenceKeypoint.new( 0.5, Clamp2 ),
        NumberSequenceKeypoint.new( Clamp + 0.5, 1 ),
        NumberSequenceKeypoint.new( 1, 1 )
    } )
    return Clamp
end

local Number = 0
RunService.Heartbeat:Connect( function( Argument1 )
    if next( Table ) == nil then
        return
    end

    Number = Number + Argument1

    if Number < 0.03333333333333333 then
        return
    end

    Number = 0
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Value1
    local Position = CurrentCamera.CFrame.Position
    local Clock = os.clock( )
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local BillboardGui
        local Parent = Key.Parent

        if Parent then
            BillboardGui = Parent:FindFirstAncestorOfClass( "BillboardGui" )
        else
            BillboardGui = Parent
        end

        local Parent2 = if BillboardGui then BillboardGui.Adornee else BillboardGui
        local Flag

        if Parent2 == nil then
            Flag = false
        else
            local IsA = Parent2:IsA( "BasePart" )

            if IsA then
                if ( Parent2.Position - Position ).Magnitude <= BillboardGui.MaxDistance + 5 then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = IsA
            end
        end

        local NotParent2
        local NotParent = not BillboardGui

        if NotParent then
            if Parent == nil then
                NotParent2 = false
            else
                local IsA2 = Parent:IsA( "TextLabel" )

                if IsA2 then
                    local Visible = Parent.Visible

                    if Visible then
                        if Parent:FindFirstAncestorOfClass( "ScreenGui" ) == nil then
                            NotParent2 = false
                        else
                            NotParent2 = true
                        end
                    else
                        NotParent2 = Visible
                    end
                else
                    NotParent2 = IsA2
                end
            end
        else
            NotParent2 = NotParent
        end
        if Flag or NotParent2 then
            if Parent:IsA( "TextLabel" ) and Parent.AbsoluteSize.X > 0 then
                local Ratio = math.min( Parent.TextBounds.X / Parent.AbsoluteSize.X, 1 )

                if math.abs( Ratio - Value.ratio ) > 0.01 then
                    local W = Band( Key, Ratio )
                    Value.ratio = Ratio
                    Value.w = W
                end

                local Min4
                local Min = Ratio / 2 + Value.w + 0.05

                if Parent.TextXAlignment == Enum.TextXAlignment.Right then
                    local Min2 = 0.5 - Ratio / 2

                    if Min2 then
                        Min4 = Min2
                    elseif Parent.TextXAlignment == Enum.TextXAlignment.Left then
                        local Min3 = Ratio / 2 - 0.5

                        if Min3 then
                            Min4 = Min3
                        else
                            Min4 = 0
                        end
                    else
                        Min4 = 0
                    end
                elseif Parent.TextXAlignment == Enum.TextXAlignment.Left then
                    local Min3 = Ratio / 2 - 0.5

                    if Min3 then
                        Min4 = Min3
                    else
                        Min4 = 0
                    end
                else
                    Min4 = 0
                end

                local Amount2
                local NumberInner = tonumber( Key:GetAttribute( "Sweep" ) ) or 1.1
                local Clock2 = ( Clock + Value.shift ) % ( NumberInner + ( tonumber( Key:GetAttribute( "Pause" ) ) or 1.4 ) )

                if Clock2 < NumberInner then
                    local Amount = -Min + 2 * Min * ( Clock2 / NumberInner )

                    if Amount then
                        Amount2 = Amount
                    else
                        Amount2 = Min
                    end
                else
                    Amount2 = Min
                end

                local Min5 = Min4 + Amount2

                if Key.Offset.X ~= Min5 then
                    Key.Offset = Vector2.new( Min5, 0 )
                end
            end
        end
    end
end )
