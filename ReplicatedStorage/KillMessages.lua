-- ReplicatedStorage.KillMessages
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value1
local Table = {
    LANGS = { "en", "fr", "es", "pt", "de", "it" },
    DEFAULT = "Default",
    NO_KILLER = {
        en = "You died",
        fr = "Tu es mort",
        es = "Has muerto",
        pt = "Você morreu",
        de = "Du bist gestorben",
        it = "Sei morto"
    },
    LIST = {
        {
            id = "Default",
            color = Color3.fromRGB( 200, 200, 210 ),
            en = "Killed by {k}",
            fr = "Tué par {k}",
            es = "Eliminado por {k}",
            pt = "Eliminado por {k}",
            de = "Getötet von {k}",
            it = "Ucciso da {k}"
        },
        {
            id = "SoulClaimed",
            color = Color3.fromRGB( 255, 120, 20 ),
            theme = "Halloween",
            en = "{k} claimed your soul",
            fr = "{k} a pris ton âme",
            es = "{k} reclamó tu alma",
            pt = "{k} levou sua alma",
            de = "{k} hat deine Seele geholt",
            it = "{k} si è preso la tua anima"
        },
        {
            id = "DataCorrupted",
            color = Color3.fromRGB( 110, 255, 90 ),
            theme = "Data",
            en = "ErroR 404.. {k} not found!",
            fr = "ErroR 404.. {k} introuvable !",
            es = "ErroR 404.. ¡{k} no encontrado!",
            pt = "ErroR 404.. {k} não encontrado!",
            de = "ErroR 404.. {k} nicht gefunden!",
            it = "ErroR 404.. {k} non trovato!"
        },
        {
            id = "IntoTheVoid",
            color = Color3.fromRGB( 150, 90, 255 ),
            theme = "Void",
            en = "{k} sent you into the void",
            fr = "{k} t'a envoyé dans le vide",
            es = "{k} te mandó al vacío",
            pt = "{k} te mandou para o vazio",
            de = "{k} hat dich ins Nichts geschickt",
            it = "{k} ti ha spedito nel vuoto"
        },
        {
            id = "Sleep",
            color = Color3.fromRGB( 120, 140, 255 ),
            en = "{k} put you to sleep",
            fr = "{k} t'a endormi",
            es = "{k} te mandó a dormir",
            pt = "{k} te fez dormir",
            de = "{k} hat dich schlafen gelegt",
            it = "{k} ti ha messo a nanna"
        },
        {
            id = "Atomized",
            color = Color3.fromRGB( 120, 255, 120 ),
            en = "Atomized by {k}",
            fr = "Atomisé par {k}",
            es = "Atomizado por {k}",
            pt = "Atomizado por {k}",
            de = "Atomisiert von {k}",
            it = "Atomizzato da {k}"
        },
        {
            id = "Deleted",
            color = Color3.fromRGB( 255, 80, 80 ),
            en = "Deleted by {k}",
            fr = "Supprimé par {k}",
            es = "Borrado por {k}",
            pt = "Apagado por {k}",
            de = "Gelöscht von {k}",
            it = "Cancellato da {k}"
        },
        {
            id = "Outplayed",
            color = Color3.fromRGB( 255, 190, 60 ),
            en = "Outplayed by {k}",
            fr = "Surclassé par {k}",
            es = "Superado por {k}",
            pt = "Superado por {k}",
            de = "Ausgespielt von {k}",
            it = "Surclassato da {k}"
        },
        {
            id = "TooEasy",
            color = Color3.fromRGB( 255, 230, 90 ),
            en = "Too easy for {k}",
            fr = "Trop facile pour {k}",
            es = "Demasiado fácil para {k}",
            pt = "Fácil demais para {k}",
            de = "Zu leicht für {k}",
            it = "Troppo facile per {k}"
        },
        {
            id = "SentHome",
            color = Color3.fromRGB( 110, 200, 255 ),
            en = "{k} sent you home",
            fr = "{k} t'a renvoyé chez toi",
            es = "{k} te mandó a casa",
            pt = "{k} te mandou para casa",
            de = "{k} hat dich nach Hause geschickt",
            it = "{k} ti ha rimandato a casa"
        },
        {
            id = "LightsOut",
            color = Color3.fromRGB( 80, 80, 110 ),
            en = "{k} turned your lights off",
            fr = "{k} t'a éteint la lumière",
            es = "{k} te apagó las luces",
            pt = "{k} apagou suas luzes",
            de = "{k} hat dir das Licht ausgeknipst",
            it = "{k} ti ha spento la luce"
        },
        {
            id = "Erased",
            color = Color3.fromRGB( 230, 230, 230 ),
            en = "Erased from the map by {k}",
            fr = "Effacé de la carte par {k}",
            es = "Borrado del mapa por {k}",
            pt = "Varrido do mapa por {k}",
            de = "Von der Karte radiert von {k}",
            it = "Cancellato dalla mappa da {k}"
        },
        {
            id = "Clipped",
            color = Color3.fromRGB( 255, 120, 200 ),
            en = "Clipped by {k}",
            fr = "Clippé par {k}",
            es = "Clipeado por {k}",
            pt = "Clipado por {k}",
            de = "Geclippt von {k}",
            it = "Clippato da {k}"
        },
        {
            id = "Folded",
            color = Color3.fromRGB( 200, 150, 255 ),
            en = "Folded by {k}",
            fr = "Plié par {k}",
            es = "Doblado por {k}",
            pt = "Dobrado por {k}",
            de = "Gefaltet von {k}",
            it = "Piegato da {k}"
        },
        {
            id = "Uninstalled",
            color = Color3.fromRGB( 90, 200, 160 ),
            en = "{k} uninstalled you",
            fr = "{k} t'a désinstallé",
            es = "{k} te desinstaló",
            pt = "{k} te desinstalou",
            de = "{k} hat dich deinstalliert",
            it = "{k} ti ha disinstallato"
        },
        {
            id = "GG",
            color = Color3.fromRGB( 80, 230, 255 ),
            en = "GG, {k} wins",
            fr = "GG, {k} gagne",
            es = "GG, gana {k}",
            pt = "GG, {k} venceu",
            de = "GG, {k} gewinnt",
            it = "GG, vince {k}"
        },
        {
            id = "SkillIssue",
            color = Color3.fromRGB( 255, 150, 90 ),
            en = "Skill issue. Signed {k}",
            fr = "Skill issue. Signé {k}",
            es = "Skill issue. Firmado {k}",
            pt = "Skill issue. Assinado {k}",
            de = "Skill issue. Gezeichnet {k}",
            it = "Skill issue. Firmato {k}"
        },
        {
            id = "ByeBye",
            color = Color3.fromRGB( 255, 200, 220 ),
            en = "Bye bye! — {k}",
            fr = "Bye bye ! — {k}",
            es = "¡Chao! — {k}",
            pt = "Tchau! — {k}",
            de = "Tschüss! — {k}",
            it = "Ciao ciao! — {k}"
        },
        {
            id = "Rekt",
            color = Color3.fromRGB( 255, 60, 140 ),
            en = "Rekt by {k}",
            fr = "Rekt par {k}",
            es = "Rekt por {k}",
            pt = "Rekt por {k}",
            de = "Rekt von {k}",
            it = "Rekt da {k}"
        },
        {
            id = "TooSlow",
            color = Color3.fromRGB( 150, 220, 90 ),
            en = "Too slow for {k}",
            fr = "Trop lent pour {k}",
            es = "Muy lento para {k}",
            pt = "Lento demais para {k}",
            de = "Zu langsam für {k}",
            it = "Troppo lento per {k}"
        },
        {
            id = "Respawn",
            color = Color3.fromRGB( 170, 170, 255 ),
            en = "{k} says: respawn",
            fr = "{k} dit : respawn",
            es = "{k} dice: reaparece",
            pt = "{k} diz: renasça",
            de = "{k} sagt: Respawn",
            it = "{k} dice: rinasci"
        },
        {
            id = "KO",
            color = Color3.fromRGB( 255, 100, 60 ),
            en = "K.O. by {k}",
            fr = "K.O. par {k}",
            es = "K.O. por {k}",
            pt = "Nocaute de {k}",
            de = "K.O. durch {k}",
            it = "K.O. da {k}"
        },
        {
            id = "Boss",
            color = Color3.fromRGB( 255, 215, 0 ),
            en = "The boss {k} got you",
            fr = "Le boss {k} t'a eu",
            es = "El jefe {k} te atrapó",
            pt = "O chefe {k} te pegou",
            de = "Boss {k} hat dich erwischt",
            it = "Il boss {k} ti ha preso"
        },
        {
            id = "NapTime",
            color = Color3.fromRGB( 140, 120, 220 ),
            en = "Nap time, courtesy of {k}",
            fr = "C'est l'heure de la sieste, offert par {k}",
            es = "Hora de la siesta, cortesía de {k}",
            pt = "Hora da soneca, cortesia de {k}",
            de = "Zeit fürs Nickerchen, dank {k}",
            it = "Ora del pisolino, offerto da {k}"
        },
        {
            id = "OneWay",
            color = Color3.fromRGB( 90, 160, 255 ),
            en = "{k} gave you a one-way ticket",
            fr = "{k} t'a offert un aller simple",
            es = "{k} te regaló un boleto de ida",
            pt = "{k} te deu uma passagem só de ida",
            de = "{k} hat dir ein One-Way-Ticket geschenkt",
            it = "{k} ti ha regalato un biglietto di sola andata"
        },
        {
            id = "Hunted",
            color = Color3.fromRGB( 190, 110, 60 ),
            en = "Hunted by {k}",
            fr = "Chassé par {k}",
            es = "Cazado por {k}",
            pt = "Caçado por {k}",
            de = "Gejagt von {k}",
            it = "Cacciato da {k}"
        },
        {
            id = "Smoked",
            color = Color3.fromRGB( 160, 160, 160 ),
            en = "Smoked by {k}",
            fr = "Fumé par {k}",
            es = "Fulminado por {k}",
            pt = "Fulminado por {k}",
            de = "Weggepustet von {k}",
            it = "Fulminato da {k}"
        }
    }
}
local LIST = Table.LIST
table.insert( LIST, 2, {
    id = "Blobbed",
    color = Color3.fromRGB( 100, 200, 255 ),
    theme = "Bubble",
    en = "blobolb {k} bloblob",
    fr = "blobolb {k} bloblob",
    es = "blobolb {k} bloblob",
    pt = "blobolb {k} bloblob",
    de = "blobolb {k} bloblob",
    it = "blobolb {k} bloblob"
} )
Table.ById = { }
local LIST2 = Table.LIST
Value1 = nil

