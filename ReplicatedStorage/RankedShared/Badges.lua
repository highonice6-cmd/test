-- ReplicatedStorage.RankedShared.Badges
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    Bronze = {
        "rbxassetid://95623693776641",
        "rbxassetid://130965498594178",
        "rbxassetid://125951888495429"
    },
    Silver = {
        "rbxassetid://132431750826177",
        "rbxassetid://114554917240430",
        "rbxassetid://106207267682119"
    },
    Gold = {
        "rbxassetid://111872004541771",
        "rbxassetid://111853971441423",
        "rbxassetid://134115479411432"
    },
    Diamond = {
        "rbxassetid://76293385527487",
        "rbxassetid://111474431545836",
        "rbxassetid://113398390181809"
    },
    Ruby = {
        "rbxassetid://138851908547770",
        "rbxassetid://127185695830490",
        "rbxassetid://97768088886649"
    },
    Champion = {
        "rbxassetid://129812075512112",
        "rbxassetid://90620542459163",
        "rbxassetid://81395975470955"
    },
    Top100 = "rbxassetid://88832345844265",
    Top1 = "rbxassetid://101042070222701",
    Unranked = "rbxassetid://89533805743424"
}
Table.Top100Place = {
    [ 2 ] = "rbxassetid://132665080354360",
    [ 3 ] = "rbxassetid://114220441631404",
    [ 4 ] = "rbxassetid://85918534568629",
    [ 5 ] = "rbxassetid://139719175586997",
    [ 6 ] = "rbxassetid://79816282331083",
    [ 7 ] = "rbxassetid://101778554886622",
    [ 8 ] = "rbxassetid://78297512674578",
    [ 9 ] = "rbxassetid://73300254440805",
    [ 10 ] = "rbxassetid://77644110836704",
    [ 11 ] = "rbxassetid://138965644048353",
    [ 12 ] = "rbxassetid://134589042471192",
    [ 13 ] = "rbxassetid://112904238202279",
    [ 14 ] = "rbxassetid://114348454129700",
    [ 15 ] = "rbxassetid://135321927887830",
    [ 16 ] = "rbxassetid://79972264058503",
    [ 17 ] = "rbxassetid://130503181612624",
    [ 18 ] = "rbxassetid://89489031633375",
    [ 19 ] = "rbxassetid://89841686749704",
    [ 20 ] = "rbxassetid://86073110915449",
    [ 21 ] = "rbxassetid://82593773760424",
    [ 22 ] = "rbxassetid://112004595268585",
    [ 23 ] = "rbxassetid://99387009517300",
    [ 24 ] = "rbxassetid://99834411313622",
    [ 25 ] = "rbxassetid://102648154910177",
    [ 26 ] = "rbxassetid://128746371407282",
    [ 27 ] = "rbxassetid://133682635641203",
    [ 28 ] = "rbxassetid://82520277772629",
    [ 29 ] = "rbxassetid://78921484152383",
    [ 30 ] = "rbxassetid://123448988808144",
    [ 31 ] = "rbxassetid://98567802551293",
    [ 32 ] = "rbxassetid://90149070768906",
    [ 33 ] = "rbxassetid://80362636620791",
    [ 34 ] = "rbxassetid://111968074313236",
    [ 35 ] = "rbxassetid://120508912988549",
    [ 36 ] = "rbxassetid://110879789658724",
    [ 37 ] = "rbxassetid://109584480055374",
    [ 38 ] = "rbxassetid://114714972261898",
    [ 39 ] = "rbxassetid://121038486193921",
    [ 40 ] = "rbxassetid://92269925901116",
    [ 41 ] = "rbxassetid://138888451633332",
    [ 42 ] = "rbxassetid://102862804856173",
    [ 43 ] = "rbxassetid://125854621011244",
    [ 44 ] = "rbxassetid://75749222903294",
    [ 45 ] = "rbxassetid://136525222690161",
    [ 46 ] = "rbxassetid://139882360501036",
    [ 47 ] = "rbxassetid://81901928311092",
    [ 48 ] = "rbxassetid://119111611297403",
    [ 49 ] = "rbxassetid://136475843735040",
    [ 50 ] = "rbxassetid://99672888395956",
    [ 51 ] = "rbxassetid://110773674916497",
    [ 52 ] = "rbxassetid://77032541282028",
    [ 53 ] = "rbxassetid://102085259973385",
    [ 54 ] = "rbxassetid://98436003442755",
    [ 55 ] = "rbxassetid://121965398319063",
    [ 56 ] = "rbxassetid://91832343420775",
    [ 57 ] = "rbxassetid://136654811366732",
    [ 58 ] = "rbxassetid://107806933071938",
    [ 59 ] = "rbxassetid://132764651469316",
    [ 60 ] = "rbxassetid://103399000214835",
    [ 61 ] = "rbxassetid://130445822710466",
    [ 62 ] = "rbxassetid://91928552078448",
    [ 63 ] = "rbxassetid://82331502131489",
    [ 64 ] = "rbxassetid://135267901799824",
    [ 65 ] = "rbxassetid://90051799998794",
    [ 66 ] = "rbxassetid://71663455585723",
    [ 67 ] = "rbxassetid://98337906963059",
    [ 68 ] = "rbxassetid://119628950286336",
    [ 69 ] = "rbxassetid://73622844045539",
    [ 70 ] = "rbxassetid://137158492228303",
    [ 71 ] = "rbxassetid://97223072801981",
    [ 72 ] = "rbxassetid://100498543381737",
    [ 73 ] = "rbxassetid://101843207937619",
    [ 74 ] = "rbxassetid://103522646694770",
    [ 75 ] = "rbxassetid://78895610479026",
    [ 76 ] = "rbxassetid://130908382245098",
    [ 77 ] = "rbxassetid://98265409883112",
    [ 78 ] = "rbxassetid://110550375350036",
    [ 79 ] = "rbxassetid://96298897585289",
    [ 80 ] = "rbxassetid://106709790273074",
    [ 81 ] = "rbxassetid://108671352739895",
    [ 82 ] = "rbxassetid://94067449008817",
    [ 83 ] = "rbxassetid://114875951744738",
    [ 84 ] = "rbxassetid://103859370725363",
    [ 85 ] = "rbxassetid://137571171882907",
    [ 86 ] = "rbxassetid://101740372756660",
    [ 87 ] = "rbxassetid://100893069096121",
    [ 88 ] = "rbxassetid://101096200163774",
    [ 89 ] = "rbxassetid://99737435254241",
    [ 90 ] = "rbxassetid://77302500380518",
    [ 91 ] = "rbxassetid://116241283809820",
    [ 92 ] = "rbxassetid://117209607243981",
    [ 93 ] = "rbxassetid://133022388336269",
    [ 94 ] = "rbxassetid://97989954237127",
    [ 95 ] = "rbxassetid://115357678400550",
    [ 96 ] = "rbxassetid://123842218020354",
    [ 97 ] = "rbxassetid://139845947297136",
    [ 98 ] = "rbxassetid://84760633057223",
    [ 99 ] = "rbxassetid://85713763819521"
}
local Top100Place = Table.Top100Place
Top100Place[ 100 ] = Table.Top100
local Table2 = { List = Table }
function Table2.Image( Name, Text )
    if Name == "Top100" then
        local Entry2
        local Number = tonumber( Text )

        if Number then
            local Entry = Table.Top100Place[ math.floor( Number ) ]

            if Entry then
                Entry2 = Entry
            else
                Entry2 = Table.Top100
            end
        else
            Entry2 = Table.Top100
        end

        return Entry2
    end
    local Entry6
    local Entry3 = Table[ Name ]

    if type( Entry3 ) == "table" then
        local Entry5
        local Entry4 = Entry3[ Text or 1 ]
        Entry5 = if Entry4 then Entry4 else Entry3[ 1 ]
        Entry6 = Entry5
    else
        Entry6 = Entry3
    end
    if type( Entry6 ) ~= "string" or Entry6 == "" then
        return nil
    end
    return Entry6
