-- Players.perkbrokeyou.PlayerScripts.OutfitCodeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local Screens = require( ReplicatedStorage:WaitForChild( "Screens" ) )
local CodeCopy = require( ReplicatedStorage:WaitForChild( "CodeCopy" ) )
local OutfitCode = ReplicatedStorage:WaitForChild( "Wardrobe" ):WaitForChild( "OutfitCode", math.huge )
local OutfitApi = script.Parent:WaitForChild( "WardrobeClient" ):WaitForChild( "OutfitApi", math.huge )
local Get = Screens.Get( "Wardrobe" )
local OutfitCode2 = Get:WaitForChild( "OutfitCode" )
local Window = OutfitCode2:WaitForChild( "Window" )
local CodeButton = Get:WaitForChild( "Main" ):WaitForChild( "Equipped" ):WaitForChild( "CodeButton" )
local MyCode = Window:WaitForChild( "MyCode" )
local CreateButton = Window:WaitForChild( "CreateButton" )
local CodeBox = Window:WaitForChild( "CodeBox" )
local WearButton = Window:WaitForChild( "WearButton" )
local Status = Window:WaitForChild( "Status" )
local Close = Window:WaitForChild( "Close" )
local CopyButton = Window:FindFirstChild( "CopyButton" )
local Hint = Window:FindFirstChild( "Hint" )

if Hint then
    Hint.Text = CodeCopy.Hint( )
end

OutfitCode2.Visible = false
Status.RichText = true

local function Say( Name, Argument2 )
    local Text2

    if Name == "" then
        Text2 = ""
    else
        local Text = not Argument2 and "e23a42" or "46c86e"
        Text2 = ( "<font color=\"#%s\">%s</font>" ):format( Text, Name )
    end

    Status.Text = Text2
end

local function KeyOf( Argument1 )
    local Items2
    local Items = Argument1.items
    Items2 = if Items then Items else { }
    local Clone = table.clone( Items2 )
    table.sort( Clone )
    local Text = tostring( Argument1.body )
    return Text .. ";" .. table.concat( Clone, "," )
end

local Table = { }

local function Current()
    local Result2
    local Success, Result = pcall( OutfitApi.Invoke, OutfitApi, "Get" )
    Result2 = Success and type( Result ) == "table" and Result or nil
    return Result2
end

local Flag = false

local function SetOpen( Visible )
    if Flag == Visible then
        return
    end

    Flag = Visible
    OutfitCode2.Visible = Visible

    if Visible then
        local Result2
        Status.Text = ""
        local Success, Result = pcall( OutfitApi.Invoke, OutfitApi, "Get" )
        Result2 = Success and type( Result ) == "table" and Result or nil
        local Text

        if Result2 then
            local Entry = Table[ KeyOf( Result2 ) ]

            if Entry then
                Text = Entry
            else
                Text = ""
            end
        else
            Text = ""
        end

        MyCode.Text = Text
        GamepadNav.Open( "OutfitCode", {
            root = Window,
            freezeKeyboard = true,
            first = function()
                return CreateButton
            end,
            onBack = function()
                SetOpen( false )
            end,
            backLabel = "Close"
        } )
        return
    end
    if CodeBox:IsFocused( ) then
        CodeBox:ReleaseFocus( )
    end
    if MyCode:IsFocused( ) then
        MyCode:ReleaseFocus( )
    end

    GamepadNav.Close( "OutfitCode" )
    return
end

CodeButton.Activated:Connect( function()
    SetOpen( not Flag )
end )
Close.Activated:Connect( function()
    if Flag == false then
        return
    end

    Flag = false
    OutfitCode2.Visible = false

    if CodeBox:IsFocused( ) then
        CodeBox:ReleaseFocus( )
    end
    if MyCode:IsFocused( ) then
        MyCode:ReleaseFocus( )
    end

    GamepadNav.Close( "OutfitCode" )
end )
Get:GetPropertyChangedSignal( "Visible" ):Connect( function()
    if not Get.Visible then
        if Flag == false then
            return
        end

        Flag = false
        OutfitCode2.Visible = false

        if CodeBox:IsFocused( ) then
            CodeBox:ReleaseFocus( )
        end
        if MyCode:IsFocused( ) then
            MyCode:ReleaseFocus( )
        end

        GamepadNav.Close( "OutfitCode" )
    end
end )
local Flag2 = false

