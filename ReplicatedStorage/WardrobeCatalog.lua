-- ReplicatedStorage.WardrobeCatalog
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    Categories = {
        {
            name = "Hoodies",
            items = {
                { 80990281158103, "Red Hoodie" },
                { 78429715812530, "Pink Bape Hoodie", level = 20 },
                { 118791667339972, "Grey Bape Hoodie" },
                { 18513379473, "Black Zip Hoodie" },
                { 106090934540462, "Black Oversized Hoodie" },
                { 137209219246851, "White BAPE Zip Hoodie + Chain", view = -90 },
                { 114255120765959, "Camo Shark Hoodie" },
                { 98228892901205, "Black Monclizzy Jacket + Hood + CC Chain" },
                { 124582205279296, "Red Monclizzy Jacket + Hoodie + CC Chain" },
                { 95506310961281, "Dark Grey Tech Fleece" },
                { 126619141824688, "White Fur-Hood Jacket" },
                { 82711604844628, "Black Hooded Comfy Puffer Jacket", level = 20 },
                { 79457056256714, "Winter Puffer Jacket Oversized Black", level = 40 },
                { 134630475018656, "Oversized Stylish Puffer Jacket Black", level = 30 },
                { 109561681489132, "Black Puffer Jacket", level = 30 },
                { 122719124930652, "Black Mist Jacket", level = 60 },
                { 86590727591599, "Black Shadow Urban Camo Puffer Jacket", level = 70 },
                { 104643292851689, "Black Y2K Cross Hoodie", level = 40 },
                { 17831917037, "Magical Coat Large Blue", level = 30 },
                { 88702330641282, "Y2K RockStar Purple Hoodie", level = 60 }
            }
        },
        {
            name = "T-shirts / Hauts",
            items = {
                { 18249231739, "White Tank Top" },
                { 120838513298665, "Japanese School Uniform", level = 100 },
                { 140036695541120, "Black Talk Less Do More T-shirt + Chain" },
                { 94810695299819, "Black Bandana Crop Top" },
                { 86043061487761, "Beige Bandana Top" },
                { 116819700842719, "Denim Bandana Top" },
                { 110943787948652, "Glowing Tube Top" },
                { 139823038205739, "Goth Top" },
                { 78197408124497, "Black Goth Corset" },
                { 89866395344616, "Goth Fur Top (Black)" },
                { 118342468338455, "Off-Shoulder Goth Top + Choker" },
                { 83297496945589, "Black Fearless T-shirt + Chain" },
                { 127039551642677, "Black Hellstar T-shirt + Chain" },
                { 99979598403435, "Eternos T-shirt + Cross" },
                { 124628719919824, "Black Svddenly T-shirt + Cross" },
                { 107854720173819, "Black/Red Svddenly T-shirt" },
                { 17399991067, "Cross T-shirt + Gold Chain" },
                { 118789741231674, "Vintage Graphic T-shirt" },
                { 109956447127823, "Green Denim Tears T-shirt" },
                { 110612280278267, "Stussy Flower T-shirt" },
                { 108089786851636, "Layered Goth T-shirt (Black)" },
                { 101617230860952, "Black FRAME Sweater" },
                { 88798717013791, "Punk Tie-Dye Shirt + Chain (Purple)", level = 20 },
                { 83556115312971, "White Fingerless Gloves" },
                { 124308099404146, "White Leather Sleeves + Bandana" },
                { 83595504045614, "Love to Hate Skulls T-shirt (Black)" },
                { 83205293408934, "Black Bulletproof Vest + Gloves", level = 20 },
                { 129782099687287, "Cyber Sigil Y2K Crop Top Tee", level = 20 },
                {
                    117775060272496,
                    "Green Oversized Distressed Layered Shirt",
                    level = 20
                },
                { 119452387769394, "Red Utility Core Longsleeve Top", level = 90 },
                { 80351834206377, "Pumpkin Crop Shoulder Off (Red)", level = 70 }
            }
        },
        {
            name = "Ensemble haut",
            items = {
                { 106126262386508, "Gangster Tactical Jacket Set" },
                { 82917242661627, "White Gangster Tactical Jacket Set" },
                { 90280070061627, "Puffer Jacket + Scarf + Beanie (Pink)" },
                { 128092858583200, "Puffer Jacket + Goggle Balaclava (Yellow)" },
                { 125647941036752, "Black Tech Fleece Puffer + Ski Mask" },
                { 116169392523509, "Monclizzy Jacket" },
                { 135585357838667, "Black Flower Hoodie + Balaclava" },
                { 140212156051847, "Blue Flame Hoodie + Balaclava" }
            }
        },
        {
            name = "Jeans / Pantalons",
            items = {
                { 17399885483, "Three Striped Pants" },
                { 105528352694481, "White Military Pants" },
                { 105138039995374, "White Pants" },
                { 116235430054300, "White Baggy Pants" },
                { 102481743348700, "White Star Streetwear Pants" },
                { 125584467761654, "Pink Ruffled Flared Pants" },
                { 101973856203991, "Pink Ripped Heart Flared Jeans" },
                { 92389641806265, "Pink Buckled Baggy Jeans" },
                { 93484866576001, "Pink Baggy Joggers" },
                { 114964013137946, "Black Joggers" },
                { 90463456858010, "Designer Skinny Jeans" },
                { 104276583741692, "Grey Ripped Skinny Jeans" },
                { 121487284505446, "YN Ripped Jeans" },
                { 110651488161112, "Black Baggy Jeans" },
                { 70487023183832, "Wide Jeans (Black)" },
                { 84009372024030, "Dark Baggy Jeans" },
                { 16076613911, "Y2K Star Baggy Jeans" },
                { 86043943238565, "Baggy Cargo Pants" },
                { 95779470461798, "Chrome Green Pants" },
                { 129407702554570, "Layered Y2K Pants (Green)" },
                { 112021294102547, "Opium-Style Ripped Pants (Yellow)", level = 20 },
                { 126577028923486, "Loose Cyber Sigil Joggers (Yellow)" },
                { 8721985925, "Brown Moto Pants" },
                { 77170519561175, "Brown Y2K Jeans + Plaid Shirt", level = 20 },
                { 115898722747178, "Vintage Newspaper-Print Jeans", level = 20 },
                { 18219930339, "Chestnut Flared Leggings", level = 20 },
                { 90319337034576, "Pink Ruffled Lace Miniskirt", level = 20 },
                { 100251626425085, "White Bow Skirt", level = 20 },
                { 105099925990571, "Black Shorts", level = 20 },
                { 130392485147733, "Y2K Pants", level = 30 },
                { 88113052142050, "Baggiest Track Pants White", level = 50 },
                { 132981364258788, "Y2K Dark Tribal Cyber Baggy Pants", level = 60 },
                { 83465907910326, "Y2K Spider Web Cyber Gothic Pants", level = 80 }
            }
        },
        {
            name = "Ensemble bas",
            items = {
                { 106257440145776, "Pink Oversized Joggers + Shoes" },
                { 109837605892174, "Faded Black Jeans + Boots" },
                { 115128523457940, "Baggy Jeans + Bandana + Shoes" },
                { 78823652285940, "Skull Boxer Baggy Jeans (Black/White) + Sneakers" },
                { 82261294457425, "Skull Boxer Baggy Jeans (White/Black) + Shoes" },
                { 78493892837628, "Denim Tears Baggy Jeans + Timbs" },
                { 80130946298976, "Denim Tears Baggy Jeans + Black Timbs" },
                { 80655175555345, "Hello Kitty Pants + Sneakers" },
                { 94966060471570, "Black Baggy Jorts + Shoes" },
                { 116085390670362, "White Ruffled Skirt + Fur Boots", level = 100 },
                { 72164664040980, "Ruffled Skirt + Fur Boots (Black)" },
                { 119082946575684, "Pink Ruffled Miniskirt + Snow Boots", level = 100 },
                { 88577100381528, "Baggy Black Cyber Dragon Jeans + Shoes", level = 50 },
                {
                    81480241917519,
                    "Green Y2K Baggy Stargirl Jeans + Sneakers",
                    level = 70
                },
                {
                    120100726143139,
                    "Y2K Black Cyber Cargo Sigil Jeans + Shoes",
                    level = 40
                },
                { 75394252348440, "Red Y2K Baggy Cargo Denim + Shoes", level = 70 },
                { 96223478704590, "Orange Distressed Jeans + Shoes", level = 70 }
            }
        },
        {
            name = "Chaussures",
            items = {
                { 191899186664333, "Black Designer Shoes", bundle = true },
                { 12359398333799, "White Y2K Fur Boots", bundle = true },
                {
                    87438994115155,
                    "Platform Loafers + High Socks",
                    bundle = true,
                    level = 100
                },
                { 240425321955961, "Black Jey 4's", bundle = true },
                { 227464358372498, "Black/Red Jey 4's", bundle = true },
                { 124074761270233, "Black/Yellow Jey 4's", bundle = true },
                { 160554657058910, "White/Black Jey 4's", bundle = true },
                { 151797709300499, "Pink Jey 4's", bundle = true },
                { 209131214489768, "Sneakers", bundle = true },
                { 13305235649051, "Black High-Top Sneakers", bundle = true },
                { 13958787026265, "Slides + Red Socks", bundle = true, level = 20 },
                { 239945183255913, "Slides + Black Socks", bundle = true, level = 20 },
                { 99999555457810, "Black Goth Platforms", bundle = true },
                { 62768628824145, "Goth Platforms + Leg Warmers", bundle = true },
                { 165252679840094, "Goth Platforms + Leg Warmers (2)", bundle = true },
                { 128712023562871, "Shoes + White Leg Warmers", bundle = true },
                { 215921038011514, "Pink Knit Shoes", bundle = true, level = 100 },
                { 92831381578370, "Tasman", bundle = true, level = 20 },
                { 126575844973770, "White Fur Boots", bundle = true, level = 20 }
            }
        },
        {
            name = "Cagoules / Masques",
            items = {
                { 86002241591390, "Black Balaclava" },
                { 16110951997, "Rapper Balaclava" },
                { 130607445861197, "Green Balaclava" },
                { 13487195474, "Pink Balaclava" },
                { 120931918726242, "Black Neck Gaiter" },
                { 88267101451090, "White Neck Gaiter" },
                { 122736317120171, "Blue Neck Gaiter" },
                { 87798727522412, "Emo Jester Mask" },
                { 93556455428444, "Black and White Clown Mask" },
                { 17221304438, "Clown Mask", level = 20 },
                { 101069243555567, "Ghostface", level = 20 },
                { 16443711772, "Question Mark Mask" },
                { 16023434542, "Knight in Satin Mask" },
                { 16076333755, "Plague Doctor Mask" },
                { 137523688958944, "Mask" },
                { 89540398015825, "Ghostface (2)", level = 20 }
            }
        },
        {
            name = "Lunettes",
            items = {
                { 109025417276575, "White Ski Goggles (Raised)" },
                { 126012784023142, "Loui Ski Goggles (Sideways)" },
                { 132447033477670, "Sunglasses 1" },
                { 102363544131570, "Sunglasses 2" },
                { 7134338933, "Sunglasses 3" },
                { 130784796690328, "Sunglasses 4" },
                { 14603337710, "Sunglasses 5" },
                { 14543601150, "Sunglasses 6" },
                { 87472340118066, "Sunglasses 7" },
                { 108707094528255, "Raised Ski Goggles + Blue Balaclava", level = 20 },
                { 125812648516616, "Headband Ski Goggles (Black)", level = 20 },
                { 134002090530289, "Striped Headband Ski Goggles", level = 20 },
                { 83640902399823, "Raised Ski Goggles" },
                { 15751956026, "Monogram Headband Ski Goggles" },
                { 87234149470983, "Metal Cyber Y2K Shades", level = 70 }
            }
        },
        {
            name = "Chapeaux / Bonnets",
            items = {
                { 72558563872966, "Black Cowboy Hat", level = 20 },
                { 10473499273, "Cowboy Hat", level = 20 },
                { 17500690164, "Beanie 1" },
                { 98386742249709, "Beanie 2" },
                { 14279552642, "Beanie 3" },
                { 103161363681345, "Blue Y2K Star Beanie" },
                { 138693240884254, "Max Headphones (Black)" },
                { 18956003374, "Pod Headphones" },
                { 95230688839564, "Tactical Helmet + Camera" },
                { 80754571066231, "Star Ushanka (Brown)", level = 20 },
                { 139984582855818, "Red Star Ushanka", level = 20 },
                { 106082546526743, "Y2K Hat", level = 70 },
                { 131692876985723, "Y2K Cyber Sigilism Spiked Cap", level = 60 },
                { 73844613760453, "Black Punk Studded Cap", level = 30 },
                { 75672283460181, "Distressed Yabujin Hat Sideswept", level = 30 },
                { 123965117565015, "Black Vintage Patchwork Bucket Hat", level = 20 },
                { 88195388417506, "Green Y2K Knitted Bunny Hat", level = 60 },
                { 81671763003996, "Green Y2K White Luxury Beanie", level = 80 },
                { 140684463445779, "Orange Y2K Punk Horned Beanie", level = 80 },
                { 131384723030687, "Y2K Orange Silver Flames 6-Panel Cap", level = 60 }
            }
        },
        {
            name = "Cheveux",
            items = {
                { 0, "None", none = true },
                { 72571285585627, "Teige Locs V2" },
                { 87480163941185, "Black Wispy Half-Updo" },
                { 108907317118208, "Purple Punk Hair", level = 100 },
                { 82654338756750, "Black Anime Hair" },
                { 136934073372349, "Spiky Braided Bun (Black)" },
                { 106939751646978, "Messy Emo Hair (Pink)", level = 100 },
                { 120130391987489, "Messy Emo Hair (White)" },
                { 104195009437863, "Vkei Hair" },
                { 81832138595524, "Spiky Vkei Hair (Black)" },
                { 125336103858925, "Layered Vkei Hair (White)", level = 100 },
                { 86520196030405, "Messy Vkei Hair (Red)", level = 100 },
                { 84390569404890, "Wavy Pigtails (Blonde)" },
                { 139770968326574, "Long Anime Hair (Blue)" },
                { 86395073937224, "Vampire Hair (Pastel Purple)", level = 100 },
                { 94145767846033, "Black Hair 1" },
                { 89065813709846, "Black Hair 2" },
                { 15442653160, "Curly Afro (Black)" },
                { 15789807245, "Curly Afro" },
                { 130689163152933, "Locs" },
                { 82030912766202, "Miracle Locs" },
                { 103455256161223, "Messy Locks (Black)" },
                { 114684019398168, "Tied Twisted Locs" },
                { 14784841249, "Curly Locs Bun (Pink)" },
                { 90089878064599, "Dreadlocks" },
                { 14982134096, "Messy Dreadlocks 1" },
                { 14982097542, "Messy Dreadlocks 2" },
                { 13481380032, "Dreadlocks V3" },
                { 119876381171306, "Gothic Emo Hair" },
                { 140589446725333, "Long Curly Emo Hair (Half-Up)" },
                { 81717046789651, "Jay Freeforms (Black)" },
                { 85258715258907, "Jalen Freeforms 1" },
                { 115956344273194, "Jalen Freeforms 2" },
                { 98860389833351, "Quint Up Locs" },
                { 98555362697927, "Black Messy Wavy Emo Bun w Metal Pins", level = 60 },
                { 7193450455, "Curly Afro Black", level = 20 },
                { 18476969407, "Two-Strand Minitwists Black", level = 20 },
                {
                    106355140224980,
                    "Red Ombre Black Messy Anime Hair w Soft Layers",
                    level = 80
                },
                {
                    114954769762855,
                    "Greyish Messy Cute Scene Anime Girl Hair",
                    level = 90
                }
            }
        },
        {
            name = "Maquillage / Tatouages",
            items = {
                { 132472518672598, "Red Skull Face Paint" },
                { 101548573695399, "Red Skull Lips" },
                { 100878292960707, "Gothic Tattoo" },
                { 124672153862971, "Crack Tattoo (Left)" },
                { 71355156182440, "Loyalty Face Tattoos" },
                { 122952248527961, "Eyelashes" },
                { 124479064455308, "Scary Makeup", level = 20 },
                { 134402107663557, "Beard" },
                { 99592535643281, "Half-Skull Makeup" }
            }
        },
        {
            name = "Skins",
            items = {
                {
                    -2001,
                    "Void",
                    skin = "Void",
                    pack = "Void",
                    product = 3726856008,
                    image = "rbxassetid://103007826498985"
                },
                {
                    -2002,
                    "Data",
                    skin = "Data",
                    pack = "Data",
                    product = 3729469447,
                    image = "rbxassetid://76496898775841"
                },
                {
                    -2201,
                    "Diver Suit · Default",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2205,
                    "Diver Suit · Arctic",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2208,
                    "Diver Suit · Coastline Blue",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2209,
                    "Diver Suit · Coastline Orange",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2210,
                    "Diver Suit · Slalom Orange",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2211,
                    "Diver Suit · Slalom Red",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                },
                {
                    -2207,
                    "Diver Suit · Black",
                    family = "Diver",
                    slot = "Costume",
                    body = 985,
                    bodySkin = "Diver",
                    pack = "Bubble",
                    product = 3730917157,
                    image = "rbxassetid://77881819101967",
                    with = { 103484523719542, 128587042212490, 134658872345303, 8719997624 }
                }
            }
        },
        {
            name = "Ensemble tête",
            items = {
                { 110263426620528, "Dreads + Camo Hat + Headphones", level = 50 },
                {
                    139899024092854,
                    "Wispy Messy Green Black Waves w Ushanka",
                    level = 90
                }
            }
        },
        { name = "Event", items = { } },
        { name = "Mods", items = { } }
    },
    Groups = {
        {
            "Cheveux",
            "Chapeaux / Bonnets",
            "Ensemble tête",
            "Lunettes",
            "Cagoules / Masques",
            "Maquillage / Tatouages"
        },
        { "T-shirts / Hauts", "Hoodies", "Ensemble haut" },
        { "Jeans / Pantalons", "Ensemble bas", "Chaussures" },
        { "Skins", "Event" },
        { "Mods" }
    },
    Single = {
        [ "Ensemble haut" ] = true,
        [ "Ensemble bas" ] = true,
        [ "Ensemble tête" ] = true,
        Mods = true
    }
}
local Table2 = {
    "Cheveux",
    "Chapeaux / Bonnets",
    "Lunettes",
    "Cagoules / Masques",
    "T-shirts / Hauts",
    "Hoodies",
    "Jeans / Pantalons",
    "Chaussures",
    "Sacs à dos"
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    Table.Single[ Value ] = true
end

local Value2
Table.Excludes = {
    [ "Ensemble haut" ] = { "Cagoules / Masques", "T-shirts / Hauts", "Hoodies" },
    [ "Ensemble bas" ] = { "Chaussures", "Jeans / Pantalons" },
    [ "Ensemble tête" ] = { "Cheveux", "Chapeaux / Bonnets" }
}
Table.Excludes.Mods = { }
local Categories = Table.Categories
Value2 = nil

for Key2, Value3 in Categories, nil, nil do
    if Value3.name ~= "Mods" then
        local Mods2 = Table.Excludes.Mods
        table.insert( Mods2, Value3.name )
    end

    local Value18
    local Items2 = Value3.items
    Value18 = nil

    for Key10, Value19 in Items2, nil, nil do
        if Value19.slot and not table.find( Table.Excludes.Mods, Value19.slot ) then
            local Mods3 = Table.Excludes.Mods
            table.insert( Mods3, Value19.slot )
        end
    end
end

local Value4
Table.Single.Event = true
Table.Excludes.Event = { "Mods" }
local Mods = Table.Excludes.Mods
Value4 = nil

for Key3, Value5 in Mods, nil, nil do
    if Value5 ~= "Event" then
        table.insert( Table.Excludes.Event, Value5 )
    end
end

Table.RuleTexts = {
    Mods = "Mods outfit: only one, nothing else with it",
    Event = "Event outfit: only one, nothing else with it"
}
local Find = table.find( Table.Excludes.Mods, "Skins" )

if Find then
    table.remove( Table.Excludes.Mods, Find )
end

local Value6
Table.Single.Skins = true
Table.Excludes.Skins = { "Event" }
Table.RuleTexts.Skins = "Skin: only one, not with an Event outfit"
Table.Single.Ranked = true
local Excludes = Table.Excludes
Excludes.Ranked = table.clone( Table.Excludes.Event )
table.insert( Table.Excludes.Ranked, "Event" )
local Table3 = { "Event", "Mods", "Skins" }
Value6 = nil

for Key4, Value7 in Table3, nil, nil do
    table.insert( Table.Excludes[ Value7 ], "Ranked" )
end

local Value8
Table.RuleTexts.Ranked = "Ranked outfit: only one, nothing else with it"
Table.Single.Costume = true
local Excludes2 = Table.Excludes
Excludes2.Costume = table.clone( Table.Excludes.Ranked )
table.insert( Table.Excludes.Costume, "Ranked" )
local Table4 = { "Event", "Mods", "Skins", "Ranked" }
Value8 = nil

for Key5, Value9 in Table4, nil, nil do
    table.insert( Table.Excludes[ Value9 ], "Costume" )
end

local Value10
Table.RuleTexts.Costume = "Full outfit: only one, nothing else with it"
local Excludes3 = Table.Excludes
Value10 = nil

for Key6, Value11 in Excludes3, nil, nil do
    local Value16
    local Table5 = { }
    local Table6 = { }
    Value16 = nil

    for Key9, Value17 in Value11, nil, nil do
        if Value17 ~= Key6 and not Table5[ Value17 ] then
            Table5[ Value17 ] = true
            table.insert( Table6, Value17 )
        end
    end

    Table.Excludes[ Key6 ] = Table6
end

local Value12
Table.Families = {
    GrimReaper = {
        name = "Grim Reaper",
        styles = {
            {
                id = -1001,
                name = "Classic",
                unlock = "Halloween event, tier 1",
                need = "TIER 1",
                image = "rbxassetid://93282351588530",
                frame = 1
            },
            {
                id = -1002,
                name = "Shadow",
                unlock = "Halloween event, tier 2",
                need = "TIER 2",
                image = "rbxassetid://107707428595108",
                frame = 1.106
            },
            {
                id = -1003,
                name = "Inverted",
                unlock = "Halloween event, tier 3",
                need = "TIER 3",
                image = "rbxassetid://113991241795047",
                frame = 1.083
            }
        }
    },
    Diver = {
        name = "Diver Suit",
        vertical = true,
        title = "COLOR",
        styles = {
            {
                id = -2201,
                name = "Default",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 12, 42, 65 }
            },
            {
                id = -2205,
                name = "Arctic",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 181, 184, 189 }
            },
            {
                id = -2208,
                name = "Coastline Blue",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 24, 24, 24 },
                swatch2 = { 24, 136, 248 }
            },
            {
                id = -2209,
                name = "Coastline Orange",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 24, 40, 56 },
                swatch2 = { 248, 136, 24 }
            },
            {
                id = -2210,
                name = "Slalom Orange",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 24, 24, 24 },
                swatch2 = { 248, 104, 24 }
            },
            {
                id = -2211,
                name = "Slalom Red",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 168, 24, 24 },
                swatch2 = { 248, 248, 248 }
            },
            {
                id = -2207,
                name = "Black",
                unlock = "Bubble Pack",
                need = "BUBBLE PACK",
                swatch = { 8, 8, 8 }
            }
        }
    }
}
Table.Labels = {
    Corps = "Body",
    Cheveux = "Hair",
    [ "Chapeaux / Bonnets" ] = "Hats",
    Lunettes = "Glasses",
    [ "Cagoules / Masques" ] = "Masks",
    [ "Maquillage / Tatouages" ] = "Makeup",
    [ "T-shirts / Hauts" ] = "Tops",
    Hoodies = "Hoodies",
    [ "Ensemble haut" ] = "Top Sets",
    [ "Jeans / Pantalons" ] = "Pants",
    [ "Ensemble bas" ] = "Bottom Sets",
    [ "Ensemble tête" ] = "Head Sets",
    Chaussures = "Shoes",
    Mods = "Mods",
    Event = "Event",
    Skins = "Skins",
    [ "Sacs à dos" ] = "Backpacks",
    Ranked = "Ranked outfit",
    Costume = "Full outfit"
}
function Table.Label( Key )
    return Table.Labels[ Key ] or Key
