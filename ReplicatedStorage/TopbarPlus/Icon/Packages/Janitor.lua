-- ReplicatedStorage.TopbarPlus.Icon.Packages.Janitor
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Heartbeat = game:GetService( "RunService" ).Heartbeat

local function GetPromiseReference()
    return false
end

local Newproxy = newproxy( true )
getmetatable( Newproxy ).__tostring = function()
    return "IndicesReference"
end
local Newproxy2 = newproxy( true )
getmetatable( Newproxy2 ).__tostring = function()
    return "LinkToInstanceIndex"
end
local Class = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor",
    __index = { CurrentlyCleaning = true, [ Newproxy ] = nil }
}
local Table = {
    [ "function" ] = true,
    Promise = "cancel",
    RBXScriptConnection = "Disconnect"
}
function Class.new()
    return ( setmetatable( { CurrentlyCleaning = false, [ Newproxy ] = nil }, Class ) )
end
function Class.Is( Argument1 )
    local Flag

    if type( Argument1 ) == "table" then
        if getmetatable( Argument1 ) == Class then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end
Class.is = Class.Is

local function Add( Self, List, Key, Key2 )
    if Key2 then
        local Entry2
        Self:Remove( Key2 )
        local Entry = Self[ Newproxy ]

        if Entry then
            Entry2 = Entry
        else
            local TableInner = { }
            Self[ Newproxy ] = TableInner
            Entry2 = TableInner
        end

        Entry2[ Key2 ] = List
    end

    local Kind2
    local Kind = typeof( List )
    Kind2 = if Kind ~= "table" or not string.match( tostring( List ), "Promise" ) then Kind else "Promise"
    local Entry4

    if Key then
        Entry4 = Key
    else
        local Entry3 = Table[ Kind2 ]

        if Entry3 then
            Entry4 = Entry3
        else
            Entry4 = "Destroy"
        end
    end
    if type( List ) ~= "function" and not List[ Entry4 ] then
        warn( string.format( "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring( List ), tostring( Entry4 ), debug.traceback( nil, 2 ) ) )
    end

    Self[ List ] = { Entry4, ( debug.traceback( "" ) ) }
    return List
end

Class.__index.Add = Add
local __index = Class.__index
__index.Give = Class.__index.Add

local function AddPromise( Argument1, Argument2 )
    if true then
        return Argument2
    end
    if not ( false ).is( Argument2 ) then
        error( string.format( "Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof( Argument2 ), ( tostring( Argument2 ) ) ) )
    end
    if Argument2:getStatus( ) == ( false ).Status.Started then
        local Newproxy = newproxy( false )
        local Add = Argument1:Add( ( false ).new( function( Callback, Argument2Inner, Callback2 )
            if Callback2( function()
                Argument2:cancel( )
            end ) then
                return
            end
            Callback( Argument2 )
            return
        end ), "cancel", Newproxy )
        Add:finallyCall( Argument1.Remove, Argument1, Newproxy )
        return Add
    end
    return Argument2
end

Class.__index.AddPromise = AddPromise
local __index2 = Class.__index
__index2.GivePromise = Class.__index.AddPromise

local function AddObject( Argument1, Argument2 )
    local Newproxy = newproxy( false )

    if true or not ( false ).is( Argument2 ) then
        return Argument1:Add( Argument2, false, Newproxy ), Newproxy
    end
    if Argument2:getStatus( ) == ( false ).Status.Started then
        local Add = Argument1:Add( ( false ).resolve( Argument2 ), "cancel", Newproxy )
        Add:finallyCall( Argument1.Remove, Argument1, Newproxy )
        return Add, Newproxy
    end
    return Argument2
end

Class.__index.AddObject = AddObject
local __index3 = Class.__index
__index3.GiveObject = Class.__index.AddObject

local function Remove( List, Key )
    local Entry = List[ Newproxy ]

    if Entry and Entry[ Key ] then
        local Entry3
        local Entry2 = List[ Entry[ Key ] ]
        Entry3 = if Entry2 then Entry2[ 1 ] else Entry2

        if Entry3 then
            if Entry3 == true then
                Entry[ Key ]( )
            else
                local Entry4 = Entry[ Key ][ Entry3 ]

                if Entry4 then
                    Entry4( Entry[ Key ] )
                end
            end

            List[ Entry[ Key ] ] = nil
        end

        Entry[ Key ] = nil
    end

    return List
end

Class.__index.Remove = Remove

local function Get( List, Key )
    local Entry = List[ Newproxy ]

    if Entry then
        return Entry[ Key ]
    end
    return nil
end

Class.__index.Get = Get

local function Cleanup( List )
    if not List.CurrentlyCleaning then
        local Value1
        List.CurrentlyCleaning = nil
        Value1 = nil

        for Key, Value in next, List, nil do
            if Key ~= Newproxy then
                local Kind = type( Key )

                if Kind == "string" or Kind == "number" then
                    List[ Key ] = nil
                else
                    local Item = Value[ 1 ]
                    local Item2 = Value[ 2 ]

                    local function WarnUser( Argument1 )
                        local Traceback = debug.traceback( "", 3 )
                        warn( "-------- Janitor Error --------" .. "\n" .. tostring( Argument1 ) .. "\n" .. Traceback .. "" .. Item2 )
                    end

                    if Item == true then
                        local Success, Result = pcall( Key )

                        if not Success then
                            local Traceback = debug.traceback( "", 3 )
                            warn( "-------- Janitor Error --------" .. "\n" .. tostring( Result ) .. "\n" .. Traceback .. "" .. Item2 )
                        end
                    else
                        local Entry2 = Key[ Item ]

                        if Entry2 then
                            local Flag
                            local Success2, Result2 = pcall( Entry2, Key )

                            if typeof( Key ) == "Instance" then
                                if Entry2 == "Destroy" then
                                    Flag = true
                                else
                                    Flag = false
                                end
                            else
                                Flag = false
                            end
                            if not Success2 and not Flag then
                                local Traceback2 = debug.traceback( "", 3 )
                                warn( "-------- Janitor Error --------" .. "\n" .. tostring( Result2 ) .. "\n" .. Traceback2 .. "" .. Item2 )
                            end
                        end
                    end

                    List[ Key ] = nil
                end
            end
        end

        local Entry = List[ Newproxy ]

        if Entry then
            local Value2 = nil

            for Value3 in next, Entry, nil do
                Entry[ Value3 ] = nil
            end

            List[ Newproxy ] = { }
        end

        List.CurrentlyCleaning = false
    end
end

Class.__index.Cleanup = Cleanup
local __index4 = Class.__index
__index4.Clean = Class.__index.Cleanup

local function Destroy( Argument1 )
    Argument1:Cleanup( )
end

Class.__index.Destroy = Destroy
Class.__call = Class.__index.Cleanup
local __index5 = { Connected = true }
__index5.__index = __index5
function __index5.Disconnect( Argument1 )
    if Argument1.Connected then
        Argument1.Connected = false
        Argument1.Connection:Disconnect( )
    end
end
function __index5.__tostring( Argument1 )
    return "Disconnect<" .. tostring( Argument1.Connected ) .. ">"
end

local function LinkToInstance( Argument1, Argument2, Argument3 )
    local Newproxy2Inner
    local Connection = nil

    if Argument3 then
        local Newproxy = newproxy( false )

        if Newproxy then
            Newproxy2Inner = Newproxy
        else
            Newproxy2Inner = Newproxy2
        end
    else
        Newproxy2Inner = Newproxy2
    end

    local Flag

    if Argument2.Parent == nil then
        Flag = true
    else
        Flag = false
    end

    local Self = setmetatable( { }, __index5 )

    local function ChangedFunction( Argument1Inner, Argument2 )
        if Self.Connected then
            local FlagInner = Argument2 == nil and true or false
            Flag = FlagInner

            if Flag then
                coroutine.wrap( function()
                    Heartbeat:Wait( )

                    if not Self.Connected then
                        return
                    end
                    if not Connection.Connected then
                        Argument1:Cleanup( )
                        return
                    end
                    while Flag do
                        if not Connection.Connected or not Self.Connected then
                            break
                        end

                        Heartbeat:Wait( )
                    end
                    if Self.Connected and Flag then
                        Argument1:Cleanup( )
                    end
                end )( )
            end
        end
    end

    Connection = Argument2.AncestryChanged:Connect( ChangedFunction )
    Self.Connection = Connection

    if Flag then
        local Parent = Argument2.Parent

        if Self.Connected then
            if Parent == nil then
                Flag = true
            else
                Flag = false
            end
            if Flag then
                coroutine.wrap( function()
                    Heartbeat:Wait( )

                    if not Self.Connected then
                        return
                    end
                    if not Connection.Connected then
                        Argument1:Cleanup( )
                        return
                    end
                    while Flag do
                        if not Connection.Connected or not Self.Connected then
                            break
                        end

                        Heartbeat:Wait( )
                    end
                    if Self.Connected and Flag then
                        Argument1:Cleanup( )
                    end
                end )( )
            end
        end
    end

    local Add = Argument1:Add( Self, "Disconnect", Newproxy2Inner )
    return Add
end

Class.__index.LinkToInstance = LinkToInstance

local function LinkToInstances( Argument1, ... )
    local New = Class.new( )

    for Index, Value in ipairs( { ... } ) do
        New:Add( Argument1:LinkToInstance( Value, true ), "Disconnect" )
    end

    return New
end

Class.__index.LinkToInstances = LinkToInstances
local __index6 = Class.__index
Value1 = nil

for Key, Value in next, __index6, nil do
    local Text = string.sub( string.lower( Key ), 1, 1 ) .. string.sub( Key, 2 )
    Class.__index[ Text ] = Value
end

return Class
