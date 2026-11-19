-- ReplicatedStorage.Regions
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = { }
local Table2 = { }
local Table3 = {
    NA = {
        "US",
        "CA",
        "MX",
        "GT",
        "BZ",
        "SV",
        "HN",
        "NI",
        "CR",
        "PA",
        "CU",
        "DO",
        "HT",
        "JM",
        "PR",
        "BS",
        "BB",
        "TT",
        "AG",
        "DM",
        "GD",
        "KN",
        "LC",
        "VC",
        "AW",
        "CW",
        "BM",
        "KY",
        "TC",
        "VG",
        "VI",
        "GP",
        "MQ",
        "PM",
        "BL",
        "MF",
        "SX",
        "BQ",
        "AI",
        "MS"
    },
    SA = {
        "BR",
        "AR",
        "CL",
        "CO",
        "PE",
        "VE",
        "EC",
        "BO",
        "PY",
        "UY",
        "GY",
        "SR",
        "GF",
        "FK"
    },
    AS = {
        "JP",
        "KR",
        "TW",
        "HK",
        "MO",
        "CN",
        "MN",
        "PH",
        "SG",
        "MY",
        "BN",
        "ID",
        "TL",
        "TH",
        "VN",
        "KH",
        "LA",
        "MM",
        "IN",
        "PK",
        "BD",
        "LK",
        "NP",
        "BT",
        "MV"
    },
    OC = {
        "AU",
        "NZ",
        "NC",
        "PF",
        "WF",
        "FJ",
        "PG",
        "VU",
        "SB",
        "WS",
        "AS",
        "TO",
        "KI",
        "TV",
        "NR",
        "MH",
        "FM",
        "PW",
        "GU",
        "MP",
        "CK",
        "NU",
        "TK",
        "NF",
        "PN"
    }
}
Value1 = nil

for Key, Value in Table3, nil, nil do
    local Value2 = nil

    for Key2, Value3 in Value, nil, nil do
        Table2[ Value3 ] = Key
    end
end

Table.List = { EU = true, NA = true, SA = true, AS = true, OC = true }
function Table.Of( Key )
    return Table2[ Key ] or "EU"
end
Table.Small = { SA = true, AS = true, OC = true }
Table.Near = { OC = { AS = true }, AS = { OC = true }, SA = { NA = true } }
return Table
