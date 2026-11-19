-- ReplicatedStorage.CrewShared
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table2 = {
    "Night",
    "Shadow",
    "Crimson",
    "Iron",
    "Golden",
    "Silver",
    "Black",
    "Neon",
    "Ghost",
    "Storm",
    "Midnight",
    "Royal",
    "Savage",
    "Street",
    "Urban",
    "Steel",
    "Phantom",
    "Venom",
    "Blaze",
    "Frost",
    "Chrome",
    "Scarlet",
    "Onyx",
    "Thunder"
}
local Table3 = {
    "Wolves",
    "Kings",
    "Saints",
    "Vipers",
    "Jackals",
    "Ravens",
    "Lions",
    "Cobras",
    "Hounds",
    "Reapers",
    "Outlaws",
    "Bandits",
    "Riders",
    "Titans",
    "Phantoms",
    "Syndicate",
    "Legion",
    "Dynasty",
    "Order",
    "Panthers",
    "Sharks",
    "Dragons"
}
local Players = game:GetService( "Players" )
local Table = {
    MAX_MEMBERS = 5,
    INVITE_TIME = 10,
    INVITE_COOLDOWN = 30,
    MAX_PENDING = 3,
    REQUIRE_PASS = true,
    PASS_ID = 2037803497,
    PRICE = 299,
    NAME_MIN = 3,
    NAME_MAX = 20,
    ADJECTIVES = Table2,
    NOUNS = Table3,
    PlayerOf = function( Object )
        if typeof( Object ) ~= "Instance" then
            return nil
        end
        if Object:IsA( "Player" ) then
            return Object
        end
        if Object:IsA( "Model" ) then
            return Players:GetPlayerFromCharacter( Object )
        end
        return nil
    end,
    IdOf = function( Object )
        local PlayerFromCharacter

        if typeof( Object ) == "Instance" then
            if Object:IsA( "Player" ) then
                PlayerFromCharacter = Object
            elseif Object:IsA( "Model" ) then
                PlayerFromCharacter = Players:GetPlayerFromCharacter( Object )
            else
                PlayerFromCharacter = nil
            end
        else
            PlayerFromCharacter = nil
        end

        local CrewId

        if PlayerFromCharacter then
            CrewId = PlayerFromCharacter:GetAttribute( "CrewId" )
        else
            CrewId = PlayerFromCharacter
        end

        local PlayerFromCharacter2 = if type( CrewId ) ~= "number" or not CrewId then nil else CrewId
        return PlayerFromCharacter2
    end
}

local function BotTeam( Object )
    if typeof( Object ) ~= "Instance" or not Object:IsA( "Model" ) or Players:GetPlayerFromCharacter( Object ) then
        return nil
    end
    return Object:GetAttribute( "RankedTeam" )
end

function Table.Same( Object, Object2 )
    local PlayerFromCharacter

    if typeof( Object ) == "Instance" then
        if Object:IsA( "Player" ) then
            PlayerFromCharacter = Object
        elseif Object:IsA( "Model" ) then
            PlayerFromCharacter = Players:GetPlayerFromCharacter( Object )
        else
            PlayerFromCharacter = nil
        end
    else
        PlayerFromCharacter = nil
    end

    local PlayerFromCharacter2

    if typeof( Object2 ) == "Instance" then
        if Object2:IsA( "Player" ) then
            PlayerFromCharacter2 = Object2
        elseif Object2:IsA( "Model" ) then
            PlayerFromCharacter2 = Players:GetPlayerFromCharacter( Object2 )
        else
            PlayerFromCharacter2 = nil
        end
    else
        PlayerFromCharacter2 = nil
    end
    if not PlayerFromCharacter or not PlayerFromCharacter2 then
        local RankedTeam2

        if not PlayerFromCharacter or not PlayerFromCharacter:GetAttribute( "RankedTeam" ) then
            if typeof( Object ) ~= "Instance" or not Object:IsA( "Model" ) or Players:GetPlayerFromCharacter( Object ) then
                RankedTeam2 = nil
            else
                RankedTeam2 = Object:GetAttribute( "RankedTeam" )
            end
        else
            RankedTeam2 = PlayerFromCharacter:GetAttribute( "RankedTeam" )
        end

        local RankedTeam3

        if not PlayerFromCharacter2 or not PlayerFromCharacter2:GetAttribute( "RankedTeam" ) then
            if typeof( Object2 ) ~= "Instance" or not Object2:IsA( "Model" ) or Players:GetPlayerFromCharacter( Object2 ) then
                RankedTeam3 = nil
            else
                RankedTeam3 = Object2:GetAttribute( "RankedTeam" )
            end
        else
            RankedTeam3 = PlayerFromCharacter2:GetAttribute( "RankedTeam" )
        end

        local Flag3

        if RankedTeam2 == nil then
            Flag3 = false
        elseif RankedTeam2 == RankedTeam3 then
            if Object == Object2 then
                Flag3 = false
            else
                Flag3 = true
            end
        else
            Flag3 = false
        end

        return Flag3
    end
    if PlayerFromCharacter == PlayerFromCharacter2 then
        return false
    end

    local RankedTeam = PlayerFromCharacter:GetAttribute( "RankedTeam" )

    if RankedTeam == nil then
        local Flag2
        local IdOf = Table.IdOf( PlayerFromCharacter )

        if IdOf == nil then
            Flag2 = false
        elseif IdOf == Table.IdOf( PlayerFromCharacter2 ) then
            Flag2 = true
        else
            Flag2 = false
        end

        return Flag2
    end
    local Flag = RankedTeam == PlayerFromCharacter2:GetAttribute( "RankedTeam" ) and true or false
    return Flag