end

local function CategoryOf( Key )
    local Entry2
    local Entry = Table.Items[ Key ]

    if Entry then
        local Slot = Entry.slot

        if Slot then
            Entry2 = Slot
        else
            Entry2 = Entry.category
        end
    else
        Entry2 = Entry
    end

    return Entry2
end

function Table.BlockedBy( List, Key )
    local Entry6
    local Entry = Table.Items[ Key ]

    if Entry then
        local Slot = Entry.slot

        if Slot then
            Entry6 = Slot
        else
            Entry6 = Entry.category
        end
    else
        Entry6 = Entry
    end

    local Value1 = nil

    for Key2, Value in List, nil, nil do
        local Entry3
        local Entry2 = Table.Items[ Value ]

        if Entry2 then
            local Slot2 = Entry2.slot

            if Slot2 then
                Entry3 = Slot2
            else
                Entry3 = Entry2.category
            end
        else
            Entry3 = Entry2
        end

        local Entry5

        if Entry3 then
            local Entry4 = Table.Excludes[ Entry3 ]

            if Entry4 then
                Entry5 = Entry4
            else
                Entry5 = { }
            end
        else
            Entry5 = { }
        end

        local Value2 = nil

        for Key3, Value3 in Entry5, nil, nil do
            if Value3 == Entry6 then
                if Value ~= Key then
                    return Entry3
                end
            end
        end
    end

    return nil