for Key, Value in LIST2, nil, nil do
    local ById = Table.ById
    ById[ Value.id ] = Value
end

function Table.Lang( Argument1 )
    local Match2

    if type( Argument1 ) == "string" then
        local Match = Argument1:lower( ):match( "^(%a%a)" )

        if Match then
            Match2 = Match
        else
            Match2 = "en"
        end
    else
        Match2 = "en"
    end

    local Match3 = ( not table.find( Table.LANGS, Match2 ) or not Match2 ) and "en" or Match2
    return Match3
end
function Table.LocalLang()
    local Result2
    local Success, Result = pcall( function()
        return game:GetService( "LocalizationService" ).RobloxLocaleId
    end )
    local Lang = Table.Lang
    Result2 = Success and Result or "en"
    return Lang( Result2 )
end
function Table.Format( Name, Argument2, Argument3, Callback )
    local Lang = Table.Lang( Argument3 )

    if Argument2 then
        local Entry4
        local Entry3 = Table.ById[ Name or "" ]
        Entry4 = if Entry3 then Entry3 else Table.ById[ Table.DEFAULT ]
        local Entry6
        local Entry5 = Entry4[ Lang ]
        Entry6 = if Entry5 then Entry5 else Entry4.en
        local Value1 = Callback and Callback( Argument2 ) or Argument2
        return ( Entry6:gsub( "{k}", function()
            return Value1
        end ) )
    end
    local Entry2
    local Entry = Table.NO_KILLER[ Lang ]
    Entry2 = if Entry then Entry else Table.NO_KILLER.en
    return Entry2
end
function Table.Escape( Argument1 )
    return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ):gsub( "\"", "&quot;" ):gsub( "'", "&apos;" ) )
end
return Table