end
Table.BANNED_WORDS = {
    "merde",
    "putain",
    "salope",
    "salaud",
    "connard",
    "connasse",
    "conasse",
    "encul",
    "batard",
    "niquer",
    "niktamer",
    "niquetamer",
    "tamere",
    "tapette",
    "gouine",
    "couille",
    "branleur",
    "branlette",
    "enfoire",
    "debile",
    "pouffiasse",
    "petasse",
    "grognasse",
    "trouduc",
    "suceur",
    "suceuse",
    "bougnoul",
    "youpin",
    "negre",
    "bamboula",
    "miboun",
    "fuck",
    "shit",
    "bitch",
    "cunt",
    "pussy",
    "whore",
    "nigg",
    "niqq",
    "asshole",
    "bastard",
    "porn",
    "faggot",
    "motherf",
    "wanker",
    "twat",
    "jizz",
    "dildo",
    "orgasm",
    "blowjob",
    "handjob",
    "hentai",
    "onlyfans",
    "tranny",
    "wetback",
    "beaner",
    "towelhead",
    "swastika",
    "nazi",
    "hitler",
    "retarded",
    "mierda",
    "cabron",
    "pendejo",
    "joder",
    "chinga",
    "culero",
    "maricon",
    "gilipollas",
    "hijueputa",
    "hijodeputa",
    "malparido",
    "mamaguevo",
    "mamahuevo",
    "caralho",
    "buceta",
    "arrombado",
    "fodase",
    "filhodaputa",
    "cazzo",
    "fanculo",
    "stronz",
    "puttana",
    "minchia",
    "coglion",
    "frocio",
    "merda",
    "porcodio",
    "scheis",
    "arschloch",
    "fotze",
    "hurensohn",
    "wichser",
    "schlampe",
    "missgeburt",
    "schwuchtel",
    "ficken",
    "neger",
    "kanker",
    "klootzak",
    "godverdomme",
    "flikker",
    "mongool",
    "kurw",
    "pierdol",
    "pierdal",
    "jebac",
    "jeban",
    "chuj",
    "siktir",
    "sikerim",
    "orospu",
    "yarrak",
    "aminakoy",
    "gavat",
    "хуй",
    "хуе",
    "хуя",
    "хую",
    "пизд",
    "блядь",
    "блять",
    "ебан",
    "мудак",
    "мудил",
    "пидор",
    "пидар",
    "пидр",
    "залуп",
    "гандон",
    "шлюх",
    "долбоеб",
    "blyat",
    "blyad",
    "pizd",
    "nahui",
    "nahuy",
    "mudak",
    "pidor",
    "pidar",
    "شرموط",
    "منيوك",
    "قحب",
    "عرص",
    "متناك",
    "كسمك",
    "sharmout",
    "sharmut",
    "charmout",
    "charmut",
    "nikomak",
    "kosomak",
    "chutiya",
    "chutia",
    "madarchod",
    "maderchod",
    "bhenchod",
    "behenchod",
    "bhosdi",
    "bhosad",
    "bangsat",
    "kontol",
    "memek",
    "ngentot",
    "goblok",
    "jancok",
    "jancuk",
    "操你",
    "傻逼",
    "他妈的",
    "草泥马",
    "鸡巴",
    "婊子",
    "贱人",
    "ちんこ",
    "まんこ",
    "死ね",
    "씨발",
    "시발",
    "병신",
    "개새끼",
    "좆",
    "cocain",
    "xanax",
    "fentanyl",
    "pedophil",
    "pedofil",
    "molest",
    "nsfw",
    "discord",
    "http"
}
Table.BANNED_WHOLE = {
    "pute",
    "putes",
    "conne",
    "connes",
    "con",
    "cons",
    "fdp",
    "ntm",
    "nique",
    "niques",
    "nik",
    "pd",
    "pede",
    "pedes",
    "bite",
    "bites",
    "cul",
    "abruti",
    "abrutis",
    "branle",
    "chatte",
    "chattes",
    "teub",
    "tg",
    "zemel",
    "bicot",
    "raton",
    "mongol",
    "gogol",
    "triso",
    "zebi",
    "zob",
    "fck",
    "fk",
    "fuk",
    "fuq",
    "sht",
    "dick",
    "dicks",
    "slut",
    "sluts",
    "fag",
    "fags",
    "retard",
    "retards",
    "cock",
    "cocks",
    "sex",
    "sexy",
    "sexe",
    "kys",
    "ass",
    "asses",
    "nigga",
    "niggas",
    "nibba",
    "rape",
    "raped",
    "rapist",
    "cum",
    "anal",
    "tits",
    "titty",
    "titties",
    "boob",
    "boobs",
    "penis",
    "nude",
    "nudes",
    "horny",
    "milf",
    "wank",
    "stfu",
    "wtf",
    "kkk",
    "isis",
    "jihad",
    "heil",
    "chink",
    "spic",
    "kike",
    "coon",
    "gook",
    "paki",
    "dyke",
    "homo",
    "lesbo",
    "puta",
    "putas",
    "puto",
    "putos",
    "coño",
    "verga",
    "polla",
    "culo",
    "zorra",
    "marica",
    "pinche",
    "hdp",
    "ctm",
    "porra",
    "cu",
    "foda",
    "foder",
    "viado",
    "corno",
    "vagabunda",
    "vsf",
    "pqp",
    "vtnc",
    "troia",
    "figa",
    "vaffa",
    "hure",
    "nutte",
    "spast",
    "fick",
    "kanake",
    "kut",
    "hoer",
    "lul",
    "tering",
    "tyfus",
    "cipa",
    "kutas",
    "amk",
    "ibne",
    "yarak",
    "сука",
    "суки",
    "бля",
    "ебать",
    "ебал",
    "suka",
    "suki",
    "blya",
    "ebat",
    "xyi",
    "xuy",
    "كس",
    "زب",
    "زبي",
    "طيز",
    "خول",
    "kahba",
    "qahba",
    "zabi",
    "ayre",
    "ayri",
    "manyak",
    "manyok",
    "randi",
    "gaand",
    "lund",
    "bsdk",
    "bkl",
    "lavde",
    "lawde",
    "anjing",
    "asu",
    "tolol",
    "heroin",
    "meth",
    "weed",
    "lsd",
    "www",
    "dsc",
    "pedo",
    "pedos",
    "nig",
    "nigs",
    "nga",
    "ngr",
    "dik",
    "cok",
    "jiz",
    "xxx",
    "prn",
    "fap",
    "kms",
    "thot",
    "vagina",
    "ptn",
    "mdma",
    "thc"
}
Table.BANNED_PHRASES = {
    "ta mere",
    "ta race",
    "ta gueule",
    "nique ta",
    "fils de pute",
    "va te faire",
    "suce ma",
    "kill yourself",
    "kill urself",
    "kill your self",
    "white power",
    "sieg heil",
    "heil hitler",
    "hijo de puta",
    "filho da puta",
    "porco dio",
    "kos omak",
    "nik ommak",
    "كس امك",
    "sale arabe",
    "sale noir",
    "sale noire",
    "sale juif",
    "sale juive",
    "sale renoi",
    "sale blanc",
    "sale chinois",
    "sale gitan",
    "white pride",
    "baise ta"
}
local Table4 = { }