end
local Fit = {
    [ Table.Bronze[ 1 ] ] = { 0.4973, 0.522, 0.7625, 0.016, 0.9574 },
    [ Table.Bronze[ 2 ] ] = { 0.4973, 0.568, 0.698, 0.016, 0.9628 },
    [ Table.Bronze[ 3 ] ] = { 0.4973, 0.6186, 0.614, 0.0106, 0.9681 },
    [ Table.Silver[ 1 ] ] = { 0.4973, 0.5251, 0.7659, 0.016, 0.9574 },
    [ Table.Silver[ 2 ] ] = { 0.4973, 0.568, 0.698, 0.016, 0.9628 },
    [ Table.Silver[ 3 ] ] = { 0.4973, 0.6186, 0.614, 0.0106, 0.9681 },
    [ Table.Gold[ 1 ] ] = { 0.4973, 0.5251, 0.7659, 0.016, 0.9574 },
    [ Table.Gold[ 2 ] ] = { 0.4973, 0.568, 0.698, 0.016, 0.9628 },
    [ Table.Gold[ 3 ] ] = { 0.4973, 0.6218, 0.6173, 0.0106, 0.9681 },
    [ Table.Diamond[ 1 ] ] = { 0.4973, 0.5431, 0.6259, 0.0851, 0.8936 },
    [ Table.Diamond[ 2 ] ] = { 0.4973, 0.5715, 0.662, 0.0372, 0.9415 },
    [ Table.Diamond[ 3 ] ] = { 0.4973, 0.6243, 0.6127, 0.0106, 0.9681 },
    [ Table.Ruby[ 1 ] ] = { 0.4973, 0.5329, 0.6945, 0.0585, 0.9255 },
    [ Table.Ruby[ 2 ] ] = { 0.4973, 0.578, 0.6887, 0.016, 0.9681 },
    [ Table.Ruby[ 3 ] ] = { 0.4973, 0.6178, 0.6358, 0.0106, 0.9734 },
    [ Table.Champion[ 1 ] ] = { 0.4976, 0.5276, 0.5983, 0.1156, 0.8684 },
    [ Table.Champion[ 2 ] ] = { 0.4976, 0.571, 0.5991, 0.0829, 0.9065 },
    [ Table.Champion[ 3 ] ] = { 0.4976, 0.6191, 0.5946, 0.031, 0.953 },
    [ Table.Top100 ] = { 0.4973, 0.611, 0.5411, 0.0677, 0.9269 },
    [ Table.Top1 ] = { 0.4973, 0.594, 0.5819, 0.0691, 0.9202 },
    [ Table.Unranked ] = { 0.4973, 0.4764, 0.828, 0.0266, 0.9468 }
}
local Top100Place2 = Table.Top100Place
Value1 = nil