end
function Table.RuleText( TextName )
    if TextName and Table.RuleTexts[ TextName ] then
        return Table.RuleTexts[ TextName ]
    end
    if TextName then
        if Table.Single[ TextName ] or Table.Excludes[ TextName ] then
            local TableInner = { }

            if Table.Single[ TextName ] then
                table.insert( TableInner, "one piece only" )
            end

            local Entry = Table.Excludes[ TextName ]

            if Entry and #Entry > 0 then
                local Value1
                local Table2 = { }
                Value1 = nil

                for Key, Value in Entry, nil, nil do
                    table.insert( Table2, Table.Label( Value ):lower( ) )
                end

                table.insert( TableInner, "no " .. table.concat( Table2, " or " ) )
            end

            local Label = Table.Label( TextName )
            return Label .. ": " .. table.concat( TableInner, ", " )
        end
    end

    return nil
end
function Table.Clean( List )
    local Value1
    local TableInner = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Entry8
        local Entry7 = Table.Items[ Value ]

        if Entry7 then
            local Slot3 = Entry7.slot

            if Slot3 then
                Entry8 = Slot3
            else
                Entry8 = Entry7.category
            end
        else
            Entry8 = Entry7
        end
        if Entry8 and Table.Single[ Entry8 ] then
            TableInner[ Entry8 ] = Key
        end
    end

    local Value2
    local Table2 = { }
    local Table3 = { }
    Value2 = nil

    for Key2, Value3 in List, nil, nil do
        local Entry6
        local Entry5 = Table.Items[ Value3 ]

        if Entry5 then
            local Slot2 = Entry5.slot

            if Slot2 then
                Entry6 = Slot2
            else
                Entry6 = Entry5.category
            end
        else
            Entry6 = Entry5
        end
        if not Entry6 or not Table.Single[ Entry6 ] or TableInner[ Entry6 ] == Key2 then
            table.insert( Table2, Value3 )

            if Entry6 then
                Table3[ Entry6 ] = true
            end
        end
    end

    local Value4
    local Table4 = { }
    Value4 = nil

    for Value5 in Table3, nil, nil do
        local Entry4
        local Entry3 = Table.Excludes[ Value5 ]
        Entry4 = if Entry3 then Entry3 else { }
        local Value8 = nil

        for Key4, Value9 in Entry4, nil, nil do
            Table4[ Value9 ] = true
        end
    end

    local Value6
    local Table5 = { }
    Value6 = nil

    for Key3, Value7 in Table2, nil, nil do
        local Entry2
        local Entry = Table.Items[ Value7 ]

        if Entry then
            local Slot = Entry.slot

            if Slot then
                Entry2 = Slot
            else
                Entry2 = Entry.category
            end
        else
            Entry2 = Entry
        end
        if not Table4[ Entry2 or "" ] then
            table.insert( Table5, Value7 )
        end
    end

    return Table5