local function SetMany( Argument1, Argument2 )
    for Key, Value in utf8.codes( Argument1 ) do
        Table4[ Value ] = Argument2
    end
end

local function SetPairs( Pairs )
    local Table = { }

    for Key, Value in utf8.codes( Pairs ) do
        table.insert( Table, Value )
    end

    local Count = #Table - 1
    local I = 1

    for I = 1, Count, 2 do
        Table4[ Table[ I ] ] = utf8.char( Table[ I + 1 ] )
    end
end

for Key, Value in utf8.codes( "àáâãäåāăąǎǟǡǻȁȃȧạảấầẩẫậắằẳẵặɑÀÁÂÃÄÅĀĂĄǍǞǠǺȀȂȦẠẢẤẦẨẪẬẮẰẲẴẶ" ) do
    Table4[ Value ] = "a"
end
for Key2, Value2 in utf8.codes( "ƀɓḃḅḇƁḂḄḆ" ) do
    Table4[ Value2 ] = "b"
end
for Key3, Value3 in utf8.codes( "çćĉċčƈÇĆĈĊČƇ" ) do
    Table4[ Value3 ] = "c"
end
for Key4, Value4 in utf8.codes( "ďđɗḋḍḏḑḓðĎĐƊḊḌḎḐḒÐ" ) do
    Table4[ Value4 ] = "d"
