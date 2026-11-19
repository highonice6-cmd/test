-- Players.perkbrokeyou.PlayerScripts.AirdropClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #13

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Max = math.max( 0, ( math.ceil( Argument1 ) ) )
return ( "%d:%02d" ):format( Max // 60, Max % 60 )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 then
    return
end

local Create = Upvalue3:Create( Upvalue4, TweenInfo.new( 1.2 ), { Volume = 0 } )
Create:Play( )
Create.Completed:Wait( )

if Upvalue1 == Upvalue2 then
    Upvalue4:Stop( )
    Upvalue4.Volume = 0.6
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    Upvalue1.Text = ( "Landing in %s · follow the red mark on your compass" ):format( Upvalue2( Upvalue3 - workspace:GetServerTimeNow( ) ) )
end
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

while Upvalue1 == Upvalue2 do
    if not ( os.clock( ) - Clock < Upvalue3.ALERT_TIME ) then
        break
    end
    if Upvalue4 then
        Upvalue4.Text = ( "Landing in %s · follow the red mark on your compass" ):format( Upvalue5( Upvalue6 - workspace:GetServerTimeNow( ) ) )
    end
    if Upvalue7 and Upvalue8 then
        Upvalue7.Thickness = Upvalue8 * ( ( math.sin( ( os.clock( ) - Clock ) * 8 ) * 0.5 + 0.5 ) * 0.8 + 1 )
    end

    task.wait( 0.05 )
end
if Upvalue1 ~= Upvalue2 then
    return
end
if Upvalue7 and Upvalue8 then
    Upvalue7.Thickness = Upvalue8
end
if Upvalue9:IsA( "CanvasGroup" ) then
    local Create = Upvalue10:Create( Upvalue9, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
    Create:Play( )
    Create.Completed:Wait( )
end
if Upvalue1 == Upvalue2 then
    Upvalue9.Visible = false
end
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Notices = Upvalue1:WaitForChild( "Notices", 10 )

if not Notices then
    return
end

Upvalue2 = Upvalue2 + 1
local AirdropSiren = Notices:FindFirstChild( "AirdropSiren" )

if AirdropSiren then
    AirdropSiren.Volume = 0.6
    AirdropSiren.TimePosition = 0
    AirdropSiren:Play( )
    task.delay( Upvalue3.SIREN_TIME, function()
        if Upvalue2 ~= Upvalue2 then
            return
        end

        local Create = Upvalue4:Create( AirdropSiren, TweenInfo.new( 1.2 ), { Volume = 0 } )
        Create:Play( )
        Create.Completed:Wait( )

        if Upvalue2 == Upvalue2 then
            AirdropSiren:Stop( )
            AirdropSiren.Volume = 0.6
        end
    end )
end
if Upvalue3.ALERT_BANNER == false then
    return
end

local AirdropAlert = Notices:FindFirstChild( "AirdropAlert", true )

if not AirdropAlert then
    return
end

local Title = AirdropAlert:FindFirstChild( "Title" )

if Title then
    if Title:GetAttribute( "BaseText" ) == nil then
        Title:SetAttribute( "BaseText", Title.Text )
    end

    Title.Text = Title:GetAttribute( "BaseText" )
end

local UIStroke
local UIScale = AirdropAlert:FindFirstChildOfClass( "UIScale" )
local Sub = AirdropAlert:FindFirstChild( "Sub" )
local Panel = AirdropAlert:FindFirstChild( "Panel" )

if Panel then
    UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
else
    UIStroke = Panel
end

local Panel2 = if UIStroke then UIStroke.Thickness else UIStroke

local function Countdown()
    if Sub then
        Sub.Text = ( "Landing in %s · follow the red mark on your compass" ):format( Upvalue5( Argument1 - workspace:GetServerTimeNow( ) ) )
    end
end

if Sub then
    Sub.Text = ( "Landing in %s · follow the red mark on your compass" ):format( Upvalue5( Argument1 - workspace:GetServerTimeNow( ) ) )
end

AirdropAlert.Visible = true

if AirdropAlert:IsA( "CanvasGroup" ) then
    AirdropAlert.GroupTransparency = 1
    Upvalue4:Create( AirdropAlert, TweenInfo.new( 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { GroupTransparency = 0 } ):Play( )
end
if UIScale then
    UIScale.Scale = 1.35
    Upvalue4:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
end

task.spawn( function()
    local Clock = os.clock( )

    while Upvalue2 == Upvalue2 do
        if not ( os.clock( ) - Clock < Upvalue3.ALERT_TIME ) then
            break
        end
        if Sub then
            Sub.Text = ( "Landing in %s · follow the red mark on your compass" ):format( Upvalue5( Argument1 - workspace:GetServerTimeNow( ) ) )
        end
        if UIStroke and Panel2 then
            UIStroke.Thickness = Panel2 * ( ( math.sin( ( os.clock( ) - Clock ) * 8 ) * 0.5 + 0.5 ) * 0.8 + 1 )
        end

        task.wait( 0.05 )
    end
    if Upvalue2 ~= Upvalue2 then
        return
    end
    if UIStroke and Panel2 then
        UIStroke.Thickness = Panel2
    end
    if AirdropAlert:IsA( "CanvasGroup" ) then
        local Create = Upvalue4:Create( AirdropAlert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
        Create:Play( )
        Create.Completed:Wait( )
    end
    if Upvalue2 == Upvalue2 then
        AirdropAlert.Visible = false
    end
end )
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local TopRight
local GlobalGui = Upvalue1:FindFirstChild( "GlobalGui" )

if GlobalGui then
    TopRight = GlobalGui:FindFirstChild( "TopRight" )
else
    TopRight = GlobalGui
end

local Cash

if TopRight then
    Cash = TopRight:FindFirstChild( "Cash" )
else
    Cash = TopRight
end

local Kaching

if Cash then
    Kaching = Cash:FindFirstChild( "Kaching" )
else
    Kaching = Cash
end
if not Kaching or not Kaching:IsA( "Sound" ) then
    return
end
local Clone = Kaching:Clone( )
Clone.Parent = Kaching.Parent
Clone.Ended:Once( function()
    Clone:Destroy( )
end )
Clone:Play( )
return
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:Destroy( )
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local RollTick
local Cases = Upvalue1:FindFirstChild( "Cases" )

if Cases then
    RollTick = Cases:FindFirstChild( "RollTick", true )
else
    RollTick = Cases
end
if not RollTick or not RollTick:IsA( "Sound" ) then
    return
end

local Volume
local Clone = RollTick:Clone( )
Volume = not Argument1 and 0.7 or 1.3
local PlaybackSpeed
Clone.Volume = Volume
PlaybackSpeed = not Argument1 and 1 or 0.75
local Parent
Clone.PlaybackSpeed = PlaybackSpeed
local Notices = Upvalue1:FindFirstChild( "Notices" )
Parent = if Notices then Notices else Upvalue1
Clone.Parent = Parent
Clone.Ended:Once( function()
    Clone:Destroy( )
end )
Clone:Play( )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured = Upvalue1 - Upvalue2 - workspace:GetServerTimeNow( )

if Captured > 0 then
    task.wait( Captured )
end
if Upvalue3 ~= Upvalue4 then
    return
end

local AirdropAlert
local Notices = Upvalue5:WaitForChild( "Notices", 5 )
AirdropAlert = Notices and Upvalue6.ALERT_BANNER ~= false and Notices:FindFirstChild( "AirdropAlert", true ) or nil
local Title

if AirdropAlert then
    Title = AirdropAlert:FindFirstChild( "Title" )
else
    Title = AirdropAlert
end

local Sub

if AirdropAlert then
    Sub = AirdropAlert:FindFirstChild( "Sub" )
else
    Sub = AirdropAlert
end

local UIScale

if AirdropAlert then
    UIScale = AirdropAlert:FindFirstChildOfClass( "UIScale" )
else
    UIScale = AirdropAlert
end

local Panel

if AirdropAlert then
    Panel = AirdropAlert:FindFirstChild( "Panel" )
else
    Panel = AirdropAlert
end

local UIStroke

if Panel then
    UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
else
    UIStroke = Panel
end

local Thickness = if UIStroke then UIStroke.Thickness else UIStroke

if Title and Title:GetAttribute( "BaseText" ) == nil then
    Title:SetAttribute( "BaseText", Title.Text )
end

Upvalue7 = Upvalue7 + 1

if AirdropAlert then
    if Title then
        Title.Text = Title:GetAttribute( "BaseText" )
    end

    AirdropAlert.Visible = true

    if AirdropAlert:IsA( "CanvasGroup" ) then
        AirdropAlert.GroupTransparency = 0
    end
end

local Ceil2
local Clock = os.clock( )
Ceil2 = nil

while Upvalue3 == Upvalue4 do
    if Upvalue7 ~= Upvalue7 then
        break
    end

    local Ceil = math.ceil( Upvalue1 - workspace:GetServerTimeNow( ) )

    if Ceil <= 0 then
        break
    end
    if Ceil ~= Ceil2 then
        if Title then
            Title.Text = ( "DROP IN %d" ):format( Ceil )
        end
        if Sub then
            Sub.Text = "Get ready · follow the red mark on your compass"
        end

        local Flag = Ceil <= 3 and true or false
        Upvalue8( Flag )

        if UIScale then
            local Scale = not ( Ceil <= 3 ) and 1.08 or 1.18
            UIScale.Scale = Scale
            Upvalue9:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
            Ceil2 = Ceil
        else
            Ceil2 = Ceil
        end
    end
    if UIStroke and Thickness then
        UIStroke.Thickness = Thickness * ( ( math.sin( ( os.clock( ) - Clock ) * 12 ) * 0.5 + 0.5 ) * 0.9 + 1 )
    end

    task.wait( 0.03 )
end
if Upvalue3 ~= Upvalue4 or Upvalue7 ~= Upvalue7 then
    if UIStroke and Thickness then
        UIStroke.Thickness = Thickness
    end

    return
end
local AlertSound

if Notices then
    AlertSound = Notices:FindFirstChild( "AlertSound" )
else
    AlertSound = Notices
end
if AlertSound and AlertSound:IsA( "Sound" ) then
    AlertSound.TimePosition = 0
    AlertSound:Play( )
end
if not AirdropAlert then
    return
end
if UIStroke and Thickness then
    UIStroke.Thickness = Thickness
end
if Title then
    Title.Text = "DROP LANDED"
end
if Sub then
    Sub.Text = "Hold E on the crate to open it · follow the red mark on your compass"
end
if UIScale then
    UIScale.Scale = 1.25
    Upvalue9:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
end

task.wait( 3 )

if Upvalue7 ~= Upvalue7 then
    return
end
if AirdropAlert:IsA( "CanvasGroup" ) then
    local Create = Upvalue9:Create( AirdropAlert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
    Create:Play( )
    Create.Completed:Wait( )
end
if Upvalue7 == Upvalue7 then
    AirdropAlert.Visible = false

    if Title then
        Title.Text = Title:GetAttribute( "BaseText" )
    end
end

return
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
local FINAL_COUNT = Upvalue2.FINAL_COUNT or 10
task.spawn( function()
    local Captured = Argument1 - FINAL_COUNT - workspace:GetServerTimeNow( )

    if Captured > 0 then
        task.wait( Captured )
    end
    if Upvalue1 ~= Upvalue1 then
        return
    end

    local AirdropAlert
    local Notices = Upvalue3:WaitForChild( "Notices", 5 )
    AirdropAlert = Notices and Upvalue2.ALERT_BANNER ~= false and Notices:FindFirstChild( "AirdropAlert", true ) or nil
    local Title

    if AirdropAlert then
        Title = AirdropAlert:FindFirstChild( "Title" )
    else
        Title = AirdropAlert
    end

    local Sub

    if AirdropAlert then
        Sub = AirdropAlert:FindFirstChild( "Sub" )
    else
        Sub = AirdropAlert
    end

    local UIScale

    if AirdropAlert then
        UIScale = AirdropAlert:FindFirstChildOfClass( "UIScale" )
    else
        UIScale = AirdropAlert
    end

    local Panel

    if AirdropAlert then
        Panel = AirdropAlert:FindFirstChild( "Panel" )
    else
        Panel = AirdropAlert
    end

    local UIStroke

    if Panel then
        UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
    else
        UIStroke = Panel
    end

    local Thickness = if UIStroke then UIStroke.Thickness else UIStroke

    if Title and Title:GetAttribute( "BaseText" ) == nil then
        Title:SetAttribute( "BaseText", Title.Text )
    end

    Upvalue4 = Upvalue4 + 1

    if AirdropAlert then
        if Title then
            Title.Text = Title:GetAttribute( "BaseText" )
        end

        AirdropAlert.Visible = true

        if AirdropAlert:IsA( "CanvasGroup" ) then
            AirdropAlert.GroupTransparency = 0
        end
    end

    local Ceil2
    local Clock = os.clock( )
    Ceil2 = nil

    while Upvalue1 == Upvalue1 do
        if Upvalue4 ~= Upvalue4 then
            break
        end

        local Ceil = math.ceil( Argument1 - workspace:GetServerTimeNow( ) )

        if Ceil <= 0 then
            break
        end
        if Ceil ~= Ceil2 then
            if Title then
                Title.Text = ( "DROP IN %d" ):format( Ceil )
            end
            if Sub then
                Sub.Text = "Get ready · follow the red mark on your compass"
            end

            local Flag = Ceil <= 3 and true or false
            Upvalue5( Flag )

            if UIScale then
                local Scale = not ( Ceil <= 3 ) and 1.08 or 1.18
                UIScale.Scale = Scale
                Upvalue6:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
                Ceil2 = Ceil
            else
                Ceil2 = Ceil
            end
        end
        if UIStroke and Thickness then
            UIStroke.Thickness = Thickness * ( ( math.sin( ( os.clock( ) - Clock ) * 12 ) * 0.5 + 0.5 ) * 0.9 + 1 )
        end

        task.wait( 0.03 )
    end
    if Upvalue1 ~= Upvalue1 or Upvalue4 ~= Upvalue4 then
        if UIStroke and Thickness then
            UIStroke.Thickness = Thickness
        end

        return
    end
    local AlertSound

    if Notices then
        AlertSound = Notices:FindFirstChild( "AlertSound" )
    else
        AlertSound = Notices
    end
    if AlertSound and AlertSound:IsA( "Sound" ) then
        AlertSound.TimePosition = 0
        AlertSound:Play( )
    end
    if not AirdropAlert then
        return
    end
    if UIStroke and Thickness then
        UIStroke.Thickness = Thickness
    end
    if Title then
        Title.Text = "DROP LANDED"
    end
    if Sub then
        Sub.Text = "Hold E on the crate to open it · follow the red mark on your compass"
    end
    if UIScale then
        UIScale.Scale = 1.25
        Upvalue6:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
    end

    task.wait( 3 )

    if Upvalue4 ~= Upvalue4 then
        return
    end
    if AirdropAlert:IsA( "CanvasGroup" ) then
        local Create = Upvalue6:Create( AirdropAlert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
        Create:Play( )
        Create.Completed:Wait( )
    end
    if Upvalue4 == Upvalue4 then
        AirdropAlert.Visible = false

        if Title then
            Title.Text = Title:GetAttribute( "BaseText" )
        end
    end

    return
end )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "incoming" and type( Argument2 ) == "number" then
    Upvalue1( Argument2 )
    Upvalue2 = Upvalue2 + 1
    local FINAL_COUNT = Upvalue3.FINAL_COUNT or 10
    task.spawn( function()
        local Captured = Argument2 - FINAL_COUNT - workspace:GetServerTimeNow( )

        if Captured > 0 then
            task.wait( Captured )
        end
        if Upvalue2 ~= Upvalue2 then
            return
        end

        local AirdropAlert
        local Notices = Upvalue4:WaitForChild( "Notices", 5 )
        AirdropAlert = Notices and Upvalue3.ALERT_BANNER ~= false and Notices:FindFirstChild( "AirdropAlert", true ) or nil
        local Title

        if AirdropAlert then
            Title = AirdropAlert:FindFirstChild( "Title" )
        else
            Title = AirdropAlert
        end

        local Sub

        if AirdropAlert then
            Sub = AirdropAlert:FindFirstChild( "Sub" )
        else
            Sub = AirdropAlert
        end

        local UIScale

        if AirdropAlert then
            UIScale = AirdropAlert:FindFirstChildOfClass( "UIScale" )
        else
            UIScale = AirdropAlert
        end

        local Panel

        if AirdropAlert then
            Panel = AirdropAlert:FindFirstChild( "Panel" )
        else
            Panel = AirdropAlert
        end

        local UIStroke

        if Panel then
            UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
        else
            UIStroke = Panel
        end

        local Thickness = if UIStroke then UIStroke.Thickness else UIStroke

        if Title and Title:GetAttribute( "BaseText" ) == nil then
            Title:SetAttribute( "BaseText", Title.Text )
        end

        Upvalue5 = Upvalue5 + 1

        if AirdropAlert then
            if Title then
                Title.Text = Title:GetAttribute( "BaseText" )
            end

            AirdropAlert.Visible = true

            if AirdropAlert:IsA( "CanvasGroup" ) then
                AirdropAlert.GroupTransparency = 0
            end
        end

        local Ceil2
        local Clock = os.clock( )
        Ceil2 = nil

        while Upvalue2 == Upvalue2 do
            if Upvalue5 ~= Upvalue5 then
                break
            end

            local Ceil = math.ceil( Argument2 - workspace:GetServerTimeNow( ) )

            if Ceil <= 0 then
                break
            end
            if Ceil ~= Ceil2 then
                if Title then
                    Title.Text = ( "DROP IN %d" ):format( Ceil )
                end
                if Sub then
                    Sub.Text = "Get ready · follow the red mark on your compass"
                end

                local Flag = Ceil <= 3 and true or false
                Upvalue6( Flag )

                if UIScale then
                    local Scale = not ( Ceil <= 3 ) and 1.08 or 1.18
                    UIScale.Scale = Scale
                    Upvalue7:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
                    Ceil2 = Ceil
                else
                    Ceil2 = Ceil
                end
            end
            if UIStroke and Thickness then
                UIStroke.Thickness = Thickness * ( ( math.sin( ( os.clock( ) - Clock ) * 12 ) * 0.5 + 0.5 ) * 0.9 + 1 )
            end

            task.wait( 0.03 )
        end
        if Upvalue2 ~= Upvalue2 or Upvalue5 ~= Upvalue5 then
            if UIStroke and Thickness then
                UIStroke.Thickness = Thickness
            end

            return
        end
        local AlertSound

        if Notices then
            AlertSound = Notices:FindFirstChild( "AlertSound" )
        else
            AlertSound = Notices
        end
        if AlertSound and AlertSound:IsA( "Sound" ) then
            AlertSound.TimePosition = 0
            AlertSound:Play( )
        end
        if not AirdropAlert then
            return
        end
        if UIStroke and Thickness then
            UIStroke.Thickness = Thickness
        end
        if Title then
            Title.Text = "DROP LANDED"
        end
        if Sub then
            Sub.Text = "Hold E on the crate to open it · follow the red mark on your compass"
        end
        if UIScale then
            UIScale.Scale = 1.25
            Upvalue7:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end

        task.wait( 3 )

        if Upvalue5 ~= Upvalue5 then
            return
        end
        if AirdropAlert:IsA( "CanvasGroup" ) then
            local Create = Upvalue7:Create( AirdropAlert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
            Create:Play( )
            Create.Completed:Wait( )
        end
        if Upvalue5 == Upvalue5 then
            AirdropAlert.Visible = false

            if Title then
                Title.Text = Title:GetAttribute( "BaseText" )
            end
        end

        return
    end )
    return
end
if Name == "cash" then
    Upvalue8( )
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local AirdropLandAt = Upvalue1:GetAttribute( "AirdropLandAt" )

if type( AirdropLandAt ) == "number" and Upvalue1:GetAttribute( "AirdropLanded" ) ~= true and AirdropLandAt - workspace:GetServerTimeNow( ) > 1 then
    Upvalue2 = Upvalue2 + 1
    local FINAL_COUNT = Upvalue3.FINAL_COUNT or 10
    task.spawn( function()
        local Captured = AirdropLandAt - FINAL_COUNT - workspace:GetServerTimeNow( )

        if Captured > 0 then
            task.wait( Captured )
        end
        if Upvalue2 ~= Upvalue2 then
            return
        end

        local AirdropAlert
        local Notices = Upvalue4:WaitForChild( "Notices", 5 )
        AirdropAlert = Notices and Upvalue3.ALERT_BANNER ~= false and Notices:FindFirstChild( "AirdropAlert", true ) or nil
        local Title

        if AirdropAlert then
            Title = AirdropAlert:FindFirstChild( "Title" )
        else
            Title = AirdropAlert
        end

        local Sub

        if AirdropAlert then
            Sub = AirdropAlert:FindFirstChild( "Sub" )
        else
            Sub = AirdropAlert
        end

        local UIScale

        if AirdropAlert then
            UIScale = AirdropAlert:FindFirstChildOfClass( "UIScale" )
        else
            UIScale = AirdropAlert
        end

        local Panel

        if AirdropAlert then
            Panel = AirdropAlert:FindFirstChild( "Panel" )
        else
            Panel = AirdropAlert
        end

        local UIStroke

        if Panel then
            UIStroke = Panel:FindFirstChildOfClass( "UIStroke" )
        else
            UIStroke = Panel
        end

        local Thickness = if UIStroke then UIStroke.Thickness else UIStroke

        if Title and Title:GetAttribute( "BaseText" ) == nil then
            Title:SetAttribute( "BaseText", Title.Text )
        end

        Upvalue5 = Upvalue5 + 1

        if AirdropAlert then
            if Title then
                Title.Text = Title:GetAttribute( "BaseText" )
            end

            AirdropAlert.Visible = true

            if AirdropAlert:IsA( "CanvasGroup" ) then
                AirdropAlert.GroupTransparency = 0
            end
        end

        local Ceil2
        local Clock = os.clock( )
        Ceil2 = nil

        while Upvalue2 == Upvalue2 do
            if Upvalue5 ~= Upvalue5 then
                break
            end

            local Ceil = math.ceil( AirdropLandAt - workspace:GetServerTimeNow( ) )

            if Ceil <= 0 then
                break
            end
            if Ceil ~= Ceil2 then
                if Title then
                    Title.Text = ( "DROP IN %d" ):format( Ceil )
                end
                if Sub then
                    Sub.Text = "Get ready · follow the red mark on your compass"
                end

                local Flag = Ceil <= 3 and true or false
                Upvalue6( Flag )

                if UIScale then
                    local Scale = not ( Ceil <= 3 ) and 1.08 or 1.18
                    UIScale.Scale = Scale
                    Upvalue7:Create( UIScale, TweenInfo.new( 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
                    Ceil2 = Ceil
                else
                    Ceil2 = Ceil
                end
            end
            if UIStroke and Thickness then
                UIStroke.Thickness = Thickness * ( ( math.sin( ( os.clock( ) - Clock ) * 12 ) * 0.5 + 0.5 ) * 0.9 + 1 )
            end

            task.wait( 0.03 )
        end
        if Upvalue2 ~= Upvalue2 or Upvalue5 ~= Upvalue5 then
            if UIStroke and Thickness then
                UIStroke.Thickness = Thickness
            end

            return
        end
        local AlertSound

        if Notices then
            AlertSound = Notices:FindFirstChild( "AlertSound" )
        else
            AlertSound = Notices
        end
        if AlertSound and AlertSound:IsA( "Sound" ) then
            AlertSound.TimePosition = 0
            AlertSound:Play( )
        end
        if not AirdropAlert then
            return
        end
        if UIStroke and Thickness then
            UIStroke.Thickness = Thickness
        end
        if Title then
            Title.Text = "DROP LANDED"
        end
        if Sub then
            Sub.Text = "Hold E on the crate to open it · follow the red mark on your compass"
        end
        if UIScale then
            UIScale.Scale = 1.25
            Upvalue7:Create( UIScale, TweenInfo.new( 0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end

        task.wait( 3 )

        if Upvalue5 ~= Upvalue5 then
            return
        end
        if AirdropAlert:IsA( "CanvasGroup" ) then
            local Create = Upvalue7:Create( AirdropAlert, TweenInfo.new( 0.5 ), { GroupTransparency = 1 } )
            Create:Play( )
            Create.Completed:Wait( )
        end
        if Upvalue5 == Upvalue5 then
            AirdropAlert.Visible = false

            if Title then
                Title.Text = Title:GetAttribute( "BaseText" )
            end
        end

        return
    end )
end
]]
