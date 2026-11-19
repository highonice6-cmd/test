-- ReplicatedStorage.RobuxShopUI
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local MarketplaceService = game:GetService( "MarketplaceService" )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Notify = require( ReplicatedStorage:WaitForChild( "Notify" ) )
local RobuxShop = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "RobuxShop" )
local LocalPlayer = Players.LocalPlayer
local Char = utf8.char( 57346 )
local BindableEvent = Instance.new( "BindableEvent" )
local Table = { ROBUX = Char, Changed = BindableEvent.Event }
local Table2 = { }
local Table3 = { }

local function Commas( Entry )
    local Sub
    local Reverse = tostring( ( math.floor( Entry ) ) ):reverse( ):gsub( "(%d%d%d)", "%1," ):reverse( )

    if Reverse:sub( 1, 1 ) == "," then
        Sub = Reverse:sub( 2 )
    else
        Sub = Reverse
    end

    return Sub
end

function Table.PriceText( TextName, TextName2 )
    local Entry = Table2[ TextName ]

    if type( Entry ) == "number" then
        local ROBUX = Table.ROBUX
        return ROBUX .. " " .. Commas( Entry )
    end
    if TextName2 then
        local Entry3
        local Entry2 = Table3[ TextName ]
        Entry3 = if Entry2 then Entry2 else { }
        Table3[ TextName ] = Entry3
        Table3[ TextName ][ TextName2 ] = true
    end
    if Entry == nil then
        Table2[ TextName ] = false
        task.spawn( function()
            local Result, Success2
            local I = 1
            Success2 = nil
            Result = nil

            for I = 1, 3 do
                Success, Result = pcall( MarketplaceService.GetProductInfo, MarketplaceService, TextName, Enum.InfoType.Product )

                if Success then
                    Success2 = Success
                    break
                end

                task.wait( I * 2 )
                Success2 = Success
            end

            local Number2

            if not Success2 or not Result then
                Number2 = nil
            else
                local Number = tonumber( Result.PriceInRobux )

                if Number then
                    Number2 = Number
                else
                    Number2 = nil
                end
            end

            local Entry2
            Table2[ TextName ] = Number2
            local Entry = Table3[ TextName ]
            Table3[ TextName ] = nil
            Entry2 = if Entry then Entry else { }
            local Value1 = nil

            for Value in Entry2, nil, nil do
                task.spawn( Value )
            end
        end )
    end

    return "..."
end
function Table.SetBuy( Self, BuyName, Text )
    local Flag
    local Normal = Self:FindFirstChild( "Normal" )
    local Equip = Self:FindFirstChild( "Equip" )
    local Owned = Self:FindFirstChild( "Owned" )

    if BuyName == "buy" then
        Flag = true
    elseif BuyName == "wait" then
        Flag = true
    else
        Flag = false
    end
    if Normal then
        local Enabled

        if Flag then
            Enabled = Flag
        elseif BuyName == "equip" then
            Enabled = not Equip
        else
            Enabled = false
        end

        Normal.Enabled = Enabled
    end
    if Equip then
        local Enabled2 = BuyName == "equip" and true or false
        Equip.Enabled = Enabled2
    end
    if Owned then
        local Enabled3

        if BuyName == "equipped" then
            Enabled3 = true
        elseif BuyName == "soon" then
            Enabled3 = true
        else
            Enabled3 = false
        end

        Owned.Enabled = Enabled3
    end

    local AutoButtonColor

    if BuyName == "buy" then
        AutoButtonColor = true
    elseif BuyName == "equip" then
        AutoButtonColor = true
    else
        AutoButtonColor = false
    end

    Self.AutoButtonColor = AutoButtonColor
    local Text2 = Self:FindFirstChild( "Text" )

    if Text2 and Text then
        Text2.Text = Text
    end
end
local Table4 = { }
function Table.Pending( Key )
    local Entry = Table4[ Key ]

    if not Entry then
        return false
    end

    local Number
    local Clock = os.clock( ) - Entry.at
    Number = not Entry.paid and 120 or 10

    if Number < Clock then
        Table4[ Key ] = nil
        return false
    end
    return true