end
for Key5, Value5 in utf8.codes( "èéêëēĕėęěȅȇȩẹẻẽếềểễệÈÉÊËĒĔĖĘĚȄȆȨẸẺẼẾỀỂỄỆ" ) do
    Table4[ Value5 ] = "e"
end
for Key6, Value6 in utf8.codes( "ƒḟƑḞ" ) do
    Table4[ Value6 ] = "f"
end
for Key7, Value7 in utf8.codes( "ĝğġģǧǵɡɠĜĞĠĢǦǴ" ) do
    Table4[ Value7 ] = "g"
end
for Key8, Value8 in utf8.codes( "ĥħȟḣḥḧḩḫĤĦȞḢḤḦḨḪ" ) do
    Table4[ Value8 ] = "h"
end
for Key9, Value9 in utf8.codes( "ìíîïĩīĭįıǐȉȋịỉɩÌÍÎÏĨĪĬĮİǏȈȊỊỈ" ) do
    Table4[ Value9 ] = "i"
end
for Key10, Value10 in utf8.codes( "ĵǰĴ" ) do
    Table4[ Value10 ] = "j"
end
for Key11, Value11 in utf8.codes( "ķǩḱḳḵĶǨḰḲḴ" ) do
    Table4[ Value11 ] = "k"
end
for Key12, Value12 in utf8.codes( "ĺļľŀłḷḹḻḽĹĻĽĿŁḶḸḺḼ" ) do
    Table4[ Value12 ] = "l"
end
for Key13, Value13 in utf8.codes( "ḿṁṃḾṀṂ" ) do
    Table4[ Value13 ] = "m"
end
for Key14, Value14 in utf8.codes( "ñńņňŉǹṅṇṉṋÑŃŅŇǸṄṆṈṊ" ) do
    Table4[ Value14 ] = "n"
end
for Key15, Value15 in utf8.codes( "òóôõöøōŏőǒǫȍȏȯọỏốồổỗộớờởỡợơÒÓÔÕÖØŌŎŐǑǪȌȎȮỌỎỐỒỔỖỘỚỜỞỠỢƠ" ) do
    Table4[ Value15 ] = "o"
end
for Key16, Value16 in utf8.codes( "ṕṗṔṖ" ) do
    Table4[ Value16 ] = "p"
end
for Key17, Value17 in utf8.codes( "ŕŗřȑȓṙṛṝṟŔŖŘȐȒṘṚṜṞ" ) do
    Table4[ Value17 ] = "r"
end
for Key18, Value18 in utf8.codes( "śŝşšșſṡṣŚŜŞŠȘṠṢ" ) do
    Table4[ Value18 ] = "s"
end
for Key19, Value19 in utf8.codes( "ţťŧțṫṭṯṱŢŤŦȚṪṬṮṰ" ) do
    Table4[ Value19 ] = "t"
end
for Key20, Value20 in utf8.codes( "ùúûüũūŭůűųǔǖǘǚǜȕȗụủứừửữựưµÙÚÛÜŨŪŬŮŰŲǓǕǗǙǛȔȖỤỦỨỪỬỮỰƯ" ) do
    Table4[ Value20 ] = "u"
