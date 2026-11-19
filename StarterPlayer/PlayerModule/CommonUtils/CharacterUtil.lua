-- StarterPlayer.PlayerModule.CommonUtils.CharacterUtil
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local Get = require( script.Parent ).get( "ConnectionUtil" )
local Table = {
    LOCAL_PLAYER = "LOCAL_PLAYER",
    ON_LOCAL_PLAYER = "ON_LOCAL_PLAYER",
    CHARACTER_ADDED = "CHARACTER_ADDED",
    ON_CHARACTER = "ON_CHARACTER",
    CHARACTER_CHILD_ADDED = "CHARACTER_CHILD_ADDED"
}
local Table2 = { }
Table2._connectionUtil = Get.new( )
Table2._boundEvents = { }
function Table2.getLocalPlayer()
    return Players.LocalPlayer
end
function Table2.onLocalPlayer( Callback )
    local LocalPlayer = Table2.getLocalPlayer( )

    if LocalPlayer then
        Callback( LocalPlayer )
    end

    local _connectionUtil = Table2._connectionUtil
    _connectionUtil:trackConnection( "LOCAL_PLAYER", Players:GetPropertyChangedSignal( "LocalPlayer" ):Connect( function()
        local LocalPlayer = Table2.getLocalPlayer( )
        assert( LocalPlayer )
        Table2._getOrCreateBoundEvent( "LOCAL_PLAYER" ):Fire( LocalPlayer )
    end ) )
    return Table2._getOrCreateBoundEvent( "LOCAL_PLAYER" ).Event:Connect( Callback )
end
function Table2.getCharacter()
    local LocalPlayer = Table2.getLocalPlayer( )

    if LocalPlayer then
        return LocalPlayer.Character
    end
    return nil
end
function Table2.onCharacter( Argument1 )
    local _connectionUtil = Table2._connectionUtil
    _connectionUtil:trackConnection( "ON_LOCAL_PLAYER", Table2.onLocalPlayer( function( Argument1Inner )
        local Character = Table2.getCharacter( )

        if Character then
            Argument1( Character )
        end

        local _connectionUtil = Table2._connectionUtil
        _connectionUtil:trackConnection( "CHARACTER_ADDED", Argument1Inner.CharacterAdded:Connect( function( Argument1 )
            assert( Argument1 )
            Table2._getOrCreateBoundEvent( "CHARACTER_ADDED" ):Fire( Argument1 )
        end ) )
    end ) )
    return Table2._getOrCreateBoundEvent( "CHARACTER_ADDED" ).Event:Connect( Argument1 )
end
function Table2.getChild( Name, ClassName )
    local Character = Table2.getCharacter( )

    if not Character then
        return nil
    end

    local FoundChild = Character:FindFirstChild( Name )

    if not FoundChild or not FoundChild:IsA( ClassName ) then
        return nil
    end
    return FoundChild
end
function Table2.onChild( Text, Text2, Argument3 )
    local _connectionUtil = Table2._connectionUtil
    _connectionUtil:trackConnection( "ON_CHARACTER", Table2.onCharacter( function( Argument1 )
        local Child = Table2.getChild( Text, Text2 )

        if Child then
            Argument3( Child )
        end

        local _connectionUtil = Table2._connectionUtil
        _connectionUtil:trackConnection( "CHARACTER_CHILD_ADDED", Argument1.ChildAdded:Connect( function( Object )
            if Object.Name == Text and Object:IsA( Text2 ) then
                Table2._getOrCreateBoundEvent( "CHARACTER_CHILD_ADDED" .. Text .. Text2 ):Fire( Object )
            end
        end ) )
    end ) )
    return Table2._getOrCreateBoundEvent( "CHARACTER_CHILD_ADDED" .. Text .. Text2 ).Event:Connect( Argument3 )
end
function Table2._getOrCreateBoundEvent( Key )
    if not Table2._boundEvents[ Key ] then
        local _boundEvents = Table2._boundEvents
        _boundEvents[ Key ] = Instance.new( "BindableEvent" )
    end

    return Table2._boundEvents[ Key ]
end
return Table2
