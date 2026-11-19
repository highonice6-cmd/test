-- StarterPlayer.StarterPlayerScripts.WardrobeTopbarClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local LocalizationService = game:GetService( "LocalizationService" )
local Icon = require( ReplicatedStorage:WaitForChild( "TopbarPlus" ):WaitForChild( "Icon" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Table = {
    en = "Wardrobe",
    fr = "Garde-robe",
    es = "Armario",
    pt = "Guarda-roupa",
    de = "Garderobe",
    it = "Guardaroba",
    nl = "Garderobe",
    pl = "Garderoba",
    tr = "Gardırop",
    ru = "Гардероб",
    uk = "Гардероб",
    id = "Lemari",
    vi = "Tủ đồ",
    th = "ตู้เสื้อผ้า",
    ja = "ワードローブ",
    ko = "옷장",
    zh = "衣柜",
    ar = "خزانة الملابس",
    sv = "Garderob",
    da = "Garderobe",
    no = "Garderobe",
    nb = "Garderobe",
    fi = "Vaatekaappi",
    cs = "Šatník",
    ro = "Garderobă",
    hu = "Ruhatár",
    el = "Γκαρνταρόμπα",
    he = "ארון בגדים",
    hi = "अलमारी",
    ms = "Almari",
    fil = "Aparador",
    tl = "Aparador"
}

local function Label()
    local Lower
    local Success, Result = pcall( function()
        return LocalizationService.RobloxLocaleId
    end )
    Lower = Success and type( Result ) == "string" and Result:lower( ) or "en"
    local Entry3
    local Entry = Table[ Lower:match( "^(%a+)" ) or "en" ]

    if Entry then
        Entry3 = Entry
    else
        local Entry2 = Table[ Lower:sub( 1, 2 ) ]

        if Entry2 then
            Entry3 = Entry2
        else
            Entry3 = "Wardrobe"
        end
    end

    return Entry3
end

local New = Icon.new( )
New:setName( "Wardrobe" )
New:setLabel( ( Label( ) ) )
New:setOrder( 0 )
New:oneClick( )
New.selected:Connect( function()
    if ClientState.Downed then
        return
    end
    if workspace:GetAttribute( "RankedMatch" ) then
        return
    end
    if ClientState.OpenWardrobe then
        ClientState.OpenWardrobe( )
    end
end )

local function SyncRanked()
    New:setEnabled( not workspace:GetAttribute( "RankedMatch" ) )
end

New:setEnabled( not workspace:GetAttribute( "RankedMatch" ) )
workspace:GetAttributeChangedSignal( "RankedMatch" ):Connect( SyncRanked )