end
for Key21, Value21 in utf8.codes( "ṽṿṼṾ" ) do
    Table4[ Value21 ] = "v"
end
for Key22, Value22 in utf8.codes( "ŵẁẃẅẇẉŴẀẂẄẆẈ" ) do
    Table4[ Value22 ] = "w"
end
for Key23, Value23 in utf8.codes( "ẋẍẊẌ" ) do
    Table4[ Value23 ] = "x"
end
for Key24, Value24 in utf8.codes( "ýÿŷȳẏỳỵỷỹÝŸŶȲẎỲỴỶỸ" ) do
    Table4[ Value24 ] = "y"
end
for Key25, Value25 in utf8.codes( "źżžƶẑẓẕŹŻŽƵẐẒẔ" ) do
    Table4[ Value25 ] = "z"
end
for Key26, Value26 in utf8.codes( "æǽÆǼ" ) do
    Table4[ Value26 ] = "ae"
end
for Key27, Value27 in utf8.codes( "œŒ" ) do
    Table4[ Value27 ] = "oe"
end
for Key28, Value28 in utf8.codes( "ßẞ" ) do
    Table4[ Value28 ] = "ss"
end
for Key29, Value29 in utf8.codes( "þÞ" ) do
    Table4[ Value29 ] = "th"
end

SetPairs( "ᴀaʙbᴄcᴅdᴇeꜰfɢgʜhɪiᴊjᴋkʟlᴍmɴnᴏoᴘpʀrꜱsᴛtᴜuᴠvᴡwʏyᴢz" )
SetPairs( "аaвbеeёeкkмmнhоoрpсcтtуyхxѕsіiїiјjӏlԁdԛqԝw" )
SetPairs( "αaβbεeηnιiκkνvοoρpτtυuχxωwζzμuςsγy" )
local Table5 = {
    [ "0" ] = "o",
    [ "1" ] = "i",
    [ "3" ] = "e",
    [ "4" ] = "a",
    [ "5" ] = "s",
    [ "7" ] = "t",
    [ "8" ] = "b",
    [ "@" ] = "a",
    [ "$" ] = "s",
    [ "!" ] = "i",
    [ "|" ] = "i"
}
local Table6 = {
    [ 8364 ] = "e",
    [ 161 ] = "i",
    [ 162 ] = "c",
    [ 165 ] = "y",
    [ 169 ] = "c",
    [ 174 ] = "r"
}
local Table7 = {
    { 173, 173 },
    { 768, 879 },
    { 1155, 1161 },
    { 1425, 1479 },
    { 1552, 1562 },
    { 1600, 1600 },
    { 1611, 1631 },
    { 1648, 1648 },
    { 1750, 1773 },
    { 4447, 4448 },
    { 6155, 6158 },
    { 6832, 6911 },
    { 7616, 7679 },
    { 8203, 8207 },
    { 8234, 8238 },
    { 8288, 8303 },
    { 8400, 8447 },
    { 10240, 10240 },
    { 12644, 12644 },
    { 65024, 65039 },
    { 65056, 65071 },
    { 65279, 65279 },
    { 65440, 65440 },
    { 917504, 917631 }
}
local Table8 = {
    { 160, 191 },
    { 215, 215 },
    { 247, 247 },
    { 1548, 1548 },
    { 1563, 1567 },
    { 1642, 1645 },
    { 8192, 8287 },
    { 8304, 11263 },
    { 11776, 11903 },
    { 12288, 12351 },
    { 65040, 65135 },
    { 57344, 63743 },
    { 126976, 131071 },
    { 983040, 1114111 }
}

local function InRanges( Argument1, List )
    local Value1 = nil

    for Key, Value in List, nil, nil do
        if Value[ 1 ] <= Argument1 then
            if Argument1 <= Value[ 2 ] then
                return true
            end
        end
    end

    return false
end