end
Table.Defaults = {
    Male = { 18249231739, 17399885483, 72571285585627 },
    Female = { 18249231739, 17399885483, 87480163941185 }
}
Table.DefaultBodies = { Male = 993, Female = 994 }
Table.Required = {
    {
        label = "top",
        cats = {
            "T-shirts / Hauts",
            "Hoodies",
            "Ensemble haut",
            "Mods",
            "Event",
            "Ranked",
            "Costume"
        }
    },
    {
        label = "pants",
        cats = {
            "Jeans / Pantalons",
            "Ensemble bas",
            "Mods",
            "Event",
            "Ranked",
            "Costume"
        }
    },
    {
        label = "hair",
        cats = { "Cheveux", "Ensemble tête", "Mods", "Event", "Ranked", "Costume" }
    }
}
function Table.MissingRequired( List )
    local Value1
    local TableInner = { }
    Value1 = nil

    for Key, Value in List, nil, nil do
        local Entry = Table.Items[ Value ]

        if Entry then
            local Slot2
            local Slot = Entry.slot
            Slot2 = if Slot then Slot else Entry.category
            TableInner[ Slot2 ] = true
        end
    end

    local Value2
    local Required = Table.Required
    Value2 = nil

    for Key2, Value3 in Required, nil, nil do
        local Value4, Flag
        local Cats = Value3.cats
        Value4 = nil

        for Key3, Value5 in Cats, nil, nil do
            if TableInner[ Value5 ] then
                Flag = true
                break
            end

            Flag = false
        end
        if not Flag then
            return Value3
        end
    end

    return nil