for Key, Value in Top100Place2, nil, nil do
    Fit[ Value ] = Fit[ Table.Top100 ]
end

Table2.Fit = Fit
function Table2.Place( Object, Image )
    if not Object or not Object:IsA( "ImageLabel" ) then
        return
    end

    local Position2, BadgeSize2
    local BadgeCenter = Object:GetAttribute( "BadgeCenter" )
    local BadgeSize = Object:GetAttribute( "BadgeSize" )

    if typeof( BadgeCenter ) ~= "UDim2" or typeof( BadgeSize ) ~= "UDim2" then
        local AnchorPoint = Object.AnchorPoint
        local Position = Object.Position
        local Size = Object.Size
        local UDim22 = UDim2.new( Position.X.Scale + ( 0.5 - AnchorPoint.X ) * Size.X.Scale, Position.X.Offset + ( 0.5 - AnchorPoint.X ) * Size.X.Offset, Position.Y.Scale + ( 0.5 - AnchorPoint.Y ) * Size.Y.Scale, Position.Y.Offset + ( 0.5 - AnchorPoint.Y ) * Size.Y.Offset )
        Object:SetAttribute( "BadgeCenter", UDim22 )
        Object:SetAttribute( "BadgeSize", Size )
        Position2 = UDim22
        BadgeSize2 = Size
    else
        Position2 = BadgeCenter
        BadgeSize2 = BadgeSize
    end
    if Image ~= nil then
        Object.Image = Image
    end

    local Item2
    local Entry = Fit[ Object.Image ]

    if Entry then
        local Item = 0.62 / Entry[ 3 ]

        if Item then
            Item2 = Item
        else
            Item2 = 1
        end
    else
        Item2 = 1
    end

    local AnchorPoint2

    if Entry then
        local Vector22 = Vector2.new( Entry[ 1 ], Entry[ 2 ] )

        if Vector22 then
            AnchorPoint2 = Vector22
        else
            AnchorPoint2 = Vector2.new( 0.5, 0.5 )
        end
    else
        AnchorPoint2 = Vector2.new( 0.5, 0.5 )
    end

    Object.AnchorPoint = AnchorPoint2
    Object.Position = Position2
    Object.Size = UDim2.new( BadgeSize2.X.Scale * Item2, BadgeSize2.X.Offset * Item2, BadgeSize2.Y.Scale * Item2, BadgeSize2.Y.Offset * Item2 )
end
function Table2.Visible( Key )
    local Entry = Fit[ Key ]

    if not Entry or not Entry[ 4 ] or not Entry[ 5 ] then
        return -0.5, 0.5
    end
    local Item = 0.62 / Entry[ 3 ]
    return -( Entry[ 2 ] - Entry[ 4 ] ) * Item, ( Entry[ 5 ] - Entry[ 2 ] ) * Item
end
return Table2