local function Fancy( Amount )
    local Total2

    if not ( Amount >= 119808 ) or not ( Amount <= 120483 ) then
        if not ( Amount >= 9398 ) or not ( Amount <= 9423 ) then
            if not ( Amount >= 9424 ) or not ( Amount <= 9449 ) then
                if not ( Amount >= 9372 ) or not ( Amount <= 9397 ) then
                    if not ( Amount >= 127462 ) or not ( Amount <= 127487 ) then
                        if not ( Amount >= 127280 ) or not ( Amount <= 127305 ) then
                            if not ( Amount >= 127312 ) or not ( Amount <= 127337 ) then
                                if not ( Amount >= 127344 ) or not ( Amount <= 127369 ) then
                                    Total2 = nil
                                else
                                    Total2 = Amount - 127344
                                end
                            else
                                Total2 = Amount - 127312
                            end
                        else
                            Total2 = Amount - 127280
                        end
                    else
                        Total2 = Amount - 127462
                    end
                else
                    Total2 = Amount - 9372
                end
            else
                Total2 = Amount - 9424
            end
        else
            Total2 = Amount - 9398
        end
    else
        local Total = ( Amount - 119808 ) % 52

        if Total >= 26 then
            Total2 = Total - 26
        else
            Total2 = Total
        end
    end

    local Char2

    if Total2 then
        local Char = string.char( 97 + Total2 )

        if Char then
            Char2 = Char
        else
            Char2 = nil
        end
    else
        Char2 = nil
    end

    return Char2
end

local function Classify( p1 )
    -- Could not structure function #8
end

local function Units( List )
    local Table = { }

    for Key, Value in utf8.codes( List ) do
        table.insert( Table, { Key, Value } )
    end

    local Value1
    local Table2 = { }
    Value1 = nil

    for Key2, Value2 in Table, nil, nil do
        local Item2
        local K, Ch = Classify( Value2[ 2 ] )
        local Table3 = { i = Value2[ 1 ] }

        if Table[ Key2 + 1 ] then
            local Item = Table[ Key2 + 1 ][ 1 ]

            if Item then
                Item2 = Item
            else
                Item2 = #List + 1
            end
        else
            Item2 = #List + 1
        end

        Table3.j = Item2 - 1
        Table3.k = K
        Table3.ch = Ch
        Table2[ Key2 ] = Table3
    end

    return Table2
end

local function SplitWords( List, Argument2 )
    local Value1, Table2
    local Table = { }
    Value1 = nil
    Table2 = nil

    for Key, Value in List, nil, nil do
        if Value.k ~= "L" then
            if not Argument2 or Value.k ~= "T" then
                if Value.k == "I" or not Table2 then
                    continue
                end

                table.insert( Table, Table2 )
                Table2 = nil
                continue
            end
        end

        local Table3 = if Table2 then Table2 else { }
        table.insert( Table3, Key )
        Table2 = Table3
    end
    if Table2 then
        table.insert( Table, Table2 )
    end

    return Table
end

local function MergedShort( List )
    local Value1
    local Table = { }
    local Table2 = { }

    local function Flush()
        if #Table2 >= 2 then
            local Value1
            local TableInner = { }
            Value1 = nil

            for Key, Value in Table2, nil, nil do
                local Value2 = nil

                for Key2, Value3 in Value, nil, nil do
                    table.insert( TableInner, Value3 )
                end
            end

            table.insert( Table, TableInner )
        end

        Table2 = { }
    end

    Value1 = nil

    for Key, Value in List, nil, nil do
        if #Value <= 2 then
            table.insert( Table2, Value )
        else
            Flush( )
        end
    end

    Flush( )
    return Table
end