end
function Table.Done( Key )
    if Key then
        Table4[ Key ] = nil
    else
        table.clear( Table4 )
    end

    BindableEvent:Fire( )
end
MarketplaceService.PromptProductPurchaseFinished:Connect( function( Argument1, Key, Argument3 )
    if Argument1 ~= LocalPlayer.UserId or not Table4[ Key ] then
        return
    end
    if Argument3 then
        Table4[ Key ] = { at = os.clock( ), paid = true }
        task.delay( 10.1, function()
            BindableEvent:Fire( )
        end )
    else
        Table4[ Key ] = nil
    end

    BindableEvent:Fire( )
end )
local Flag = false

local function Ask( Argument1, ... )
    local Result2
    local Success, Result = pcall( RobuxShop.InvokeServer, RobuxShop, Argument1, ... )
    Result2 = ( not Success or type( Result ) ~= "table" ) and { ok = false, err = "The shop is unavailable right now, try again" } or Result
    return Result2
end

local function Prompt( Key )
    Table4[ Key ] = { at = os.clock( ), paid = false }
    BindableEvent:Fire( )
    GamepadNav.Prompt( function()
        MarketplaceService:PromptProductPurchase( LocalPlayer, Key )
    end )
end

function Table.Buy( Argument1, Argument2 )
    if Flag then
        return false
    end

    Flag = true
    local Ask2 = Ask( "buy", Argument1, Argument2 )
    Flag = false

    if not Ask2.ok then
        Notify.Error( Ask2.err or "Couldn't buy it" )
        return false
    end
    if Ask2.prompt then
        Prompt( Ask2.prompt )
    end

    return true
end

local function SetSendEnabled( Self, Enabled )
    local Normal = Self:FindFirstChild( "Normal" )
    local Off = Self:FindFirstChild( "Off" )

    if Normal then
        Normal.Enabled = Enabled
    end
    if Off then
        Off.Enabled = not Enabled
    end

    Self.AutoButtonColor = Enabled
end

function Table.Gift( Argument1, Argument2, Argument3, Object )
    if Flag then
        return false
    end

    Flag = true

    if Object then
        local Normal = Object:FindFirstChild( "Normal" )
        local Off = Object:FindFirstChild( "Off" )

        if Normal then
            Normal.Enabled = false
        end
        if Off then
            Off.Enabled = true
        end

        Object.AutoButtonColor = false
    end

    local Ask2 = Ask( "gift", Argument1, Argument2, Argument3.id )
    Flag = false

    if Ask2.ok then
        if Ask2.prompt then
            Prompt( Ask2.prompt )
        end
    else
        Notify.Error( Ask2.err or "Couldn't send the gift" )
    end
    if Object then
        local Number = not Ask2.prompt and 0.5 or 2
        task.delay( Number, function()
            if Object.Parent then
                local Normal = Object:FindFirstChild( "Normal" )
                local Off = Object:FindFirstChild( "Off" )

                if Normal then
                    Normal.Enabled = true
                end
                if Off then
                    Off.Enabled = false
                end

                Object.AutoButtonColor = true
            end
        end )
    end

    return Ask2.ok
end
local __index = { }
__index.__index = __index
function Table.Picker( Frame, Nav )
    local Self = setmetatable( { }, __index )
    Self.frame = Frame
    Self.nav = Nav
    Self.title = Frame:FindFirstChild( "Title" )
    Self.back = Frame:WaitForChild( "Back" )
    Self.search = Frame:WaitForChild( "Search" )
    Self.list = Frame:WaitForChild( "List" )
    Self.empty = Frame:WaitForChild( "Empty" )
    local Credit = Frame:FindFirstChild( "Credit" )

    if Credit then
        Credit.Visible = false
    end

    local Templates = Frame:WaitForChild( "Templates" )
    Templates.Visible = false
    Self.rowTpl = Templates:WaitForChild( "FriendRow" )
    Self.headerTpl = Templates:FindFirstChild( "SectionHeader" )
    Self.rows = { }
    Self.headers = { }
    Self.token = 0
    Self.IsOpen = false
    Frame.Visible = false
    Self.back.Activated:Connect( function()
        Self:Close( )
    end )
    Self.search:GetPropertyChangedSignal( "Text" ):Connect( function()
        Self:filter( )
    end )
    return Self
