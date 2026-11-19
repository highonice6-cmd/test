-- ReplicatedStorage.TopbarPlus.Icon.Features.Themes
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Utility = require( script.Parent.Parent.Utility )
local Default = require( script.Default )
local Table = {
    getThemeValue = function( List, Argument2, Argument3, Argument4 )
        if List then
            for Key, Value in pairs( List ) do
                local Unpack, Unpack2, Unpack3 = unpack( Value )

                if Argument2 == Unpack then
                    if Argument3 == Unpack2 then
                        return Unpack3
                    end
                end
            end
        end

        return nil
    end,
    getInstanceValue = function( Object, Attribute )
        local Success, Result = pcall( function()
            return Object[ Attribute ]
        end )

        if not Success then
            Result = Object:GetAttribute( Attribute )
        end

        return Result
    end,
    getRealInstance = function( Self )
        if not Self:GetAttribute( "IsAClippedClone" ) then
            return
        end

        local OriginalInstance = Self:FindFirstChild( "OriginalInstance" )

        if OriginalInstance then
            return OriginalInstance.Value
        end
        return
    end,
    getClippedClone = function( Self )
        if not Self:GetAttribute( "HasAClippedClone" ) then
            return
        end

        local ClippedClone = Self:FindFirstChild( "ClippedClone" )

        if ClippedClone then
            return ClippedClone.Value
        end
        return
    end
}
function Table.refresh( Argument1, Object, Argument3 )
    if Argument3 then
        local ThemeValue2
        local GetStateGroup = Argument1:getStateGroup( )
        local GetThemeValue = Table.getThemeValue
        local ThemeValue = GetThemeValue( GetStateGroup, Object.Name, Argument3 )
        ThemeValue2 = if ThemeValue then ThemeValue else Table.getInstanceValue( Object, Argument3 )
        Table.apply( Argument1, Object, Argument3, ThemeValue2, true )
        return
    end
    local GetStateGroup2 = Argument1:getStateGroup( )

    if not GetStateGroup2 then
        return
    end

    local TableInner = { [ Object.Name ] = Object }

    for Key, Value in pairs( Object:GetDescendants( ) ) do
        local Collective = Value:GetAttribute( "Collective" )

        if Collective then
            TableInner[ Collective ] = Value
        end

        TableInner[ Value.Name ] = Value
    end
    for Key2, Value3 in pairs( GetStateGroup2 ) do
        local Unpack, Unpack2, Unpack3 = unpack( Value3 )
        local Entry = TableInner[ Unpack ]

        if Entry then
            local Apply = Table.apply
            Apply( Argument1, Entry.Name, Unpack2, Unpack3, true )
        end
    end

    return
end
function Table.apply( Self, Text, Attribute, Argument4, Argument5 )
    if Self.isDestroyed then
        return
    end

    local Name, GetInstanceOrCollective

    if typeof( Text ) == "Instance" then
        Name = Text.Name
        GetInstanceOrCollective = { Text }
    else
        GetInstanceOrCollective = Self:getInstanceOrCollective( Text )
        Name = Text
    end

    local Text2 = Name .. "-" .. Attribute
    local Entry = Self.customBehaviours[ Text2 ]

    for Key, Value in pairs( GetInstanceOrCollective ) do
        local ClippedClone = Table.getClippedClone( Value )

        if ClippedClone then
            table.insert( GetInstanceOrCollective, ClippedClone )
        end
    end

    Argument4 = Argument4

    for Key2, Value3 in pairs( GetInstanceOrCollective ) do
        if Attribute ~= "Position" or not Table.getClippedClone( Value3 ) then
            if Attribute ~= "Size" or not Table.getRealInstance( Value3 ) then
                local InstanceValue = Table.getInstanceValue( Value3, Attribute )

                if Argument5 or Argument4 ~= InstanceValue then
                    if Entry and Entry( Argument4, Value3, Attribute ) ~= nil then
                        Argument4 = Entry( Argument4, Value3, Attribute )
                    end
                    if not pcall( function()
                        Value3[ Attribute ] = Argument4
                    end ) then
                        Value3:SetAttribute( Attribute, Argument4 )
                    end
                end
            end
        end
    end
end
function Table.getModifications( List )
    local Table = if typeof( List[ 1 ] ) == "table" then List else { List }
    return Table
end
function Table.merge( List, List2, Callback )
    local Unpack, Unpack2, Unpack3, Unpack4 = table.unpack( List2 )
    local Unpack5, Unpack22, _, Unpack42 = table.unpack( List )

    if Unpack ~= Unpack5 or Unpack2 ~= Unpack22 or not Table.statesMatch( Unpack4, Unpack42 ) then
        return false
    end

    List[ 3 ] = Unpack3

    if Callback then
        Callback( List )
    end

    return true
