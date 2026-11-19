-- StarterPlayer.StarterPlayerScripts.CrewClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #46

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Vector22
local CurrentCamera = workspace.CurrentCamera

if not CurrentCamera or not CurrentCamera.ViewportSize then
    Vector22 = Vector2.new( 1920, 1080 )
else
    Vector22 = CurrentCamera.ViewportSize
end

local Flag = Vector22.Y < 600 and true or false
local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    local Size
    local Obj = Value.obj
    Size = Flag and Value.small or Value.base
    Obj.Size = Size

    if Value.basePos then
        local Position
        local Obj2 = Value.obj
        Position = Flag and Value.smallPos or Value.basePos
        Obj2.Position = Position
    end
end

Upvalue2.ScrollBarThickness = math.max( 3, ( math.floor( Vector22.Y * 0.005 + 0.5 ) ) )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Disconnect( )
end

local CurrentCamera = workspace.CurrentCamera

if CurrentCamera then
    Upvalue1 = CurrentCamera:GetPropertyChangedSignal( "ViewportSize" ):Connect( Upvalue2 )
end

Upvalue2( )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Normal = Self:FindFirstChild( "Normal" )
local Off = Self:FindFirstChild( "Off" )

if Normal then
    Normal.Enabled = Enabled
end
if Off then
    Off.Enabled = not Enabled
end

Self.AutoButtonColor = Enabled

if Text then
    Self.Text.Text = Text
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

