-- ReplicatedStorage.TopbarPlus.Icon.VERSION
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = { appVersion = "v3.4.0" }
Table.latestVersion = Table.appVersion
function Table.getLatestVersion()
    local LatestVersion = Table.latestVersion

    if LatestVersion then
        return LatestVersion
    end

    local Name

    while true do
        local Success, Result = pcall( function()
            return game:GetService( "MarketplaceService" ):GetProductInfo( 117501901079852 )
        end )

        if not Success or not Result then
            task.wait( 1 )
            continue
        end
        Name = Result.Name
        break
    end

    local LatestVersion2
    local Match = string.match( Name, "^TopbarPlus (.*)$" )

    if Match then
        LatestVersion2 = Match:gsub( "%s+", "" )
    else
        LatestVersion2 = Match
    end

    Table.latestVersion = LatestVersion2
    return LatestVersion2
end
function Table.getAppVersion()
    return Table.appVersion
end
function Table.isUpToDate()
    local Flag
    local LatestVersion = Table.getLatestVersion( )
    local AppVersion = Table.getAppVersion( )

    if LatestVersion == nil then
        Flag = false
    elseif LatestVersion == AppVersion then
        Flag = true
    else
        Flag = false
    end

    return Flag
end
return Table
