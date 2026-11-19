-- Players.perkbrokeyou.PlayerScripts.ClanTagClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local Players = game:GetService( "Players" )
local ClanShared = require( ReplicatedStorage:WaitForChild( "ClanShared" ) )
local Enabled = ClanShared.Enabled( )
local Table = { }
local Value1 = nil

local function Badges()
    if Value1 then
        return Value1
    end

    local Badges
    local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

    if RankedShared then
        Badges = RankedShared:FindFirstChild( "Badges" )
    else
        Badges = RankedShared
    end
    if not Badges then
        return nil
    end

    local Success, Result = pcall( require, Badges )

    if Success and type( Result ) == "table" then
        Value1 = Result
    end

    return Value1
end

local function Watch( Object )
    local Tag
    local Nom = Object:WaitForChild( "Nom", 5 )
    local Plate = Object:WaitForChild( "Plate", 5 )

    if Plate then
        Tag = Plate:WaitForChild( "Tag", 5 )
    else
        Tag = Plate
    end
    if not Nom or not Tag then
        return
    end

    local UIGradient = Tag:FindFirstChild( "UIGradient" )
    local Rang = Object:FindFirstChild( "Rang" )

    local function Layout()
        local X = Object.AbsoluteSize.X
        local Y = Object.AbsoluteSize.Y

        if X < 1 or Y < 1 then
            return
        end

        local Flag
        local TextBounds = Nom.TextBounds
        local Max = math.max( TextBounds.Y, 1 )
        local Max2 = Max * 0.22
        local Visible = Plate.Visible
        Flag = if Rang == nil then false else Rang.Visible
        local Min3, Number2, Number3

        if Visible then
            local Min = math.min( Max, Y )
            local Min2 = Min * 3.6
            Min3 = math.min( Tag.TextBounds.X, Min2 )
            Number2 = Min2
            Number3 = Min
        else
            Min3 = 0
            Number2 = 0
            Number3 = 0
        end

        local Max3 = Flag and Max * 1.35 or 0
        local Number = Visible and Min3 + Max2 or 0
        local Max4 = Flag and Max2 + Max3 or 0
        local X2 = ( X - ( Number + TextBounds.X + Max4 ) ) / 2

        if Visible then
            Plate.Size = UDim2.fromScale( Number2 / X, Number3 / Y )
            Plate.Position = UDim2.fromScale( ( X2 + Min3 - Number2 ) / X, 0.5 )
        end

        Nom.Position = UDim2.fromScale( ( Number - Max4 ) / 2 / X, 0 )

        if Flag then
            local Captured
            Rang:SetAttribute( "BadgeCenter", UDim2.fromScale( ( X2 + Number + TextBounds.X + Max2 + Max3 / 2 ) / X, 0.5 ) )
            Rang:SetAttribute( "BadgeSize", UDim2.fromScale( Max3 / X, Max3 / Y ) )

            if Value1 then
                Captured = Value1
            else
                local Badges
                local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

                if RankedShared then
                    Badges = RankedShared:FindFirstChild( "Badges" )
                else
                    Badges = RankedShared
                end
                if Badges then
                    local Success, Result = pcall( require, Badges )

                    if Success and type( Result ) == "table" then
                        Value1 = Result
                    end

                    Captured = Value1
                else
                    Captured = nil
                end
            end
            if Captured and Captured.Place then
                Captured.Place( Rang )
            end
        end
    end

    local PlayerFromCharacter = Players:GetPlayerFromCharacter( Object.Parent )

    local function SetRank()
        if not Rang then
            return
        end

        local Captured

        if Value1 then
            Captured = Value1
        else
            local Badges
            local RankedShared = ReplicatedStorage:FindFirstChild( "RankedShared" )

            if RankedShared then
                Badges = RankedShared:FindFirstChild( "Badges" )
            else
                Badges = RankedShared
            end
            if Badges then
                local Success, Result = pcall( require, Badges )

                if Success and type( Result ) == "table" then
                    Value1 = Result
                end

                Captured = Value1
            else
                Captured = nil
            end
        end

        local RankBadge

        if PlayerFromCharacter then
            RankBadge = PlayerFromCharacter:GetAttribute( "RankBadge" )
        else
            RankBadge = PlayerFromCharacter
        end

        local Image2

        if not Captured or not Captured.Image or type( RankBadge ) ~= "string" then
            Image2 = nil
        else
            local Match, Match2 = RankBadge:match( "^(%w+):(%d*)$" )

            if not Match or Match == "Unranked" then
                Image2 = nil
            else
                local Image = Captured.Image
                Image2 = Image( Match, ( tonumber( Match2 ) ) )
            end
        end
        if Image2 and Rang.Image ~= Image2 then
            Rang.Image = Image2

            if Captured and Captured.Place then
                Captured.Place( Rang )
            end
        end

        local Flag
        local Visible = Rang.Visible
        Flag = Image2 ~= nil and true or false

        if Visible ~= Flag then
            local Visible2 = Image2 ~= nil and true or false
            Rang.Visible = Visible2
        end

        Layout( )
    end

    local function Paint()
        if not Enabled then
            Layout( )
            return
        end
        if not UIGradient or Plate:GetAttribute( "DevStyle" ) ~= true then
            if UIGradient then
                local ColorId2
                local ColorId = Plate:GetAttribute( "ColorId" )
                ColorId2 = Plate.Visible and Plate:GetAttribute( "Animated" ) == true and ColorId or nil
                Table[ UIGradient ] = ColorId2

                if not Table[ UIGradient ] and Plate.Visible then
                    UIGradient.Color = ClanShared.GradientOf( ColorId )
                end

                UIGradient.Offset = Vector2.zero
            end
        else
            Table[ UIGradient ] = nil
        end

        Layout( )
    end

    Nom:GetPropertyChangedSignal( "TextBounds" ):Connect( Layout )
    Tag:GetPropertyChangedSignal( "TextBounds" ):Connect( Layout )
    Plate:GetPropertyChangedSignal( "Visible" ):Connect( Paint )
    Plate:GetAttributeChangedSignal( "Animated" ):Connect( Paint )
    Plate:GetAttributeChangedSignal( "ColorId" ):Connect( Paint )
    Plate:GetAttributeChangedSignal( "DevStyle" ):Connect( Paint )

    if PlayerFromCharacter then
        local Connect = PlayerFromCharacter:GetAttributeChangedSignal( "RankBadge" ):Connect( SetRank )
        Object.Destroying:Connect( function()
            Connect:Disconnect( )
        end )
    end

    Paint( )
    SetRank( )
end

CollectionService:GetInstanceAddedSignal( "NameTagPlate" ):Connect( Watch )
CollectionService:GetInstanceRemovedSignal( "NameTagPlate" ):Connect( function( Self )
    local UIGradient
    local Plate = Self:FindFirstChild( "Plate" )

    if Plate then
        local Tag = Self.Plate:FindFirstChild( "Tag" )

        if Tag then
            UIGradient = Self.Plate.Tag:FindFirstChild( "UIGradient" )
        else
            UIGradient = Tag
        end
    else
        UIGradient = Plate
    end
    if UIGradient then
        Table[ UIGradient ] = nil
    end
end )

for Key, Value in CollectionService:GetTagged( "NameTagPlate" ) do
    task.spawn( Watch, Value )
end

local Number = 0
RunService.Heartbeat:Connect( function( Argument1 )
    if next( Table ) == nil then
        return
    end

    Number = Number + Argument1

    if Number < 0.03333333333333333 then
        return
    end

    local Value1
    Number = 0
    local Clock = os.clock( ) * ClanShared.SCROLL_SPEED % 1
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Key.Parent then
            Key.Color = ClanShared.ScrollSequence( Value, Clock )
        else
            Table[ Key ] = nil
        end
    end
end )
