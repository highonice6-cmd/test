-- StarterPlayer.StarterPlayerScripts.RbxCharacterSounds.AtomicBinding
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local function ParsePath( Text )
    local Split = string.split( Text, "/" )
    local Count = #Split
    local I = Count

    for I = Count, 1, -1 do
        if Split[ I ] == "" then
            table.remove( Split, I )
        end
    end

    return Split
end

local function IsManifestResolved( List, Argument2 )
    local Number = 0

    for Value in pairs( List ) do
        Number = Number + 1
    end

    local Flag = Number <= Argument2 and true or false
    local Flag2
    assert( Flag, Number )
    Flag2 = Number == Argument2 and true or false
    return Flag2
end

local function UnbindNodeDescend( Entry, List )
    if Entry.instance == nil then
        return
    end

    Entry.instance = nil
    local Connections = Entry.connections

    if Connections then
        for Index, Value in ipairs( Connections ) do
            Value:Disconnect( )
        end

        table.clear( Connections )
    end
    if List and Entry.alias then
        List[ Entry.alias ] = nil
    end

    local Children = Entry.children

    if Children then
        for Key, Value3 in pairs( Children ) do
            UnbindNodeDescend( Value3, List )
        end
    end
end

local __index = { }
__index.__index = __index
function __index.new( List, Argument2 )
    local Number
    local Table = { }
    local Table2 = { }
    local Table3 = { }
    local Table4 = { }
    local Table5 = { }
    Number = 1

    for Key, Value in pairs( List ) do
        Table5[ Key ] = ParsePath( Value )
        Number = Number + 1
    end

    return ( setmetatable( {
        _boundFn = Argument2,
        _parsedManifest = Table5,
        _manifestSizeTarget = Number,
        _dtorMap = Table,
        _connections = Table2,
        _rootInstToRootNode = Table3,
        _rootInstToManifest = Table4
    }, __index ) )
end
function __index._startBoundFn( Argument1, Key, Argument3 )
    local _boundFn = Argument1._boundFn
    local _dtorMap = Argument1._dtorMap
    local Entry = _dtorMap[ Key ]

    if Entry then
        Entry( )
        _dtorMap[ Key ] = nil
    end

    local _boundFn2 = _boundFn( Argument3 )

    if _boundFn2 then
        _dtorMap[ Key ] = _boundFn2
    end
end
function __index._stopBoundFn( Argument1, Key )
    local _dtorMap = Argument1._dtorMap
    local Entry = _dtorMap[ Key ]

    if Entry then
        Entry( )
        _dtorMap[ Key ] = nil
    end