local function MakeCode()
    local Result2
    local Success, Result = pcall( OutfitApi.Invoke, OutfitApi, "Get" )
    Result2 = Success and type( Result ) == "table" and Result or nil

    if not Result2 then
        Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Try again" )
        return nil
    end

    local Text4
    local KeyOf2 = KeyOf( Result2 )
    local Entry = Table[ KeyOf2 ]

    if Entry then
        Text4 = Entry
    else
        Flag2 = true
        Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "..." )
        local InvokeServer = OutfitCode.InvokeServer
        local Items = Result2.items
        local Success2, Result3, Success3 = pcall( InvokeServer, OutfitCode, "Create", Items, Result2.body )
        Flag2 = false

        if not Success2 or type( Result3 ) ~= "string" then
            local Text2

            if Success2 then
                local Text = tostring( Success3 or "Try again" )

                if Text then
                    Text2 = Text
                else
                    Text2 = "Try again"
                end
            else
                Text2 = "Try again"
            end

            local Text3

            if Text2 == "" then
                Text3 = ""
            else
                Text3 = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", Text2 )
            end

            Status.Text = Text3
            return nil
        end
        Table[ KeyOf2 ] = Result3
        Text4 = Result3
    end

    MyCode.Text = Text4
    return Text4
end

CreateButton.Activated:Connect( function()
    if Flag2 then
        return
    end
    if MakeCode( ) then
        Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Share this code with your friends!" )
    end
end )

if CopyButton then
    CopyButton.Activated:Connect( function()
        if Flag2 then
            return
        end

        local Result2
        local Success, Result = pcall( OutfitApi.Invoke, OutfitApi, "Get" )
        Result2 = Success and type( Result ) == "table" and Result or nil
        local Text

        if Result2 then
            local Entry = Table[ KeyOf( Result2 ) ]

            if Entry then
                Text = Entry
            else
                Text = MakeCode( )
            end
        else
            Text = MakeCode( )
        end
        if not Text then
            return
        end

        MyCode.Text = Text
        local Select = CodeCopy.Select( MyCode, function()
            Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Copied!" )
        end )

        if Select then
            local Text2

            if Select == "" then
                Text2 = ""
            else
                Text2 = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", Select )
            end

            Status.Text = Text2
        end
    end )
end

local function Wear()
    if Flag2 then
        return
    end

    local Text = CodeBox.Text

    if Text:gsub( "[%s%-]", "" ) == "" then
        Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", "Enter a code first" )
        return
    end

    Flag2 = true
    Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "..." )
    local Success, Result, Success3 = pcall( OutfitCode.InvokeServer, OutfitCode, "Get", Text )

    if not Success or type( Result ) ~= "table" then
        local Text8
        Flag2 = false

        if Success then
            local Text7 = tostring( Success3 or "Code not found" )

            if Text7 then
                Text8 = Text7
            else
                Text8 = "Try again"
            end
        else
            Text8 = "Try again"
        end

        local Text9

        if Text8 == "" then
            Text9 = ""
        else
            Text9 = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", Text8 )
        end

        Status.Text = Text9
        return
    end
    local Invoke = OutfitApi.Invoke
    local I = Result.i
    local Success2, Result2, Success32 = pcall( Invoke, OutfitApi, "Wear", I, Result.b )
    Flag2 = false

    if not Success2 or type( Result2 ) ~= "number" then
        local Text5

        if Success2 then
            local Text4 = tostring( Success32 or "Try again" )

            if Text4 then
                Text5 = Text4
            else
                Text5 = "Try again"
            end
        else
            Text5 = "Try again"
        end

        local Text6

        if Text5 == "" then
            Text6 = ""
        else
            Text6 = ( "<font color=\"#%s\">%s</font>" ):format( "e23a42", Text5 )
        end

        Status.Text = Text6
        return
    end
    CodeBox.Text = ""

    if not ( Result2 > 0 ) then
        Status.Text = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", "Outfit applied! Save it to keep it" )
        return
    end

    local Text2 = not ( Result2 > 1 ) and "" or "s"
    local Text3
    local Format = ( "Outfit applied, %d item%s locked" ):format( Result2, Text2 )

    if Format == "" then
        Text3 = ""
    else
        Text3 = ( "<font color=\"#%s\">%s</font>" ):format( "46c86e", Format )
    end

    Status.Text = Text3
    return
end

WearButton.Activated:Connect( Wear )
CodeBox.FocusLost:Connect( function( Argument1 )
    if Argument1 then
        Wear( )
    end
end )