end
function __index.filter( Argument1 )
    local Value1, Number
    local Lower = string.lower( Argument1.search.Text )
    local Table = { }
    local Rows = Argument1.rows
    Value1 = nil
    Number = 0

    for Key, Value in Rows, nil, nil do
        local Visible3

        if Lower == "" then
            Visible3 = true
        elseif string.find( Value.search, Lower, 1, true ) == nil then
            Visible3 = false
        else
            Visible3 = true
        end

        Value.frame.Visible = Visible3

        if Visible3 then
            Number = Number + 1
            Table[ Value.section or "" ] = true
        end
    end

    local Value2
    local Headers = Argument1.headers
    Value2 = nil

    for Key2, Value3 in Headers, nil, nil do
        local Visible2 = Table[ Key2 ] == true and true or false
        Value3.Visible = Visible2
    end
    if #Argument1.rows > 0 then
        local Visible
        local Empty = Argument1.empty
        Visible = Number == 0 and true or false
        Empty.Visible = Visible
        Argument1.empty.Text = "No player matches"
    end
    if Argument1.IsOpen then
        GamepadNav.Refresh( Argument1.nav )
    end
end
function __index.disarm( Argument1 )
    local Armed = Argument1.armed
    Argument1.armed = nil

    if Armed then
        Armed.undo( )
    end
end
function __index.clear( Self )
    local Value1
    Self:disarm( )
    local Rows = Self.rows
    Value1 = nil

    for Key, Value in Rows, nil, nil do
        Value.frame:Destroy( )
    end

    local Value2
    table.clear( Self.rows )
    local Headers = Self.headers
    Value2 = nil

    for Key2, Value3 in Headers, nil, nil do
        Value3:Destroy( )
    end

    table.clear( Self.headers )