local function Collapse( List, List2 )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List2, nil, nil do
        local Ch = List[ Value ].ch
        local Entry = Table[ #Table ]

        if not Entry or Entry.ch ~= Ch then
            table.insert( Table, { ch = Ch, a = Value, b = Value, cnt = 1 } )
        else
            local Cnt = Entry.cnt + 1
            Entry.b = Value
            Entry.cnt = Cnt
        end
    end

    local Value2, Number
    local Table2 = { }
    local Table3 = { }
    Value2 = nil
    Number = 0

    for Key2, Value3 in Table, nil, nil do
        table.insert( Table2, Value3.ch )
        local Count = #Value3.ch
        local J = 1

        for J = 1, Count do
            local Number2 = Number + 1
            Table3[ Number2 ] = Key2
            Number = Number2
            Number = Number2
        end
    end

    return table.concat( Table2 ), Table3, Table
end

local function Prep( List )
    local Value1
    local Table = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Value3
        local Units2 = Units( Value )
        local Table2 = { }
        Value3 = nil

        for Key2, Value4 in Units2, nil, nil do
            if Value4.k == "L" or Value4.k == "T" then
                table.insert( Table2, Key2 )
            end
        end

        local Collapse2 = Collapse( Units2, Table2 )

        if Collapse2 ~= "" then
            local Cl
            local Table3 = { s = Collapse2 }
            local Len = utf8.len( Collapse2 )
            Cl = if Len then Len else #Collapse2
            Table3.cl = Cl
            Table3.n = #Table2
            table.insert( Table, Table3 )
        end
    end

    return Table
end

local Value1 = nil

local function Lists()
    if not Value1 then
        Value1 = {
            words = Prep( Table.BANNED_WORDS ),
            whole = Prep( Table.BANNED_WHOLE ),
            phrases = Prep( Table.BANNED_PHRASES )
        }
    end

    return Value1
end

function Table.MaskBanned( Text )
    if type( Text ) ~= "string" or utf8.len( Text ) == nil then
        return "", false
    end
    if not Value1 then
        Value1 = {
            words = Prep( Table.BANNED_WORDS ),
            whole = Prep( Table.BANNED_WHOLE ),
            phrases = Prep( Table.BANNED_PHRASES )
        }
    end

    local Value2
    local Units2 = Units( Text )
    local TableInner = { }

    local function Mark( List, List2 )
        local I = List

        for I = List, List2 do
            TableInner[ I ] = true
        end
    end

    local function Scan( List, List2, List3, Argument4 )
        if #List == 0 then
            return
        end

        local Value4
        local Value1, Value2, Value3 = Collapse( Units2, List )
        Value4 = nil

        for Key, Value in List3, nil, nil do
            if Value1 == Value.s then
                local Count = #List

                if Value.n <= Count then
                    local Item2 = List[ 1 ]
                    local Entry4 = List[ #List ]
                    local J4 = Item2

                    for J4 = Item2, Entry4 do
                        TableInner[ J4 ] = true
                    end

                    return
                end
            end
        end

        local Value5 = nil

        for Key2, Value6 in List2, nil, nil do
            local Number = 1

            while true do
                local Find, Find2 = string.find( Value1, Value6.s, Number, true )

                if not Find then
                    break
                end

                local Number2
                local Entry = Value2[ Find ]
                local Entry2 = Value2[ Find2 ]
                local J = Entry
                Number2 = 0

                for J = Entry, Entry2 do
                    Number2 = Number2 + Value3[ J ].cnt
                end
                if Value6.cl >= 4 or Value6.n <= Number2 then
                    if Argument4 then
                        local Item = List[ 1 ]
                        local Entry3 = List[ #List ]
                        local J2 = Item

                        for J2 = Item, Entry3 do
                            TableInner[ J2 ] = true
                        end

                        return
                    end
                    local A = Value3[ Value2[ Find ] ].a
                    local B = Value3[ Value2[ Find2 ] ].b
                    local J3 = A

                    for J3 = A, B do
                        TableInner[ J3 ] = true
                    end
                end

                Number = Find2 + 1
            end
        end
    end

    local Table2 = { false, true }
    Value2 = nil

    for Key, Value in Table2, nil, nil do
        local Value6
        local SplitWords2 = SplitWords( Units2, Value )
        Value6 = nil

        for Key3, Value7 in SplitWords2, nil, nil do
            local Words2 = Value1.words
            Scan( Value7, Words2, Value1.whole, true )
        end
        for Key4, Value9 in MergedShort( SplitWords2 ) do
            local Words = Value1.words
            Scan( Value9, Words, Value1.whole, true )
        end

        local Value10
        local Table4 = { }
        Value10 = nil

        for Key5, Value11 in SplitWords2, nil, nil do
            local Value12 = nil

            for Key6, Value13 in Value11, nil, nil do
                table.insert( Table4, Value13 )
            end
        end

        Scan( Table4, Value1.phrases, { }, false )
    end

    local Value3, Flag
    local Table3 = { }
    Value3 = nil
    Flag = false

    for Key2, Value4 in Units2, nil, nil do
        if Value4.k ~= "I" then
            if TableInner[ Key2 ] then
                table.insert( Table3, "#" )
                Flag = true
            else
                local I = Value4.i
                table.insert( Table3, ( string.sub( Text, I, Value4.j ) ) )
            end
        end
    end

    return table.concat( Table3 ), Flag
end
return Table
