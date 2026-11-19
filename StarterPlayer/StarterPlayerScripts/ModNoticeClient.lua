-- StarterPlayer.StarterPlayerScripts.ModNoticeClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local TweenService = game:GetService( "TweenService" )
local ContextActionService = game:GetService( "ContextActionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local ModNotice = ReplicatedStorage:WaitForChild( "Remotes" ):WaitForChild( "ModNotice" )
local LocalPlayer = Players.LocalPlayer
local GamepadNav = require( ReplicatedStorage:WaitForChild( "GamepadNav" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Get = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Screens" ) ).Get( "ModNotice" )
Get.Visible = false
local Panel = Get:WaitForChild( "Panel" )
local Body = Panel:WaitForChild( "Body" )
local OK = Panel:WaitForChild( "OK" )
local Text = OK:WaitForChild( "Text" )
local Size = Panel.Size
local Number = 0
local Number2 = math.huge

local function Hide()
    Number = Number + 1
    Number2 = math.huge
    Get.Visible = false
    GamepadNav.Close( "ModNotice" )
    ContextActionService:UnbindAction( "ModNoticeBlock" )

    if not ClientState.WardrobeOpen then
        ClientState.CursorFree = false
    end
end

OK.Activated:Connect( function()
    if not Get.Visible or os.clock( ) < Number2 then
        return
    end

    ModNotice:FireServer( "ok" )
    Number = Number + 1
    Number2 = math.huge
    Get.Visible = false
    GamepadNav.Close( "ModNotice" )
    ContextActionService:UnbindAction( "ModNoticeBlock" )

    if not ClientState.WardrobeOpen then
        ClientState.CursorFree = false
    end
end )
ModNotice.OnClientEvent:Connect( function( TextInner, Text2 )
    if type( TextInner ) == "string" then
        Number = Number + 1
        local NumberInner = tonumber( Text2 ) or 3
        Number2 = os.clock( ) + NumberInner
        Body.Text = TextInner
        ClientState.ActiveMenu = "ModNotice"
        ClientState.CursorFree = true
        Get.Visible = true
        Panel.Size = UDim2.fromScale( Size.X.Scale * 0.9, Size.Y.Scale * 0.9 )
        TweenService:Create( Panel, TweenInfo.new( 0.18, Enum.EasingStyle.Back ), { Size = Size } ):Play( )
        ContextActionService:BindActionAtPriority( "ModNoticeBlock", function()
            return Enum.ContextActionResult.Sink
        end, false, 3500, Enum.UserInputType.Keyboard )
        GamepadNav.Open( "ModNotice", {
            root = Panel,
            first = OK,
            onBack = function()
            end,
            freeze = true,
            freezeKeyboard = true,
            selectLabel = "OK"
        } )
        task.spawn( function()
            while Number == Number do
                if not ( os.clock( ) < Number2 ) then
                    break
                end

                Text.Text = ( "OK (%d)" ):format( ( math.ceil( Number2 - os.clock( ) ) ) )
                task.wait( 0.1 )
            end
            if Number == Number then
                Text.Text = "OK"
            end
        end )
        return
    end
    return
end )
