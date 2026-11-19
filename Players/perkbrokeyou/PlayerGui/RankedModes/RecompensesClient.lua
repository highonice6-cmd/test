-- Players.perkbrokeyou.PlayerGui.RankedModes.RecompensesClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #33

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

return ( tostring( ( math.floor( ( tonumber( Text ) or 0 ) + 0.5 ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( ):gsub( "^,", "" ) )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local Entry = Upvalue1[ Key ]

if Entry then
    Text = Entry
else
    Text = tostring( Key )
end

return Text:sub( 1, 1 ) .. Text:sub( 2 ):lower( )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "Top100" or Name == "Top1" then
    return Upvalue1.Image( Name, Amount )
end
local Image = Upvalue1.Image
return Image( Name, Amount or 1 )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Object:GetChildren( ) do
    if Value:IsA( "UIGradient" ) then
        local Enabled = Value.Name == Captured and true or false

        if Value.Enabled ~= Enabled then
            Value.Enabled = Enabled
        end
    end
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Object:GetChildren( ) do
    if Value:IsA( "UIGradient" ) and Value.Name:sub( 1, #List ) == List then
        local Enabled

        if Captured == nil then
            Enabled = false
        elseif Value.Name == List .. Captured then
            Enabled = true
        else
            Enabled = false
        end
        if Value.Enabled ~= Enabled then
            Value.Enabled = Enabled
        end
    end
end
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Y = Upvalue1.AbsoluteSize.Y

if Y <= 0 then
    return
end

local Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value.TextSize = math.max( 8, ( math.floor( Value:GetAttribute( "TaillePx" ) * Y / 800 + 0.5 ) ) )
end
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

if type( Argument1 ) == "string" then
    local Match, Match2 = Argument1:match( "^(%w+):(%d*)$" )
    return Match, ( tonumber( Match2 ) )
end
return nil
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local RankedCard = Upvalue1:GetAttribute( "RankedCard" )

if type( RankedCard ) ~= "string" or RankedCard == "" then
    return nil
end

local Result2
local Success, Result = pcall( Upvalue2.JSONDecode, Upvalue2, RankedCard )
Result2 = Success and type( Result ) == "table" and Result or nil
return Result2
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Result2
local RankedCard = Upvalue1:GetAttribute( "RankedCard" )

if type( RankedCard ) ~= "string" or RankedCard == "" then
    Result2 = nil
else
    local Success, Result = pcall( Upvalue2.JSONDecode, Upvalue2, RankedCard )

    if not Success or type( Result ) ~= "table" or not Result then
        Result2 = nil
    else
        Result2 = Result
    end
end
if not Result2 then
    return nil, nil, nil, 0
end

local Match, Number
local B = Result2.b

if type( B ) == "string" then
    Match, Match2 = B:match( "^(%w+):(%d*)$" )
    Number = tonumber( Match2 )
else
    Match = nil
    Number = nil
end

local Number2, Match4, Number4

if not Match or not Upvalue3[ Match ] then
    Match4 = nil
    Number4 = nil
    Number2 = nil
else
    Number2 = tonumber( Result2.be )
    Match4 = Match
    Number4 = Number
end

local M = type( Result2.m ) == "table" and Result2.m or { }
local Value1, Number5
Value1 = nil
Number5 = 0

for Key, Value in M, nil, nil do
    if type( Value ) == "table" and not Value.c then
        Number5 = math.max( Number5, tonumber( Value.p ) or 0 )
    end
end

local v52

if type( Result2.m ) == "table" then
    local v5 = Result2.m[ "5v5" ]

    if v5 then
        v52 = v5
    else
        v52 = nil
    end
else
    v52 = nil
end
if type( v52 ) == "table" and v52.c and v52.r then
    local Match3, Number3
    local R = v52.r

    if type( R ) == "string" then
        Match3, Match22 = R:match( "^(%w+):(%d*)$" )
        Number3 = tonumber( Match22 )
    else
        Match3 = nil
        Number3 = nil
    end

    local MinGames2

    if Upvalue4.ClanReward then
        local MinGames = Upvalue4.ClanReward.minGames

        if MinGames then
            MinGames2 = MinGames
        else
            MinGames2 = 0
        end
    else
        MinGames2 = 0
    end
    if Match3 and Upvalue3[ Match3 ] and MinGames2 <= ( tonumber( v52.g ) or 0 ) then
        if Match4 then
            local Entry = Upvalue3[ Match3 ]

            if Upvalue3[ Match4 ] < Entry then
                Number2 = tonumber( v52.e )
                Match4 = Match3
                Number4 = Number3
            end
        else
            Number2 = tonumber( v52.e )
            Match4 = Match3
            Number4 = Number3
        end
    end
end

return Match4, Number4, Number2, Number5
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local SeasonAt = Upvalue1.SeasonAt
local Success, Result = pcall( SeasonAt, ( math.floor( ( workspace:GetServerTimeNow( ) ) ) ) )

if not Success or type( Result ) ~= "table" then
    return nil
end
return Result
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Result2
local SeasonAt = Upvalue1.SeasonAt
local Success, Result = pcall( SeasonAt, ( math.floor( ( workspace:GetServerTimeNow( ) ) ) ) )
Result2 = if not Success or type( Result ) ~= "table" then nil else Result

if not Result2 then
    return "SEASON"
end

local Max2
local Match, Match2 = tostring( Result2.id ):match( "^(%d+)%-(%d+)$" )
local Match3, Match22 = tostring( Upvalue1.FirstSeason or "" ):match( "^(%d+)%-(%d+)$" )

if not Match or not Match3 then
    Max2 = nil
else
    local Max = math.max( 1, ( tonumber( Match ) - tonumber( Match3 ) ) * 12 + tonumber( Match2 ) - tonumber( Match22 ) + 1 )

    if Max then
        Max2 = Max
    else
        Max2 = nil
    end
end

local Format2
local Number = ( tonumber( Result2.endsAt ) or 0 ) - workspace:GetServerTimeNow( )

if Number >= 86400 then
    local Text
    local Number2 = Number // 86400
    Text = Number // 86400 ~= 1 and "S" or ""
    local Format = ( "ENDS IN %d DAY%s" ):format( Number2, Text )

    if Format then
        Format2 = Format
    else
        Format2 = ( "ENDS IN %d H" ):format( ( math.max( 0, Number // 3600 ) ) )
    end
else
    Format2 = ( "ENDS IN %d H" ):format( ( math.max( 0, Number // 3600 ) ) )
end

local Text2 = Max2 and "SEASON " .. Max2 or "SEASON"
return Text2 .. " · " .. Format2
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Result2
local SeasonAt = Upvalue1.SeasonAt
local Success, Result = pcall( SeasonAt, ( math.floor( ( workspace:GetServerTimeNow( ) ) ) ) )
Result2 = if not Success or type( Result ) ~= "table" then nil else Result
local Text2

if Result2 then
    local Text = "RankedRewards_" .. tostring( Result2.id )

    if Text then
        Text2 = Text
    else
        Text2 = nil
    end
else
    Text2 = nil
end

return Text2
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local SeenNotifs = Upvalue1:GetAttribute( "SeenNotifs" )

if type( SeenNotifs ) ~= "string" or not Argument1 then
    return false
end
for Value in SeenNotifs:gmatch( "[^,]+" ) do
    if Value == Argument1 then
        return true
    end
end

return false
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Result2
    local SeasonAt = Upvalue2.SeasonAt
    local Success, Result = pcall( SeasonAt, ( math.floor( ( workspace:GetServerTimeNow( ) ) ) ) )
    Result2 = if not Success or type( Result ) ~= "table" then nil else Result
    local Text2

    if Result2 then
        local Text = "RankedRewards_" .. tostring( Result2.id )

        if Text then
            Text2 = Text
        else
            Text2 = nil
        end
    else
        Text2 = nil
    end

    local Flag
    local SeenNotifs = Upvalue3:GetAttribute( "SeenNotifs" )

    if type( SeenNotifs ) ~= "string" or not Text2 then
        Flag = false
    else
        for Value in SeenNotifs:gmatch( "[^,]+" ) do
            if Value == Text2 then
                Flag = true
                Upvalue1.Visible = not Flag
                return
            end
        end

        Flag = false
    end

    Upvalue1.Visible = not Flag
end
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Result2
local SeasonAt = Upvalue1.SeasonAt
local Success, Result = pcall( SeasonAt, ( math.floor( ( workspace:GetServerTimeNow( ) ) ) ) )
Result2 = if not Success or type( Result ) ~= "table" then nil else Result
local Text2

if Result2 then
    local Text = "RankedRewards_" .. tostring( Result2.id )

    if Text then
        Text2 = Text
    else
        Text2 = nil
    end
else
    Text2 = nil
end
if Upvalue2 then
    Upvalue2.Visible = false
end
if Text2 then
    local Flag
    local SeenNotifs = Upvalue3:GetAttribute( "SeenNotifs" )

    if type( SeenNotifs ) ~= "string" or not Text2 then
        Flag = false
    else
        for Value in SeenNotifs:gmatch( "[^,]+" ) do
            if Value == Text2 then
                Flag = true

                if Flag or not Upvalue4 then
                    return
                end

                Upvalue4:FireServer( Text2 )
                return
            end
        end

        Flag = false
    end
    if not Flag and Upvalue4 then
        Upvalue4:FireServer( Text2 )
    end
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if BadgeName.Image ~= BadgeName2 or not Upvalue1[ BadgeName ] then
    Upvalue1[ BadgeName ] = true
    local Place = Upvalue2.Place
    Place( BadgeName, BadgeName2 or "" )
    return
end
return
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return "locked"
end

local Entry = Upvalue2[ Key ]

if Entry == Upvalue1 then
    return "current"
end
if Upvalue1 < Entry then
    return "locked"
end
return "below"
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Value1, Value2, Value3, Value4 = Upvalue1( )

if Value1 then
    local Entry = Upvalue2[ Value1 ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = nil
    end
else
    Entry2 = nil
end

local Captured

if Upvalue3 then
    Captured = Upvalue3
elseif Value1 then
    Captured = Value1
else
    Captured = "Top1"
end

local function StateOf( Key )
    if not Entry2 then
        return "locked"
    end

    local Entry = Upvalue2[ Key ]

    if Entry == Entry2 then
        return "current"
    end
    if Entry2 < Entry then
        return "locked"
    end
    return "below"
end

local Text = Upvalue4( )

if Upvalue5.Sous.Text ~= Text then
    Upvalue5.Sous.Text = Text
end
if Value1 then
    local Image2
    local Badge = Upvalue6.Badge

    if Value1 == "Top100" or Value1 == "Top1" then
        Image2 = Upvalue7.Image( Value1, Value2 )
    else
        local Image = Upvalue7.Image
        Image2 = Image( Value1, Value2 or 1 )
    end
    if Badge.Image ~= Image2 or not Upvalue8[ Badge ] then
        Upvalue8[ Badge ] = true
        local Place = Upvalue7.Place
        Place( Badge, Image2 or "" )
    end

    local Text2
    local Entry3 = Upvalue9[ Value1 ]

    if Value1 ~= "Top100" or not Value2 or not ( Value2 > 1 ) then
        if Value1 == "Top100" or Value1 == "Top1" or not Value2 then
            Text2 = Entry3
        else
            Text2 = Entry3 .. " " .. ( Upvalue10[ Value2 ] or "" )
        end
    else
        Text2 = Entry3 .. " · #" .. Value2
    end

    local Text4
    Upvalue6.Rang.Text = Text2
    Upvalue11( Upvalue6.Rang, Value1 )
    local Elo = Upvalue6.Elo

    if Value3 then
        local Text3 = Upvalue12( Value3 ) .. " ELO"

        if Text3 then
            Text4 = Text3
        else
            Text4 = ""
        end
    else
        Text4 = ""
    end

    Elo.Text = Text4
else
    local Badge2 = Upvalue6.Badge
    local Image3 = Upvalue7.Image( "Unranked" )

    if Badge2.Image ~= Image3 or not Upvalue8[ Badge2 ] then
        Upvalue8[ Badge2 ] = true
        local Place2 = Upvalue7.Place
        Place2( Badge2, Image3 or "" )
    end

    Upvalue6.Rang.Text = "UNRANKED"
    Upvalue11( Upvalue6.Rang, "Unranked" )
    local Elo2 = Upvalue6.Elo
    Elo2.Text = ( "Placements %d / %d" ):format( math.min( Value4, Upvalue13 ), Upvalue13 )
end

local Image4
Upvalue14( Upvalue5, "Fond_", Captured )
Upvalue14( Upvalue15, "Scene_", Captured )
local Apercu = Upvalue15.Apercu
Apercu.Image = Upvalue16[ Captured ] or ""
local Badge3 = Upvalue15.Badge

if Captured == "Top100" or Captured == "Top1" then
    Image4 = Upvalue7.Image( Captured, nil )
else
    Image4 = Upvalue7.Image( Captured, 1 )
end
if Badge3.Image ~= Image4 or not Upvalue8[ Badge3 ] then
    Upvalue8[ Badge3 ] = true
    local Place3 = Upvalue7.Place
    Place3( Badge3, Image4 or "" )
end

local Text7
local Nom = Upvalue15.Nom
Nom.Text = Upvalue9[ Captured ]
Upvalue11( Upvalue15.Nom, Captured )
local Tag = Upvalue17.Tag
local Text5 = Upvalue18[ Captured ] or "RANK OUTFIT"
Tag.Texte.Text = Text5
Tag.Size = UDim2.fromScale( math.clamp( ( #Text5 * 9.4 + 26 ) / 558, 0.12, 0.7 ), Tag.Size.Y.Scale )
Upvalue14( Tag, "Tag_", Captured )
Upvalue14( Tag.Contour, "Tag_", Captured )
Upvalue11( Tag.Texte, Captured )
local Tenue = Upvalue17.Tenue
Tenue.Text = Upvalue9[ Captured ] .. " OUTFIT"
local Plage = Upvalue17.Plage
Plage.Text = Upvalue19[ Captured ] or ""
Upvalue11( Upvalue17.Plage, Captured )
local Regle = Upvalue17.Regle
local Entry4 = Upvalue20[ Captured ]

if Entry4 then
    Text7 = Entry4
else
    local Text6
    local Entry5 = Upvalue9[ Captured ]

    if Entry5 then
        Text6 = Entry5
    else
        Text6 = tostring( Captured )
    end

    Text7 = ( "Hold %s (%s) when the season ends." ):format( Text6:sub( 1, 1 ) .. Text6:sub( 2 ):lower( ), Upvalue19[ Captured ] or "" )
end

local Entry11
Regle.Text = Text7
local Table = { Upvalue9[ Captured ] .. " CAMO" }
local Entry6 = Upvalue21[ Captured ]
Entry11 = if Entry6 then Entry6 else Upvalue22
local Value5 = nil

for Key, Value in Entry11, nil, nil do
    table.insert( Table, Value )
end

local Parent = Upvalue17.Pieces
local Concat = table.concat( Table, "|" )

if Parent:GetAttribute( "Contenu" ) ~= Concat then
    Parent:SetAttribute( "Contenu", Concat )

    for Key2, Value6 in Parent:GetChildren( ) do
        if Value6:IsA( "GuiObject" ) then
            Value6:Destroy( )
        end
    end

    local Value7 = nil

    for Key3, Value8 in Table, nil, nil do
        local Clone = Upvalue23:Clone( )
        Clone.Name = "Piece" .. Key3
        Clone.LayoutOrder = Key3
        Clone.Texte.Text = Value8
        Clone.Parent = Parent
    end
end

local Text8
local Statut = Upvalue17.Statut

if Entry2 then
    local Entry7 = Upvalue2[ Captured ]

    if Entry7 == Entry2 then
        Text8 = "current"
    elseif Entry2 < Entry7 then
        Text8 = "locked"
    else
        Text8 = "below"
    end
else
    Text8 = "locked"
end

local Visible
local Icone = Statut.Icone
local Etoile = Icone.Etoile
Visible = Text8 == "current" and true or false
local Visible2
Etoile.Visible = Visible
local Cadenas = Icone.Cadenas
Visible2 = Text8 == "locked" and true or false
local Visible3
Cadenas.Visible = Visible2
local Tiret = Icone.Tiret
Visible3 = Text8 == "below" and true or false
Tiret.Visible = Visible3

if Text8 == "current" then
    Statut.BackgroundTransparency = 0.84
    Upvalue14( Statut, "Statut_", Captured )
    Upvalue14( Statut.Accent, "Statut_", Captured )
    Statut.Accent.Transparency = 0.15
    Upvalue11( Icone.Etoile, Captured )
    Statut.Titre.Text = "YOURS IF THE SEASON ENDED NOW"
    local Titre = Statut.Titre
    Titre.TextColor3 = Color3.new( 1, 1, 1 )
    Upvalue11( Statut.Titre, Captured )
    Statut.Texte.Text = "Hold this rank until the season ends to keep the outfit and its camo forever."
else
    local BackgroundTransparency = Text8 ~= "locked" and 0.96 or 0.95
    local Transparency
    Statut.BackgroundTransparency = BackgroundTransparency
    Upvalue14( Statut, "Statut_", nil )
    Upvalue14( Statut.Accent, "Statut_", nil )
    local Accent = Statut.Accent
    Transparency = Text8 ~= "locked" and 0.9 or 0.86
    local TextColor3
    Accent.Transparency = Transparency
    Upvalue11( Statut.Titre, nil )
    local Titre2 = Statut.Titre

    if Text8 == "locked" then
        local FromRGB = Color3.fromRGB( 201, 209, 221 )

        if FromRGB then
            TextColor3 = FromRGB
        else
            TextColor3 = Color3.fromRGB( 154, 164, 181 )
        end
    else
        TextColor3 = Color3.fromRGB( 154, 164, 181 )
    end

    Titre2.TextColor3 = TextColor3

    if Text8 == "locked" then
        local Text9
        Statut.Titre.Text = "LOCKED"

        if Value1 then
            if Captured == "Top1" then
                local Format

                if Value1 == "Top100" then
                    Format = "Climb to #1 of the leaderboard before the season ends."
                else
                    Format = ( "Reach Champion III (%s ELO), then finish #1 of the leaderboard." ):format( Upvalue24 )
                end

                Text9 = Format
            elseif Captured == "Top100" then
                Text9 = ( "Reach Champion III (%s ELO) and finish in the top 100 of the leaderboard." ):format( Upvalue24 )
            else
                local Text10
                local Value9 = Upvalue12( ( math.max( 1, ( Upvalue25[ Captured ] or 0 ) - ( Value3 or 0 ) ) ) )
                local Entry8 = Upvalue9[ Captured ]

                if Entry8 then
                    Text10 = Entry8
                else
                    Text10 = tostring( Captured )
                end

                Text9 = ( "%s ELO to go, then hold %s until the season ends." ):format( Value9, Text10:sub( 1, 1 ) .. Text10:sub( 2 ):lower( ) )
            end
        else
            Text9 = ( "Finish your %d placement matches to get a rank first." ):format( Upvalue13 )
        end

        Statut.Texte.Text = Text9
    else
        local Text11
        Statut.Titre.Text = "ABOVE THIS RANK"
        local Texte = Statut.Texte
        local Entry9 = Upvalue9[ Value1 ]

        if Entry9 then
            Text11 = Entry9
        else
            Text11 = tostring( Value1 )
        end

        Texte.Text = ( "Only the outfit and camo of your final rank are awarded: hold %s to get the %s OUTFIT." ):format( Text11:sub( 1, 1 ) .. Text11:sub( 2 ):lower( ), Upvalue9[ Value1 ] )
    end
end
for Key4, Value10 in Upvalue26:GetChildren( ) do
    local Rang
    local IsA = Value10:IsA( "GuiButton" )

    if IsA then
        Rang = Value10:GetAttribute( "Rang" )
    else
        Rang = IsA
    end
    if Rang then
        local Text12

        if Entry2 then
            local Entry10 = Upvalue2[ Rang ]

            if Entry10 == Entry2 then
                Text12 = "current"
            elseif Entry2 < Entry10 then
                Text12 = "locked"
            else
                Text12 = "below"
            end
        else
            Text12 = "locked"
        end

        local Enabled = Rang == Captured and true or false
        local Visible4
        Value10.Selection.Enabled = Enabled
        Value10.Teinte.Visible = Enabled
        local Toi = Value10.Toi
        Visible4 = Rang == Value1 and true or false
        local Visible5
        Toi.Visible = Visible4
        local Etoile2 = Value10.Icone.Etoile
        Visible5 = Text12 == "current" and true or false
        local Visible6
        Etoile2.Visible = Visible5
        local Cadenas2 = Value10.Icone.Cadenas
        Visible6 = Text12 == "locked" and true or false
        local Visible7
        Cadenas2.Visible = Visible6
        local Tiret2 = Value10.Icone.Tiret
        Visible7 = Text12 == "below" and true or false
        local Visible8
        Tiret2.Visible = Visible7
        local Voile = Value10.Minia.Voile
        Visible8 = Text12 == "locked" and true or false
        Voile.Visible = Visible8
    end
end
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

return require( Upvalue1:WaitForChild( "GamepadNav", 10 ) )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    if Value:IsA( "GuiButton" ) then
        if Value.Selection.Enabled then
            return Value
        end
    end
end

return Upvalue2:FindFirstChild( "Close" )
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( false )
]]

-- Could not structure function #21

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( not Upvalue2.Visible )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2.UIScale, TweenInfo.new( 0.1 ), { Scale = 1.04 } ):Play( )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Create( Upvalue2.UIScale, TweenInfo.new( 0.1 ), { Scale = 1 } ):Play( )
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible == false then
    return
end
if Upvalue2 then
    Upvalue2:Cancel( )
    Upvalue2 = nil
end

Upvalue1.UIScale.Scale = 1
Upvalue1.Visible = false

if Upvalue3 then
    Upvalue3.Close( "RankedRewards" )
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = false
Upvalue2.Enabled = true
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Enabled = true
Upvalue2.Enabled = false
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Visible then
    if Upvalue2.Visible == false then
        return
    end
    if Upvalue3 then
        Upvalue3:Cancel( )
        Upvalue3 = nil
    end

    Upvalue2.UIScale.Scale = 1
    Upvalue2.Visible = false

    if Upvalue4 then
        Upvalue4.Close( "RankedRewards" )
    end
end
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2
Upvalue3( )
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.BackgroundTransparency = 0.92
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.BackgroundTransparency = 0.96
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Visible then
    Upvalue2( )
end
]]