end
function Table.WithDefaults( Argument1, DefaultsName )
    local Entry3
    local Clone = table.clone( Argument1 )
    local Entry = Table.Defaults[ DefaultsName ]
    Entry3 = if Entry then Entry else Table.Defaults.Male
    local Count = #Table.Required
    local I = 1

    for I = 1, Count do
        local MissingRequired = Table.MissingRequired( Clone )

        if not MissingRequired then
            break
        end

        local Value1, Flag
        Value1 = nil

        for Key, Value in Entry3, nil, nil do
            local Entry2 = Table.Items[ Value ]

            if Entry2 then
                if table.find( MissingRequired.cats, Entry2.category ) then
                    table.insert( Clone, Value )
                    Flag = true
                    break
                end
            end

            Flag = false
        end
        if not Flag then
            break
        end
    end

    return Clone
end
Table.Items = { }

local function AddItem( Value, List )
    local Bundle
    local Items = Table.Items
    local Item = List[ 1 ]
    local TableInner = { name = List[ 2 ] }
    Bundle = List.bundle == true and true or false
    local Admin
    TableInner.bundle = Bundle
    TableInner.category = Value.name
    TableInner.view = List.view
    TableInner.with = List.with
    TableInner.body = List.body
    TableInner.scale = List.scale
    TableInner.height = List.height
    TableInner.head = List.head
    Admin = List.admin == true and true or false
    local Creators
    TableInner.admin = Admin
    Creators = List.creators == true and true or false
    local None
    TableInner.creators = Creators
    TableInner.slot = List.slot
    TableInner.level = List.level
    None = List.none == true and true or false
    local AdminRole
    TableInner.none = None
    AdminRole = List.adminRole == true and true or false
    local Plain
    TableInner.adminRole = AdminRole
    TableInner.asset = List.asset
    TableInner.fx = List.fx
    Plain = List.plain == true and true or false
    local Devs
    TableInner.plain = Plain
    TableInner.color = List.color
    TableInner.image = List.image
    TableInner.event = List.event
    TableInner.tier = List.tier
    TableInner.family = List.family
    TableInner.skin = List.skin
    TableInner.pack = List.pack
    TableInner.product = List.product
    TableInner.bodySkin = List.bodySkin
    TableInner.rank = List.rank
    TableInner.print = List.print
    TableInner.users = List.users
    Devs = List.devs == true and true or false
    TableInner.devs = Devs
    TableInner.bodyType = List.bodyType
    TableInner.proportion = List.proportion
    TableInner.skinColor = List.skinColor
    Items[ Item ] = TableInner