end
function Table.modify( Argument1, Argument2, Argument3 )
    task.spawn( function()
        Argument3 = Argument3 or Utility.generateUID( )
        Argument2 = Table.getModifications( Argument2 )

        for Key, Value in pairs( Argument2 ) do
            local Unpack, Unpack2, Unpack3, Unpack4 = table.unpack( Value )

            if Unpack4 == nil then
                Table.modify( Argument1, { Unpack, Unpack2, Unpack3, "Selected" }, Argument3 )
                Table.modify( Argument1, { Unpack, Unpack2, Unpack3, "Viewing" }, Argument3 )
            end

            local FormatStateName = Utility.formatStateName( Unpack4 or "Deselected" )
            local GetStateGroup = Argument1:getStateGroup( FormatStateName )

            local function NowSetIt()
                if FormatStateName == Argument1.activeState then
                    Table.apply( Argument1, Unpack, Unpack2, Unpack3 )
                end
            end

            ;( function()
                for Key, ValueInner in pairs( GetStateGroup ) do
                    if Table.merge( ValueInner, Value, function( List )
                        List[ 5 ] = Argument3

                        if FormatStateName == Argument1.activeState then
                            Table.apply( Argument1, Unpack, Unpack2, Unpack3 )
                        end
                    end ) then
                        return
                    end
                end

                table.insert( GetStateGroup, { Unpack, Unpack2, Unpack3, FormatStateName, Argument3 } )

                if FormatStateName == Argument1.activeState then
                    Table.apply( Argument1, Unpack, Unpack2, Unpack3 )
                end
            end )( )
        end
    end )
    return Argument3
end
function Table.remove( Argument1, Argument2 )
    for Key, Value in pairs( Argument1.appearance ) do
        local Count = #Value
        local J = Count

        for J = Count, 1, -1 do
            if Value[ J ][ 5 ] == Argument2 then
                table.remove( Value, J )
            end
        end
    end

    Table.rebuild( Argument1 )
end
function Table.removeWith( Argument1, Argument2, Argument3, Argument4 )
    for Key, Value in pairs( Argument1.appearance ) do
        if Argument4 == Key or not Argument4 then
            local Count = #Value
            local J = Count

            for J = Count, 1, -1 do
                local Entry = Value[ J ]
                local Item = Entry[ 1 ]
                local Item2 = Entry[ 2 ]

                if Item == Argument2 and Item2 == Argument3 then
                    table.remove( Value, J )
                end
            end
        end
    end

    Table.rebuild( Argument1 )
end
function Table.change( Argument1 )
    for Key, Value in pairs( ( Argument1:getStateGroup( ) ) ) do
        local Unpack, Unpack2, Unpack3 = unpack( Value )
        Table.apply( Argument1, Unpack, Unpack2, Unpack3 )
    end
end
function Table.set( Argument1, AppliedTheme )
    local AppliedTheme2
    local ThemesJanitor = Argument1.themesJanitor
    ThemesJanitor:clean( )
    ThemesJanitor:add( Argument1.stateChanged:Connect( function()
        Table.change( Argument1 )
    end ) )

    if typeof( AppliedTheme ) ~= "Instance" or not AppliedTheme:IsA( "ModuleScript" ) then
        AppliedTheme2 = AppliedTheme
    else
        AppliedTheme2 = require( AppliedTheme )
    end

    Argument1.appliedTheme = AppliedTheme2
    Table.rebuild( Argument1 )
end
function Table.statesMatch( Text, Text2 )
    local Flag

    if ( Text and string.lower( Text ) ) == ( Text2 and string.lower( Text2 ) ) then
        Flag = true
    else
        local IsMissing = not Text

        if IsMissing then
            Flag = IsMissing
        else
            Flag = not Text2
        end
    end

    return Flag
end
function Table.rebuild( Argument1 )
    local AppliedTheme = Argument1.appliedTheme
    local TableInner = { "Deselected", "Selected", "Viewing" }
    ;( function()
        for Key, Value in pairs( TableInner ) do
            local TableInner2 = { }

            local function UpdateDetails( List, Argument2 )
                if not List then
                    return
                end
                for Key, Value in pairs( List ) do
                    local Item = Value[ 5 ]
                    local Item2 = Value[ 4 ]

                    if Table.statesMatch( Argument2, Item2 ) then
                        local Item3 = Value[ 1 ]
                        local Text = Item3 .. "-" .. Value[ 2 ]
                        local CopyTable = Utility.copyTable( Value )
                        CopyTable[ 5 ] = Item
                        TableInner2[ Text ] = CopyTable
                    end
                end
            end

            if Value == "Selected" then
                UpdateDetails( Default, "Deselected" )
            end

            UpdateDetails( Default, "Empty" )
            UpdateDetails( Default, Value )

            if AppliedTheme ~= Default then
                if Value == "Selected" then
                    UpdateDetails( AppliedTheme, "Deselected" )
                end

                UpdateDetails( Default, "Empty" )
                UpdateDetails( AppliedTheme, Value )
            end

            local Table2 = { }
            local Entry = Argument1.appearance[ Value ]

            if Entry then
                for Key2, Value3 in pairs( Entry ) do
                    local Item = Value3[ 5 ]

                    if Item ~= nil then
                        table.insert( Table2, { Value3[ 1 ], Value3[ 2 ], Value3[ 3 ], Value, Item } )
                    end
                end
            end

            UpdateDetails( Table2, Value )
            local Table3 = { }

            for Key3, Value5 in pairs( TableInner2 ) do
                table.insert( Table3, Value5 )
            end

            Argument1.appearance[ Value ] = Table3
        end

        Table.change( Argument1 )
    end )( )
end
return Table