end
function __index.load( Argument1 )
    Argument1.token = Argument1.token + 1
    local Token = Argument1.token
    Argument1:clear( )
    Argument1.empty.Visible = true
    Argument1.empty.Text = "Loading players..."
    local Ask2 = Ask( "friends" )

    if Token ~= Argument1.token or not Argument1.IsOpen then
        return
    end
    if not Ask2.ok then
        local Empty = Argument1.empty
        Empty.Text = Ask2.err or "Couldn't load your friends, try again"
        return
    end

    local Server2

    local function Key( Argument1 )
        local Display2
        local Display = Argument1.display

        if Display then
            Display2 = Display
        else
            local Name = Argument1.name

            if Name then
                Display2 = Name
            else
                Display2 = ""
            end
        end

        return string.lower( Display2 )
    end

    local Server = Ask2.server
    Server2 = if Server then Server else { }
    local Value2
    local Table = { }
    Value2 = nil

    for Key2, Value in Server2, nil, nil do
        Table[ Value.id ] = true
        Value.online = true
    end

    local Friends3
    local Table2 = { }
    local Friends = Ask2.friends
    Friends3 = if Friends then Friends else { }
    local Value3 = nil

    for Key3, Value4 in Friends3, nil, nil do
        if not Table[ Value4.id ] then
            table.insert( Table2, Value4 )
        end
    end

    local Value5
    table.sort( Server2, function( Argument1, Argument2 )
        local Flag = Argument1.friend == true and true or false
        local Flag2 = Argument2.friend == true and true or false

        if Flag == Flag2 then
            local Display2
            local Display = Argument1.display

            if Display then
                Display2 = Display
            else
                local Name = Argument1.name

                if Name then
                    Display2 = Name
                else
                    Display2 = ""
                end
            end

            local Display4
            local Lower = string.lower( Display2 )
            local Display3 = Argument2.display

            if Display3 then
                Display4 = Display3
            else
                local Name2 = Argument2.name

                if Name2 then
                    Display4 = Name2
                else
                    Display4 = ""
                end
            end

            local Flag4 = Lower < string.lower( Display4 ) and true or false
            return Flag4
        end
        local Flag3 = Argument1.friend == true and true or false
        return Flag3
    end )
    table.sort( Table2, function( Argument1, Argument2 )
        if Argument1.online == Argument2.online then
            local Display2
            local Display = Argument1.display

            if Display then
                Display2 = Display
            else
                local Name = Argument1.name

                if Name then
                    Display2 = Name
                else
                    Display2 = ""
                end
            end

            local Display4
            local Lower = string.lower( Display2 )
            local Display3 = Argument2.display

            if Display3 then
                Display4 = Display3
            else
                local Name2 = Argument2.name

                if Name2 then
                    Display4 = Name2
                else
                    Display4 = ""
                end
            end

            local Flag2 = Lower < string.lower( Display4 ) and true or false
            return Flag2
        end
        local Flag = Argument1.online == true and true or false
        return Flag
    end )
    local Table3 = { }
    local Table4 = { Server2, Table2 }
    Value5 = nil

    for Key4, Value6 in Table4, nil, nil do
        local Value11 = nil

        for Key7, Value12 in Value6, nil, nil do
            local Display2
            local Display = Value12.display

            if Display then
                Display2 = Display
            else
                local Name = Value12.name

                if Name then
                    Display2 = Name
                else
                    Display2 = ""
                end
            end

            local Display4
            local Lower = string.lower( Display2 )
            local Display3 = Value12.display

            if Display3 then
                Display4 = Display3
            else
                local Name2 = Value12.name

                if Name2 then
                    Display4 = Name2
                else
                    Display4 = ""
                end
            end

            Table3[ Lower ] = ( Table3[ string.lower( Display4 ) ] or 0 ) + 1
        end
    end

    local Number
    local LayoutOrder = 0

    local function Header( Key, Text )
        if Argument1.headerTpl then
            local Clone = Argument1.headerTpl:Clone( )
            Clone.Name = "Section_" .. Key
            Clone.Text = Text
            LayoutOrder = LayoutOrder + 1
            Clone.LayoutOrder = LayoutOrder
            Clone.Parent = Argument1.list
            Argument1.headers[ Key ] = Clone
            return
        end
        return
    end

    local function AddRow( Argument1Inner, RowName )
        local Visible
        local Clone = Argument1.rowTpl:Clone( )
        Clone.Name = "Friend_" .. Argument1Inner.id
        LayoutOrder = LayoutOrder + 1
        Clone.LayoutOrder = LayoutOrder
        local Avatar = Clone.Avatar
        Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. Argument1Inner.id .. "&w=150&h=150"
        local Online = Clone.Online
        Visible = Argument1Inner.online == true and true or false
        local Text
        Online.Visible = Visible
        local DisplayName = Clone.DisplayName
        local Display = Argument1Inner.display

        if Display then
            Text = Display
        else
            local Name = Argument1Inner.name

            if Name then
                Text = Name
            else
                Text = ""
            end
        end

        local Display3
        DisplayName.Text = Text
        local Display2 = Argument1Inner.display

        if Display2 then
            Display3 = Display2
        else
            local Name2 = Argument1Inner.name

            if Name2 then
                Display3 = Name2
            else
                Display3 = ""
            end
        end
        if ( Table3[ string.lower( Display3 ) ] or 0 ) > 1 and Argument1Inner.name and Argument1Inner.name ~= Argument1Inner.display then
            local DisplayName2 = Clone.DisplayName
            local Display4 = Argument1Inner.display or ""
            DisplayName2.Text = Display4 .. " (@" .. Argument1Inner.name .. ")"
        end

        local Text2
        local UserName = Clone.UserName
        local Name3 = Argument1Inner.name or ""
        Text2 = ( RowName ~= "server" or Argument1Inner.friend ~= true ) and "" or " · friend"
        UserName.Text = "@" .. Name3 .. Text2
        local Send = Clone.Send
        Send.Activated:Connect( function()
            local Text = Send:GetAttribute( "ConfirmText" )

            if type( Text ) == "string" and Text ~= "" then
                if not Argument1.armed or Argument1.armed.btn ~= Send then
                    local Text3
                    Argument1:disarm( )
                    local Text2 = Send:FindFirstChild( "Text" )

                    if Text2 then
                        local IsA = Text2:IsA( "TextLabel" )

                        if IsA then
                            Text3 = Text2.Text
                        else
                            Text3 = IsA
                        end
                    else
                        Text3 = Text2
                    end
                    if Text3 then
                        Text2.Text = Text
                    end

                    local UserName2
                    local UserName = Clone:FindFirstChild( "UserName" )
                    UserName2 = if UserName then UserName.Text else UserName

                    if UserName then
                        UserName.Text = "Tap again to gift @" .. ( Argument1Inner.name or "?" )
                    end

                    local Armed = {
                        btn = Send,
                        undo = function()
                            if Text3 and Text2.Parent then
                                Text2.Text = Text3
                            end
                            if UserName and UserName.Parent then
                                UserName.Text = UserName2
                            end
                        end
                    }
                    Argument1.armed = Armed
                    task.delay( 3, function()
                        if Argument1.armed == Armed then
                            Argument1:disarm( )
                        end
                    end )
                    return
                end
            end

            Argument1:disarm( )

            if Argument1.onSend then
                Argument1.onSend( Argument1Inner, Send )
            end
        end )
        Clone.Parent = Argument1.list
        local Rows = Argument1.rows
        local Display5 = Argument1Inner.display or ""
        table.insert( Rows, {
            frame = Clone,
            section = RowName,
            search = string.lower( Display5 .. " " .. ( Argument1Inner.name or "" ) )
        } )
    end

    if #Server2 > 0 then
        if Argument1.headerTpl then
            local Server3 = Argument1.headerTpl:Clone( )
            Server3.Name = "Section_server"
            Server3.Text = "IN THIS SERVER"
            LayoutOrder = LayoutOrder + 1
            Server3.LayoutOrder = LayoutOrder
            Server3.Parent = Argument1.list
            Argument1.headers.server = Server3
            Number = LayoutOrder
        else
            Number = LayoutOrder
        end

        local Value7 = nil

        for Key5, Value8 in Server2, nil, nil do
            AddRow( Value8, "server" )
        end
    else
        Number = LayoutOrder
    end
    if #Table2 > 0 then
        if Argument1.headerTpl then
            local Friends2 = Argument1.headerTpl:Clone( )
            Friends2.Name = "Section_friends"
            Friends2.Text = "FRIENDS"
            Friends2.LayoutOrder = Number + 1
            Friends2.Parent = Argument1.list
            Argument1.headers.friends = Friends2
        end

        local Value9 = nil

        for Key6, Value10 in Table2, nil, nil do
            AddRow( Value10, "friends" )
        end
    end

    local Visible
    local Count = #Server2 + #Table2
    local Empty2 = Argument1.empty
    Visible = Count == 0 and true or false
    Empty2.Visible = Visible
    local Empty3 = Argument1.empty
    Empty3.Text = Ask2.friendsErr or "No one to gift yet: play with others, or add friends on Roblox"

    if Count > 0 then
        Argument1:filter( )
    end

    GamepadNav.Refresh( Argument1.nav )
