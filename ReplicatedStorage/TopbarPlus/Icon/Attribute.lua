-- ReplicatedStorage.TopbarPlus.Icon.Attribute
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

task.defer( function()
    local RunService = game:GetService( "RunService" )
    local VERSION = require( script.Parent.VERSION )
    local AppVersion = VERSION.getAppVersion( )
    local LatestVersion = VERSION.getLatestVersion( )
    local NotIsUpToDate = not VERSION.isUpToDate( )

    if not RunService:IsStudio( ) then
        print( ( ( "🍍 Running TopbarPlus %* by @ForeverHD & HD Admin" ):format( AppVersion ) ) )
    end
    if NotIsUpToDate then
        warn( ( ( "A new version of TopbarPlus (%*) is available: https://devforum.roblox.com/t/topbarplus/1017485" ):format( LatestVersion ) ) )
    end
end )
return { }