return ( tostring( Argument1 ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.IdOf( Upvalue2 )
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Player:GetAttribute( "CrewLeader" ) == true and true or false
local Flag2 = Player2:GetAttribute( "CrewLeader" ) == true and true or false

if Flag ~= Flag2 then
    return Flag
end

local Flag3 = Player.DisplayName:lower( ) < Player2.DisplayName:lower( ) and true or false
return Flag3
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Table = { }

if not IdOf then
    return Table
end
for Key, Value in Upvalue1:GetPlayers( ) do
    if Upvalue2.IdOf( Value ) == IdOf then
        table.insert( Table, Value )
    end
end

table.sort( Table, function( Player, Player2 )
    local Flag = Player:GetAttribute( "CrewLeader" ) == true and true or false
    local Flag2 = Player2:GetAttribute( "CrewLeader" ) == true and true or false

    if Flag ~= Flag2 then
        return Flag
    end

    local Flag3 = Player.DisplayName:lower( ) < Player2.DisplayName:lower( ) and true or false
    return Flag3
end )
return Table
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    Value:Destroy( )
end

table.clear( Upvalue1 )
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:FireServer( "kick", Upvalue2.UserId )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag2
local Value1 = Upvalue3( ( Upvalue1.IdOf( Upvalue2 ) ) )
Flag2 = Upvalue2:GetAttribute( "CrewLeader" ) == true and true or false
local Value2
Upvalue4.Text = tostring( Upvalue2:GetAttribute( "CrewName" ) or "Crew" ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
Upvalue5.Text = ( "Members %d/%d" ):format( #Value1, Upvalue1.MAX_MEMBERS )
Value2 = nil

for Key, Value in Value1, nil, nil do
    local BackgroundTransparency
    local Clone = Upvalue6:Clone( )
    Clone.Name = "Member_" .. Value.UserId
    Clone.LayoutOrder = Key
    Clone.Size = UDim2.fromScale( 1, 0.125 )
    BackgroundTransparency = Key % 2 ~= 0 and 0.6 or 0.75
    local Text2
    Clone.BackgroundTransparency = BackgroundTransparency
    local PlayerName = Clone.PlayerName
    local Gsub = tostring( Value.DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    Text2 = Value ~= Upvalue2 and "" or " <font color=\"#9aa6c8\">(you)</font>"
    local Visible
    PlayerName.Text = Gsub .. Text2
    local Tag = Clone.Tag
    Visible = Value:GetAttribute( "CrewLeader" ) == true and true or false
    local Visible2
    Tag.Visible = Visible
    local Kick = Clone.Kick

    if Flag2 then
        if Value == Upvalue2 then
            Visible2 = false
        else
            Visible2 = true
        end
    else
        Visible2 = Flag2
    end

    Kick.Visible = Visible2
    Clone.Kick.Activated:Connect( function()
        Upvalue7:FireServer( "kick", Value.UserId )
    end )
    Clone.Visible = true
    Clone.Parent = Upvalue8
    table.insert( Upvalue9, Clone )
end

local Flag

if Flag2 then
    local NotREQUIRE_PASS = not Upvalue1.REQUIRE_PASS

    if NotREQUIRE_PASS then
        Flag = NotREQUIRE_PASS
    elseif Upvalue2:GetAttribute( "CrewPass" ) == true then
        Flag = true
    else
        Flag = false
    end
else
    Flag = Flag2
end
if Flag then
    local Enabled = #Value1 < Upvalue1.MAX_MEMBERS and true or false
    local Text = not ( #Value1 < Upvalue1.MAX_MEMBERS ) and "CREW FULL" or "INVITE"
    local Normal2 = Upvalue10:FindFirstChild( "Normal" )
    local Off2 = Upvalue10:FindFirstChild( "Off" )

    if Normal2 then
        Normal2.Enabled = Enabled
    end
    if Off2 then
        Off2.Enabled = not Enabled
    end

    Upvalue10.AutoButtonColor = Enabled

    if Text then
        Upvalue10.Text.Text = Text
    end

    return
end
local Normal = Upvalue10:FindFirstChild( "Normal" )
local Off = Upvalue10:FindFirstChild( "Off" )

if Normal then
    Normal.Enabled = false
end
if Off then
    Off.Enabled = true
end

Upvalue10.AutoButtonColor = false
Upvalue10.Text.Text = "OWNER ONLY"
return
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local PlayerByUserId
local Entry = Upvalue1[ StateName ]

if Entry then
    PlayerByUserId = Upvalue2:GetPlayerByUserId( StateName )
else
    PlayerByUserId = Entry
end
if not PlayerByUserId then
    return
end

local IdOf = Upvalue3.IdOf( Upvalue4 )

if IdOf and Upvalue3.IdOf( PlayerByUserId ) == IdOf then
    local Normal = Entry:FindFirstChild( "Normal" )
    local Off = Entry:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = false
    end
    if Off then
        Off.Enabled = true
    end

    Entry.AutoButtonColor = false
    Entry.Text.Text = "IN CREW"
    return
end
if Upvalue3.IdOf( PlayerByUserId ) then
    local Normal2 = Entry:FindFirstChild( "Normal" )
    local Off2 = Entry:FindFirstChild( "Off" )

    if Normal2 then
        Normal2.Enabled = false
    end
    if Off2 then
        Off2.Enabled = true
    end

    Entry.AutoButtonColor = false
    Entry.Text.Text = "IN A CREW"
    return
end
local Entry2 = ( Upvalue5[ StateName ] or 0 ) - os.clock( )

if Entry2 > 0 then
    local Text = ( "%ds" ):format( ( math.ceil( Entry2 ) ) )
    local Normal3 = Entry:FindFirstChild( "Normal" )
    local Off3 = Entry:FindFirstChild( "Off" )

    if Normal3 then
        Normal3.Enabled = false
    end
    if Off3 then
        Off3.Enabled = true
    end

    Entry.AutoButtonColor = false

    if Text then
        Entry.Text.Text = Text
    end

    return
end
local Enabled = #Upvalue6( IdOf ) < Upvalue3.MAX_MEMBERS and true or false
local Normal4 = Entry:FindFirstChild( "Normal" )
local Off4 = Entry:FindFirstChild( "Off" )

if Normal4 then
    Normal4.Enabled = Enabled
end
if Off4 then
    Off4.Enabled = not Enabled
end

Entry.AutoButtonColor = Enabled
Entry.Text.Text = "SEND"
return
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Player.DisplayName:lower( ) < Player2.DisplayName:lower( ) and true or false
return Flag
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Upvalue2 ] or 0

if os.clock( ) < Entry then
    return
end
if not Upvalue3.IdOf( Upvalue4 ) or Upvalue3.IdOf( Upvalue5 ) then
    return
end
Upvalue1[ Upvalue2 ] = os.clock( ) + 1
Upvalue6( Upvalue2 )
Upvalue7:FireServer( "invite", Upvalue2 )
return
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

table.clear( Upvalue1 )
local Table = { }

for Key, Value in Upvalue2:GetPlayers( ) do
    if Value ~= Upvalue3 then
        table.insert( Table, Value )
    end
end

local Value1
table.sort( Table, function( Player, Player2 )
    local Flag = Player.DisplayName:lower( ) < Player2.DisplayName:lower( ) and true or false
    return Flag
end )
local Count = #Table
Upvalue4.CanvasSize = UDim2.fromScale( 0, ( math.max( 1, Count / 8 ) ) )
Value1 = nil

for Key2, Value2 in Table, nil, nil do
    local BackgroundTransparency
    local Clone = Upvalue5:Clone( )
    Clone.Name = "Player_" .. Value2.UserId
    Clone.LayoutOrder = Key2
    Clone.Size = UDim2.fromScale( 1, 1 / math.max( 8, Count ) )
    BackgroundTransparency = Key2 % 2 ~= 0 and 0.6 or 0.75
    Clone.BackgroundTransparency = BackgroundTransparency
    local PlayerName = Clone.PlayerName
    local Gsub = tostring( Value2.DisplayName ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" )
    PlayerName.Text = Gsub .. " <font color=\"#9aa6c8\">@" .. tostring( Value2.Name ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) .. "</font>"
    local UserId = Value2.UserId
    Clone.Send.Activated:Connect( function()
        local Entry = Upvalue6[ UserId ] or 0

        if os.clock( ) < Entry then
            return
        end
        if not Upvalue7.IdOf( Upvalue3 ) or Upvalue7.IdOf( Value2 ) then
            return
        end
        Upvalue6[ UserId ] = os.clock( ) + 1
        Upvalue8( UserId )
        Upvalue9:FireServer( "invite", UserId )
        return
    end )
    Clone.Visible = true
    Clone.Parent = Upvalue4
    table.insert( Upvalue10, Clone )
    Upvalue1[ UserId ] = Clone.Send
    Upvalue8( UserId )
end

local Visible = Count == 0 and true or false
Upvalue11.Visible = Visible
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Value1 = nil

for Key, Value in Upvalue2, nil, nil do
    Value:Destroy( )
end

table.clear( Upvalue2 )
local IdOf = Upvalue3.IdOf( Upvalue4 )

if not IdOf then
    Upvalue5 = false
end

local Visible = IdOf == nil and true or false
local Visible2
Upvalue6.Visible = Visible
Visible2 = if IdOf == nil then false else not Upvalue5
local Visible3
Upvalue7.Visible = Visible2
Visible3 = if IdOf == nil then false else Upvalue5
Upvalue8.Visible = Visible3
Upvalue9.Visible = true

if not IdOf and Upvalue10.Text == "" then
    Upvalue10.Text = Upvalue4:GetAttribute( "CrewLastName" ) or ""
end
if IdOf and not Upvalue5 then
    Upvalue11( )
end
if IdOf and Upvalue5 then
    Upvalue12( )
end

Upvalue13 = 0
Upvalue14.Text.Text = Upvalue15
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2( )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or not Upvalue2 then
    return
end
Upvalue1 = true
task.defer( function()
    Upvalue1 = false
    Upvalue3( )
end )
return
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.WardrobeOpen == true then
    Flag = true
elseif Upvalue1.BetaReveal == true then
    Flag = true
elseif Upvalue1.Downed == true then
    Flag = true
elseif Upvalue2:GetAttribute( "InWardrobe" ) == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1.IdOf( Upvalue2 ) and Upvalue3 or Upvalue4
return Captured
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = false
    Upvalue2( )
    return
end
Upvalue3( false )
return
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Visible == Upvalue1 then
    return
end
if Visible then
    local Flag

    if Upvalue2.WardrobeOpen == true then
        Flag = true
    elseif Upvalue2.BetaReveal == true then
        Flag = true
    elseif Upvalue2.Downed == true then
        Flag = true
    elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
        Flag = true
    else
        Flag = false
    end
    if Flag then
        return
    end
end

Upvalue1 = Visible
Upvalue4.Visible = Visible
Upvalue5 = false

if Visible then
    Upvalue2.ActiveMenu = "Crew"
end

Upvalue2.CursorFree = Visible

if Visible then
    local Value1
    local Table = { "Shop", "Settings", "Customization" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Icon
        local GetIcon = Upvalue6.getIcon

        if GetIcon then
            Icon = Upvalue6.getIcon( Value )
        else
            Icon = GetIcon
        end
        if Icon and Icon.isSelected then
            Icon:deselect( )
        end
    end

    Upvalue7( )
    Upvalue8.Open( "Crew", {
        root = Upvalue9,
        first = function()
            local Captured = Upvalue10.IdOf( Upvalue3 ) and Upvalue11 or Upvalue12
            return Captured
        end,
        onBack = function()
            if Upvalue5 then
                Upvalue5 = false
                Upvalue7( )
                return
            end
            Upvalue13( false )
            return
        end
    } )
    return
end
local Value2 = nil

for Key2, Value3 in Upvalue14, nil, nil do
    Value3:Destroy( )
end

table.clear( Upvalue14 )
table.clear( Upvalue15 )
Upvalue8.Close( "Crew" )
return
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

local NotREQUIRE_PASS2
local NotREQUIRE_PASS = not Upvalue1.REQUIRE_PASS

if NotREQUIRE_PASS then
    NotREQUIRE_PASS2 = NotREQUIRE_PASS
elseif Upvalue2:GetAttribute( "CrewPass" ) == true then
    NotREQUIRE_PASS2 = true
else
    NotREQUIRE_PASS2 = false
end

return NotREQUIRE_PASS2
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:PromptGamePassPurchase( Upvalue2, Upvalue3.PASS_ID )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 and not Upvalue2.IdOf( Upvalue3 ) then
    local NotREQUIRE_PASS2
    local NotREQUIRE_PASS = not Upvalue2.REQUIRE_PASS

    if NotREQUIRE_PASS then
        NotREQUIRE_PASS2 = NotREQUIRE_PASS
    elseif Upvalue3:GetAttribute( "CrewPass" ) == true then
        NotREQUIRE_PASS2 = true
    else
        NotREQUIRE_PASS2 = false
    end
    if not NotREQUIRE_PASS2 then
        local Flag

        if Upvalue5.WardrobeOpen == true then
            Flag = true
        elseif Upvalue5.BetaReveal == true then
            Flag = true
        elseif Upvalue5.Downed == true then
            Flag = true
        elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
            Flag = true
        else
            Flag = false
        end
        if Flag then
            return
        end

        Upvalue6 = math.huge

        if Upvalue2.PASS_ID then
            Upvalue7.Prompt( function()
                Upvalue8:PromptGamePassPurchase( Upvalue3, Upvalue2.PASS_ID )
            end )
            return
        end
        if Upvalue9:IsStudio( ) then
            Upvalue10:FireServer( "studiobuy" )
            return
        end
        Upvalue6 = 0
        Upvalue11.Error( "Crews are coming soon" )
        return
    end
end

Upvalue4( not Upvalue1 )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "CrewPass" ) == true and os.clock( ) < Upvalue2 then
    Upvalue2 = 0
    Upvalue3( true )
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Upvalue1 and not Argument3 then
    Upvalue2 = math.min( Upvalue2, os.clock( ) + 5 )
end
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == false then
    return
end

local Value1
Upvalue1 = false
Upvalue2.Visible = false
Upvalue3 = false
Upvalue4.CursorFree = false
Value1 = nil

for Key, Value in Upvalue5, nil, nil do
    Value:Destroy( )
end

table.clear( Upvalue5 )
table.clear( Upvalue6 )
Upvalue7.Close( "Crew" )
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if utf8.len( Upvalue1.Text ) then
    local Len = utf8.len( Upvalue1.Text )

    if Upvalue2.NAME_MAX < Len then
        local Text = Upvalue1.Text
        Upvalue1.Text = Text:sub( 1, utf8.offset( Upvalue1.Text, Upvalue2.NAME_MAX + 1 ) - 1 )
    end
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IdOf( Upvalue2 ) or os.clock( ) - Upvalue3 < 1 then
    return
end

Upvalue3 = os.clock( )
local Match = Upvalue4.Text:match( "^%s*(.-)%s*$" )

if #Match < Upvalue1.NAME_MIN then
    Upvalue5.Error( ( "The name must be %d to %d characters" ):format( Upvalue1.NAME_MIN, Upvalue1.NAME_MAX ) )
    return
end

local MaskBanned, MaskBanned2 = Upvalue1.MaskBanned( Match )

if MaskBanned2 then
    Upvalue5.Error( ( "Inappropriate name: \"%s\". Choose another name" ):format( MaskBanned ) )
    return
end
Upvalue6:FireServer( "create", Match )
return
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.IdOf( Upvalue2 ) then
    local Count = #Upvalue3( Upvalue4( ) )

    if not ( Upvalue1.MAX_MEMBERS <= Count ) then
        if Upvalue2:GetAttribute( "CrewLeader" ) == true then
            local NotREQUIRE_PASS2
            local NotREQUIRE_PASS = not Upvalue1.REQUIRE_PASS

            if NotREQUIRE_PASS then
                NotREQUIRE_PASS2 = NotREQUIRE_PASS
            elseif Upvalue2:GetAttribute( "CrewPass" ) == true then
                NotREQUIRE_PASS2 = true
            else
                NotREQUIRE_PASS2 = false
            end
            if NotREQUIRE_PASS2 then
                Upvalue5 = true
                Upvalue6( )
                return
            end
        end

        return
    end
end
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = false
Upvalue2( )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

if os.clock( ) - Upvalue1 >= 2.9 then
    Upvalue2.Text.Text = Upvalue3
end
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.IdOf( Upvalue2 ) then
    return
end
if os.clock( ) - Upvalue3 > 3 then
    Upvalue3 = os.clock( )
    Upvalue4.Text.Text = "SURE?"
    task.delay( 3, function()
        if os.clock( ) - Upvalue3 >= 2.9 then
            Upvalue4.Text.Text = Upvalue5
        end
    end )
    return
end
Upvalue3 = 0
Upvalue4.Text.Text = Upvalue5
Upvalue6:FireServer( "leave" )
return
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Table = { "CrewId", "CrewName", "CrewLeader" }
Value1 = nil

for Key, Value in Table, nil, nil do
    Argument1:GetAttributeChangedSignal( Value ):Connect( Upvalue1 )
end
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Argument1 )

if not Upvalue2 then
    if not Upvalue3 then
        return
    end

    Upvalue2 = true
    task.defer( function()
        Upvalue2 = false
        Upvalue4( )
    end )
end
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1[ Player.UserId ] = nil

if not Upvalue2 then
    if not Upvalue3 then
        return
    end

    Upvalue2 = true
    task.defer( function()
        Upvalue2 = false
        Upvalue4( )
    end )
end
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Flag

if Upvalue2.WardrobeOpen == true then
    Flag = true
elseif Upvalue2.BetaReveal == true then
    Flag = true
elseif Upvalue2.Downed == true then
    Flag = true
elseif Upvalue3:GetAttribute( "InWardrobe" ) == true then
    Flag = true
else
    Flag = false
end
if Flag or Upvalue2.ActiveMenu ~= "Crew" then
    if Upvalue1 == false then
        return
    end

    local Value6
    Upvalue1 = false
    Upvalue4.Visible = false
    Upvalue5 = false
    Upvalue2.CursorFree = false
    Value6 = nil

    for Key3, Value7 in Upvalue6, nil, nil do
        Value7:Destroy( )
    end

    table.clear( Upvalue6 )
    table.clear( Upvalue7 )
    Upvalue8.Close( "Crew" )
    return
end
local Value1
local Table = { "Shop", "Settings", "Customization" }
Value1 = nil

for Key, Value in Table, nil, nil do
    local Icon
    local GetIcon = Upvalue9.getIcon

    if GetIcon then
        Icon = Upvalue9.getIcon( Value )
    else
        Icon = GetIcon
    end
    if Icon then
        if Icon.isSelected then
            if Upvalue1 == false then
                return
            end

            local Value4
            Upvalue1 = false
            Upvalue4.Visible = false
            Upvalue5 = false
            Upvalue2.CursorFree = false
            Value4 = nil

            for Key2, Value5 in Upvalue6, nil, nil do
                Value5:Destroy( )
            end

            table.clear( Upvalue6 )
            table.clear( Upvalue7 )
            Upvalue8.Close( "Crew" )
            return
        end
    end
end
if not Upvalue2.CursorFree then
    Upvalue2.CursorFree = true
end

Upvalue10 = Upvalue10 + Argument1

if Upvalue10 >= 0.25 then
    Upvalue10 = 0

    if Upvalue5 then
        local Value2 = nil

        for Value3 in Upvalue7, nil, nil do
            Upvalue11( Value3 )
        end
    end
end

return
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue1 = nil
    Upvalue3( )
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 or #Upvalue2 == 0 then
    return
end

local Remove = table.remove( Upvalue2, 1 )
local Expires = Remove.expires - workspace:GetServerTimeNow( )

if Expires < 1 then
    return Upvalue3( )
end

Upvalue1 = Remove
Upvalue4.Text = ( "<b>%s</b> invites you to join <b>%s</b>" ):format( tostring( Remove.from ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ), ( tostring( Remove.crew ):gsub( "&", "&amp;" ):gsub( "<", "&lt;" ):gsub( ">", "&gt;" ) ) )
Upvalue5.Position = Upvalue6
Upvalue5.Visible = true

if Upvalue7 then
    Upvalue7:Cancel( )
end

Upvalue7 = Upvalue8:Create( Upvalue5, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Position = Upvalue9 } )
Upvalue7:Play( )
Upvalue10.TimePosition = 0
Upvalue10:Play( )
Upvalue11.Size = UDim2.fromScale( math.clamp( Expires / Upvalue12.INVITE_TIME, 0, 1 ), 1 )
Upvalue8:Create( Upvalue11, TweenInfo.new( Expires, Enum.EasingStyle.Linear ), { Size = UDim2.fromScale( 0, 1 ) } ):Play( )
task.delay( Expires, function()
    if Upvalue1 == Remove then
        Upvalue1 = nil
        Upvalue13( )
    end
end )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Enum.PlaybackState.Completed and not Upvalue1 then
    Upvalue2.Visible = false
end

task.delay( 0.15, Upvalue3 )
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1:Cancel( )
end

Upvalue1 = Upvalue2:Create( Upvalue3, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In ), { Position = Upvalue4 } )
Upvalue1:Play( )
Upvalue1.Completed:Connect( function( Argument1 )
    if Argument1 == Enum.PlaybackState.Completed and not Upvalue5 then
        Upvalue3.Visible = false
    end

    task.delay( 0.15, Upvalue6 )
end )
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2:FireServer( "respond", Upvalue1.id, Argument1 )
    Upvalue3( )
    return
end
return
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2:FireServer( "respond", Upvalue1.id, true )
    Upvalue3( )
    return
end
return
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1 = nil
    Upvalue2:FireServer( "respond", Upvalue1.id, false )
    Upvalue3( )
    return
end
return
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "invite" then
    if Upvalue1.IdOf( Upvalue2 ) then
        return
    end
    if type( Key ) ~= "table" or type( Key.id ) ~= "string" or type( Key.expires ) ~= "number" then
        return
    end

    local Value1
    local From = tostring( Key.from or "?" )
    local Crew = tostring( Key.crew or "Crew" )
    Key.from = From
    Key.crew = Crew
    Value1 = nil

    for Key2, Value in Upvalue3, nil, nil do
        if Value.id == Key.id then
            return
        end
    end

    table.insert( Upvalue3, Key )

    while true do
        local Count = #Upvalue3

        if not ( Upvalue1.MAX_PENDING < Count ) then
            break
        end

        table.remove( Upvalue3, 1 )
    end

    Upvalue4( )
    return
end
if Name == "cancel" then
    if Upvalue5 and Upvalue5.id == Key then
        Upvalue5 = nil
        Upvalue6( )
        return
    end

    local Value2 = nil

    for Key3, Value3 in Upvalue3, nil, nil do
        if Value3.id == Key then
            table.remove( Upvalue3, Key3 )
            return
        end
    end

    return
end
if Name == "sent" then
    if type( Key ) == "number" and type( Argument3 ) == "number" then
        Upvalue7[ Key ] = os.clock( ) + Argument3

        if Upvalue8[ Key ] then
            Upvalue9( Key )
            return
        end
    end
elseif Name == "error" then
    if type( Key ) == "string" then
        Upvalue10.Error( Key )
    end

    local Value4 = nil

    for Key4, Value5 in Upvalue7, nil, nil do
        if Value5 - os.clock( ) <= 1 then
            Upvalue7[ Key4 ] = nil
        end
    end
    if Upvalue11 and Upvalue12 then
        local Value6 = nil

        for Value7 in Upvalue8, nil, nil do
            Upvalue9( Value7 )
        end

        return
    end
elseif Name == "info" and type( Key ) == "string" then
    Upvalue10.Announce( "CREW", Key, 3 )
end

return
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.IdOf( Upvalue2 ) then
    return
end

table.clear( Upvalue3 )

if Upvalue4 then
    Upvalue4 = nil
    Upvalue5( )
end
]]