end

local Categories2 = Table.Categories
Value12 = nil

for Key7, Value13 in Categories2, nil, nil do
    local Value14
    local Items = Value13.items
    Value14 = nil

    for Key8, Value15 in Items, nil, nil do
        AddItem( Value13, Value15 )
    end
end

function Table.AddPrivate( Private )
    if type( Private ) ~= "table" then
        return
    end

    local Value1
    local Categories = Table.Categories
    Value1 = nil

    for Key, Value in Categories, nil, nil do
        local Entry = Private[ Value.name ]

        if type( Entry ) == "table" then
            local Value2 = nil

            for Key2, Value3 in Entry, nil, nil do
                local Table2

                if type( Value3 ) ~= "table" or type( Value3.id ) ~= "number" or type( Value3.name ) ~= "string" then
                    Table2 = Value3
                else
                    local Value4
                    local TableInner = { Value3.id, Value3.name }
                    Value4 = nil

                    for Key3, Value5 in Value3, nil, nil do
                        if Key3 ~= "id" and Key3 ~= "name" then
                            TableInner[ Key3 ] = Value5
                        end
                    end

                    Table2 = TableInner
                end
                if type( Table2 ) == "table" and type( Table2[ 1 ] ) == "number" and type( Table2[ 2 ] ) == "string" and not Table.Items[ Table2[ 1 ] ] then
                    table.insert( Value.items, Table2 )
                    AddItem( Value, Table2 )
                    Table.Items[ Table2[ 1 ] ].private = true
                end
            end
        end
    end
end

if game:GetService( "RunService" ):IsServer( ) then
    local Success, Result = pcall( function()
        local WardrobePrivate2
        local WardrobePrivate = game:GetService( "ServerStorage" ):FindFirstChild( "WardrobePrivate" )
        WardrobePrivate2 = if WardrobePrivate then require( WardrobePrivate ) else WardrobePrivate
        return WardrobePrivate2
    end )

    if Success then
        Table.AddPrivate( Result )
    end
end

function Table.LockedLevel( LevelName, Text )
    local Entry2
    local Entry = Table.Items[ LevelName ]
    Entry2 = if Entry then Entry.level else Entry

    if not Entry2 or not ( ( tonumber( Text ) or 1 ) < Entry2 ) then
        return nil
    end
    return Entry2
end
return Table