end
function __index.Open( Argument1, Argument2 )
    Argument1.onSend = Argument2.onSend
    Argument1.onClose = Argument2.onClose

    if Argument1.title and Argument2.title then
        local Title = Argument1.title
        Title.Text = Argument2.title
    end
    if Argument1.IsOpen then
        return
    end
    Argument1.IsOpen = true
    Argument1.frame.Visible = true
    Argument1.search.Text = ""
    GamepadNav.Open( Argument1.nav, {
        root = Argument1.frame,
        first = function()
            local Send2
            local Item = Argument1.rows[ 1 ]

            if not Item or not Item.frame.Visible then
                Send2 = Argument1.back
            else
                local Send = Item.frame:FindFirstChild( "Send" )

                if Send then
                    Send2 = Send
                else
                    Send2 = Argument1.back
                end
            end

            return Send2
        end,
        onBack = function()
            Argument1:Close( )
        end
    } )
    task.spawn( function()
        Argument1:load( )
    end )
    return
end
function __index.Close( Self )
    if not Self.IsOpen then
        return
    end

    Self.IsOpen = false
    Self.token = Self.token + 1
    Self:clear( )
    Self.frame.Visible = false
    GamepadNav.Close( Self.nav )
    local OnClose = Self.onClose
    Self.onClose = nil

    if OnClose then
        OnClose( )
    end
end
return Table