end
function __index.bindRoot( Argument1, RootName )
    local Flag
    debug.profilebegin( "AtomicBinding:BindRoot" )
    local _parsedManifest = Argument1._parsedManifest
    local _rootInstToRootNode = Argument1._rootInstToRootNode
    local _rootInstToManifest = Argument1._rootInstToManifest
    local _manifestSizeTarget = Argument1._manifestSizeTarget
    Flag = _rootInstToManifest[ RootName ] == nil and true or false
    assert( Flag )
    local Table = { }
    _rootInstToManifest[ RootName ] = Table
    debug.profilebegin( "BuildTree" )
    local Table2 = { alias = "root", instance = RootName }

    if next( _parsedManifest ) then
        Table2.children = { }
        Table2.connections = { }
    end

    _rootInstToRootNode[ RootName ] = Table2

    for Key, Value in pairs( _parsedManifest ) do
        local Table3 = Table2

        for Index, Value3 in ipairs( Value ) do
            local Flag2 = Index == #Value and true or false
            local Entry2
            local Entry = Table3.children[ Value3 ]
            Entry2 = if Entry then Entry else { }

            if Flag2 then
                if Entry2.alias ~= nil then
                    error( "Multiple aliases assigned to one instance" )
                end

                Entry2.alias = Key
            else
                local Children2
                local Children = Entry2.children
                Children2 = if Children then Children else { }
                local Connections2
                Entry2.children = Children2
                local Connections = Entry2.connections
                Connections2 = if Connections then Connections else { }
                Entry2.connections = Connections2
            end

            Table3.children[ Value3 ] = Entry2
            Table3 = Entry2
        end
    end

    debug.profileend( )

    local function ProcessNode( Argument1Inner )
        local Assert = assert( Argument1Inner.instance )
        local Children = Argument1Inner.children
        local Alias = Argument1Inner.alias
        local NotChildren = not Children

        if Alias then
            Table[ Alias ] = Assert
        end
        if not NotChildren then
            local function ProcessAddChild( Instance )
                local Entry = Children[ Instance.Name ]

                if not Entry or Entry.instance ~= nil then
                    return
                end
                Entry.instance = Instance
                ProcessNode( Entry )
                return
            end

            local function ProcessDeleteChild( Argument1Inner )
                local Name = Argument1Inner.Name
                local Entry = Children[ Name ]

                if not Entry then
                    return
                end
                if Entry.instance ~= Argument1Inner then
                    return
                end

                local Flag
                Argument1:_stopBoundFn( RootName )
                UnbindNodeDescend( Entry, Table )
                Flag = Entry.instance == nil and true or false
                assert( Flag )
                local Instance = Assert:FindFirstChild( Name )

                if Instance then
                    local Entry2 = Children[ Instance.Name ]

                    if Entry2 then
                        if Entry2.instance ~= nil then
                            return
                        end

                        Entry2.instance = Instance
                        ProcessNode( Entry2 )
                    end
                end
            end

            for Index, Value in ipairs( Assert:GetChildren( ) ) do
                local Entry = Children[ Value.Name ]

                if Entry then
                    if Entry.instance == nil then
                        Entry.instance = Value
                        ProcessNode( Entry )
                    end
                end
            end

            local Connections = Argument1Inner.connections
            table.insert( Connections, Assert.ChildAdded:Connect( ProcessAddChild ) )
            local Connections2 = Argument1Inner.connections
            table.insert( Connections2, Assert.ChildRemoved:Connect( ProcessDeleteChild ) )
        end
        if NotChildren then
            local Number = 0

            for Value3 in pairs( Table ) do
                Number = Number + 1
            end

            local Flag = Number <= _manifestSizeTarget and true or false
            local Flag2
            assert( Flag, Number )
            Flag2 = Number == _manifestSizeTarget and true or false

            if Flag2 then
                Argument1:_startBoundFn( RootName, Table )
            end
        end
    end

    debug.profilebegin( "ResolveTree" )
    ProcessNode( Table2 )
    debug.profileend( )
    debug.profileend( )
end
function __index.unbindRoot( Self, RootName )
    local _rootInstToRootNode = Self._rootInstToRootNode
    local _rootInstToManifest = Self._rootInstToManifest
    Self:_stopBoundFn( RootName )
    local Entry = _rootInstToRootNode[ RootName ]

    if Entry then
        UnbindNodeDescend( Entry, ( assert( _rootInstToManifest[ RootName ] ) ) )
        _rootInstToRootNode[ RootName ] = nil
    end

    _rootInstToManifest[ RootName ] = nil
end
function __index.destroy( Argument1 )
    debug.profilebegin( "AtomicBinding:destroy" )

    for Key, Value in pairs( Argument1._dtorMap ) do
        Value:destroy( )
    end

    table.clear( Argument1._dtorMap )

    for Index, Value3 in ipairs( Argument1._connections ) do
        Value3:Disconnect( )
    end

    table.clear( Argument1._connections )
    local _rootInstToManifest = Argument1._rootInstToManifest

    for Key2, Value5 in pairs( Argument1._rootInstToRootNode ) do
        UnbindNodeDescend( Value5, ( assert( _rootInstToManifest[ Key2 ] ) ) )
    end

    table.clear( Argument1._rootInstToManifest )
    table.clear( Argument1._rootInstToRootNode )
    debug.profileend( )
end
return __index
