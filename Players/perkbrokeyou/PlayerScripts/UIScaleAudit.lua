-- Players.perkbrokeyou.PlayerScripts.UIScaleAudit
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

if game:GetService( "RunService" ):IsStudio( ) then
    local LocalPlayer = game:GetService( "Players" ).LocalPlayer
    local Table = {
        "TopbarStandard",
        "TopbarCentered",
        "TopbarPlus",
        "PlayerGui.ProximityPrompts"
    }
    local Table2 = { }

    local function Exempt( Object )
        local Parent = Object

        while Parent do
            if Parent == LocalPlayer.PlayerGui then
                break
            end
            if Parent:GetAttribute( "OffsetOK" ) then
                return true
            end

            Parent = Parent.Parent
        end

        local Value1
        local FullName = Object:GetFullName( )
        Value1 = nil

        for Key, Value in Table, nil, nil do
            if FullName:find( Value, 1, true ) then
                return true
            end
        end

        return false
    end

    local function Off2( Argument1 )
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

    local function Issues( Self )
        local Table = { }

        if Self:IsA( "GuiObject" ) then
            local Flag2
            local Size = Self.Size

            if Size.X.Scale == 0 then
                if Size.Y.Scale == 0 then
                    if Size.X.Offset <= 1 then
                        if Size.Y.Offset <= 1 then
                            Flag2 = true
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end
                else
                    Flag2 = false
                end
            else
                Flag2 = false
            end

            local Flag

            if Size.X.Offset == 0 then
                if Size.Y.Offset == 0 then
                    Flag = false
                else
                    Flag = true
                end
            else
                Flag = true
            end
            if Flag and not Flag2 then
                table.insert( Table, "Size" )
            end

            local Flag3
            local Position = Self.Position

            if Position.X.Offset == 0 then
                if Position.Y.Offset == 0 then
                    Flag3 = false
                else
                    Flag3 = true
                end
            else
                Flag3 = true
            end
            if Flag3 and not Flag2 then
                table.insert( Table, "Position" )
            end
            if Self:IsA( "ScrollingFrame" ) then
                local Flag4
                local CanvasSize = Self.CanvasSize

                if CanvasSize.X.Offset == 0 then
                    if CanvasSize.Y.Offset == 0 then
                        Flag4 = false
                    else
                        Flag4 = true
                    end
                else
                    Flag4 = true
                end
                if Flag4 then
                    table.insert( Table, "CanvasSize" )
                    return Table
                end
            end
        elseif Self:IsA( "UIStroke" ) then
            if Self.StrokeSizingMode ~= Enum.StrokeSizingMode.ScaledSize and Self.Thickness > 0 and Self.Enabled then
                table.insert( Table, "UIStroke (pas ScaledSize)" )
                return Table
            end
        elseif Self:IsA( "UICorner" ) then
            if Self.CornerRadius.Offset ~= 0 then
                table.insert( Table, "CornerRadius" )
                return Table
            end
        elseif Self:IsA( "UIPadding" ) then
            if Self.PaddingTop.Offset ~= 0 or Self.PaddingBottom.Offset ~= 0 or Self.PaddingLeft.Offset ~= 0 or Self.PaddingRight.Offset ~= 0 then
                table.insert( Table, "Padding" )
                return Table
            end
        elseif Self:IsA( "UIListLayout" ) then
            if Self.Padding.Offset ~= 0 then
                table.insert( Table, "Padding" )
                return Table
            end
        elseif Self:IsA( "UIGridLayout" ) then
            local Flag5
            local CellSize = Self.CellSize

            if CellSize.X.Offset == 0 then
                if CellSize.Y.Offset == 0 then
                    Flag5 = false
                else
                    Flag5 = true
                end
            else
                Flag5 = true
            end
            if Flag5 then
                table.insert( Table, "CellSize" )
            end

            local Flag6
            local CellPadding = Self.CellPadding

            if CellPadding.X.Offset == 0 then
                if CellPadding.Y.Offset == 0 then
                    Flag6 = false
                else
                    Flag6 = true
                end
            else
                Flag6 = true
            end
            if Flag6 then
                table.insert( Table, "CellPadding" )
            end
        end

        return Table
    end

    local function Scan()
        local Table = { }

        for Key, Value in LocalPlayer.PlayerGui:GetDescendants( ) do
            if not Table2[ Value ] then
                local Issues2 = Issues( Value )

                if #Issues2 > 0 and not Exempt( Value ) then
                    Table2[ Value ] = true
                    local Gsub = Value:GetFullName( ):gsub( "^Players%.[^%.]+%.PlayerGui%.", "" )
                    table.insert( Table, Gsub .. " : " .. table.concat( Issues2, ", " ) )
                end
            end
        end
        if #Table > 0 then
            warn( ( "[UI en pixels] %d objet(s) pas en scale (téléphone / tablette / grands écrans) :\n  %s" ):format( #Table, table.concat( Table, "\n  " ) ) )
        end
    end

    task.delay( 15, function()
        while true do
            pcall( Scan )
            task.wait( 60 )
        end
    end )
    return
end
return
