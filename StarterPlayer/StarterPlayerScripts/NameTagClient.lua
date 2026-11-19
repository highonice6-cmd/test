-- StarterPlayer.StarterPlayerScripts.NameTagClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local Table = { }
local Value1 = nil
local Value2 = nil
local Number = 0
local Number2 = -1
RunService.RenderStepped:Connect( function( Amount )
    local NameTag
    local Character = LocalPlayer.Character

    if Character then
        NameTag = Character:FindFirstChild( "NameTag" )
    else
        NameTag = Character
    end

    local Nom

    if NameTag then
        Nom = NameTag:FindFirstChild( "Nom" )
    else
        Nom = NameTag
    end
    if not Nom then
        return
    end
    if Table[ Nom ] == nil then
        table.clear( Table )
        Table[ Nom ] = Nom.TextTransparency
    end

    local Base = Nom:GetAttribute( "Base" )

    if type( Base ) == "number" then
        Table[ Nom ] = Base
    end

    local NumberInner = if ClientState.Aiming then 1 else Table[ Nom ]
    local TextTransparency2
    local Result = Amount / 0.12 * ( 1 - Table[ Nom ] )
    local TextTransparency = Nom.TextTransparency

    if TextTransparency < NumberInner then
        TextTransparency2 = math.min( TextTransparency + Result, NumberInner )
    elseif NumberInner < TextTransparency then
        TextTransparency2 = math.max( TextTransparency - Result, NumberInner )
    else
        TextTransparency2 = TextTransparency
    end

    Nom.TextTransparency = TextTransparency2
    local VipStroke = Nom:FindFirstChild( "VipStroke" )
    local Reflet = Nom:FindFirstChild( "Reflet" )

    if VipStroke or Reflet then
        if Nom ~= Value2 then
            local Transparency = VipStroke and VipStroke.Transparency or 0
            Value2 = Nom
            Number = Transparency
            Number2 = -1
        end

        local TextTransparency3
        local Entry = Table[ Nom ]

        if Entry < 1 then
            local Clamp = math.clamp( ( TextTransparency2 - Entry ) / ( 1 - Entry ), 0, 1 )

            if Clamp then
                TextTransparency3 = Clamp
            else
                TextTransparency3 = 1
            end
        else
            TextTransparency3 = 1
        end
        if TextTransparency3 ~= Number2 then
            Number2 = TextTransparency3

            if VipStroke then
                VipStroke.Transparency = Number + ( 1 - Number ) * TextTransparency3
            end
            if Reflet then
                Reflet.TextTransparency = TextTransparency3
            end
        end
    end

    local Plate = NameTag:FindFirstChild( "Plate" )

    if Plate then
        if not Value1 or Value1.plate ~= Plate then
            local UIStroke2
            local UIStroke = Plate:FindFirstChildOfClass( "UIStroke" )
            local Tag = Plate:FindFirstChild( "Tag" )

            if Tag then
                UIStroke2 = Tag:FindFirstChildOfClass( "UIStroke" )
            else
                UIStroke2 = Tag
            end

            local StT
            local TableInner = {
                plate = Plate,
                st = UIStroke,
                tag = Tag,
                ts = UIStroke2,
                bg = Plate.BackgroundTransparency,
                f = 0
            }
            StT = if UIStroke then UIStroke.Transparency else UIStroke
            local Tt
            TableInner.stT = StT
            Tt = if Tag then Tag.TextTransparency else Tag
            local TsT
            TableInner.tt = Tt
            TsT = if UIStroke2 then UIStroke2.Transparency else UIStroke2
            local Rf
            TableInner.tsT = TsT
            Rf = if Tag then Tag:FindFirstChild( "Reflet" ) else Tag
            TableInner.rf = Rf
            Value1 = TableInner
        end

        local F
        local Entry2 = Table[ Nom ]

        if Entry2 < 1 then
            local Clamp2 = math.clamp( ( TextTransparency2 - Entry2 ) / ( 1 - Entry2 ), 0, 1 )

            if Clamp2 then
                F = Clamp2
            else
                F = 1
            end
        else
            F = 1
        end
        if F ~= Value1.f then
            Value1.f = F
            Plate.BackgroundTransparency = Value1.bg + ( 1 - Value1.bg ) * F

            if Value1.st then
                local St = Value1.st
                St.Transparency = Value1.stT + ( 1 - Value1.stT ) * F
            end
            if Value1.tag then
                local Tag2 = Value1.tag
                Tag2.TextTransparency = Value1.tt + ( 1 - Value1.tt ) * F
            end
            if Value1.ts then
                local Ts = Value1.ts
                Ts.Transparency = Value1.tsT + ( 1 - Value1.tsT ) * F
            end
            if Value1.rf then
                Value1.rf.TextTransparency = F
            end
        end
    end

    local Rang = NameTag:FindFirstChild( "Rang" )

    if Rang and Rang.Visible then
        local ImageTransparency
        local Entry3 = Table[ Nom ]

        if Entry3 < 1 then
            local Clamp3 = math.clamp( ( TextTransparency2 - Entry3 ) / ( 1 - Entry3 ), 0, 1 )

            if Clamp3 then
                ImageTransparency = Clamp3
            else
                ImageTransparency = 1
            end
        else
            ImageTransparency = 1
        end
        if Rang.ImageTransparency ~= ImageTransparency then
            Rang.ImageTransparency = ImageTransparency
        end
    end
end )
