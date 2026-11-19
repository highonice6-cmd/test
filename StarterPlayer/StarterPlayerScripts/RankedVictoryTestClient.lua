-- StarterPlayer.StarterPlayerScripts.RankedVictoryTestClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #21

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1:GetAttribute( "RankedPose" ) ~= Argument1 or Upvalue1:GetAttribute( "RankedAimPitch" ) ~= Argument2 then
    Upvalue1:SetAttribute( "RankedPose", Argument1 )
    Upvalue1:SetAttribute( "RankedAimPitch", Argument2 )
    task.wait( 0.45 )
end

return Upvalue2.Capture( Upvalue1 )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    return
end

Upvalue1 = true
Upvalue2 = Name
Upvalue3 = true
local InvokeServer, InvokeServer2 = Upvalue4:InvokeServer( "prepare" )
local Character = Upvalue5.Character

if not InvokeServer or not Character then
    warn( "[VictoryTest] scène introuvable (dossier VictoryScene de la map) ou perso absent" )
else
    local Number = Name ~= "2v2" and 5 or 2
    local InvokeServer22
    local Table = { }
    local Table2 = {
        { rk = "Champion", dv = 2, kills = 14, deaths = 3 },
        { rk = "Diamond", dv = 3, vip = true },
        { rk = "Gold", dv = 1, tag = "UR" },
        { rk = "Silver", dv = 2 },
        { rk = "Ruby", dv = 1, vip = true, tag = "NYX" }
    }
    InvokeServer22 = if InvokeServer2 then InvokeServer2 else { }

    local function Shot( Argument1, Argument2 )
        if Character:GetAttribute( "RankedPose" ) ~= Argument1 or Character:GetAttribute( "RankedAimPitch" ) ~= Argument2 then
            Character:SetAttribute( "RankedPose", Argument1 )
            Character:SetAttribute( "RankedAimPitch", Argument2 )
            task.wait( 0.45 )
        end

        return Upvalue6.Capture( Character )
    end

    local Table3 = { "Low" }

    if math.random( ) < 0.5 then
    end

    local I = 2

    for I = 2, Number do
        Table3[ I ] = "Low"
    end

    local Table4 = { }
    local I2 = 1

    for I2 = 1, Number do
        if Table3[ I2 ] == "Low" then
            Table4[ I2 ] = Shot( "Low", nil )
        end
    end

    local I3 = 1

    for I3 = 1, Number do
        if Table3[ I3 ] == "Aim" then
            Table4[ I3 ] = Shot( "Aim", nil )
        end
    end

    local MvpRaise2
    local MvpRaise = Upvalue6.MvpRaise
    MvpRaise2 = if MvpRaise then Upvalue6.MvpRaise( ) else MvpRaise
    local Shot3

    if not MvpRaise2 or not Table4[ 1 ] then
        Shot3 = nil
    else
        local AimPitch2

        if Upvalue6.AimPitch then
            local AimPitch = Upvalue6.AimPitch( Table4[ 1 ] )

            if AimPitch then
                AimPitch2 = AimPitch
            else
                AimPitch2 = 0
            end
        else
            AimPitch2 = 0
        end

        local Shot2 = Shot( "Aim", AimPitch2 )

        if Shot2 then
            Shot3 = Shot2
        else
            Shot3 = nil
        end
    end

    Upvalue7 = Table4[ 1 ]

    if Character.Parent then
        Character:SetAttribute( "RankedPose", nil )
        Character:SetAttribute( "RankedAimPitch", nil )
    end

    local I4 = 1

    for I4 = 1, Number do
        local Entry2
        local Entry = Table2[ I4 ]
        Entry2 = if Entry then Entry else { }
        local CaptureAim
        local Table5 = { capture = Table4[ I4 ] }
        CaptureAim = if I4 ~= 1 or not Shot3 then nil else Shot3
        local Text
        Table5.captureAim = CaptureAim
        local DisplayName = Upvalue5.DisplayName
        Text = I4 > 1 and " " .. I4 or ""
        local Mvp
        Table5.name = DisplayName .. Text
        Mvp = I4 == 1 and true or false
        Table5.mvp = Mvp
        Table5.rk = Entry2.rk
        Table5.dv = Entry2.dv
        Table5.kills = Entry2.kills
        Table5.deaths = Entry2.deaths

        if I4 == 1 then
            local Tag = InvokeServer22.tag
            local Cc = InvokeServer22.cc
            local Cid = InvokeServer22.cid
            local Vip = InvokeServer22.vip
            local Dev = InvokeServer22.dev
            Table5.tag = Tag
            Table5.cc = Cc
            Table5.cid = Cid
            Table5.vip = Vip
            Table5.dev = Dev
        else
            local Tag2 = Entry2.tag
            local Cc2 = InvokeServer22.cc
            local Vip2 = Entry2.vip
            Table5.tag = Tag2
            Table5.cc = Cc2
            Table5.vip = Vip2
        end

        table.insert( Table, Table5 )
    end

    local Flag = Name2 == "Defaite" and true or false
    local Score
    local Play = Upvalue6.Play
    local Table6 = { outcome = Name2 }
    Score = not Flag and "5 - 2" or "2 - 5"
    Table6.score = Score
    Table6.reason = "RANKED " .. Name:upper( )
    pcall( Play, InvokeServer, Name, Table, Table6 )
    pcall( Upvalue4.InvokeServer, Upvalue4, "done" )
end

Upvalue1 = false
Upvalue3 = false
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2, Upvalue3 )
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
local TextButton = Instance.new( "TextButton" )
TextButton.AnchorPoint = Vector2.new( 1, 1 )
TextButton.Position = UDim2.fromScale( 0.99, Argument2 )
TextButton.Size = UDim2.fromScale( 0.12, 0.05 )
TextButton.BackgroundColor3 = Color3.fromRGB( 205, 160, 40 )
TextButton.FontFace = Font.new( "rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold )
TextButton.TextColor3 = Color3.new( 0, 0, 0 )
TextButton.TextScaled = true
Text = Name ~= "Defaite" and "TEST VICTOIRE " or "TEST DÉFAITE "
TextButton.Text = Text .. Argument1:upper( )
TextButton.Parent = Upvalue1
TextButton.Activated:Connect( function()
    Upvalue2( Argument1, Name )
end )
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
local Parent = Instance.new( "Frame" )
Parent.BackgroundTransparency = 1
Parent.Size = UDim2.fromScale( 1, 0.1 )
Parent.LayoutOrder = Upvalue1
Parent.Parent = Upvalue2

if Amount and Amount > 1 then
    local UIListLayout = Instance.new( "UIListLayout" )
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new( 0.02, 0 )
    UIListLayout.Parent = Parent
end

return Parent
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( Upvalue2 )
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local TextButton = Instance.new( "TextButton" )
TextButton.Size = UDim2.fromScale( Amount or 1, 1 )
TextButton.BackgroundColor3 = Color3.fromRGB( 205, 160, 40 )
TextButton.TextColor3 = Color3.new( 0, 0, 0 )
TextButton.TextScaled = true
TextButton.FontFace = Font.new( "rbxasset://fonts/families/Merriweather.json", Enum.FontWeight.Bold )
TextButton.AutoLocalize = false
TextButton.Text = Text
Upvalue1 = Upvalue1 + 1
TextButton.LayoutOrder = Upvalue1
TextButton.Parent = Parent
TextButton.Activated:Connect( function()
    Argument4( TextButton )
end )
return TextButton
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute2 = Upvalue1:GetAttribute( Attribute )

if Attribute2 == nil then
    return Argument2
end
return Attribute2
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpYawOffset = Upvalue2:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
local MvpPitchOffset = Upvalue2:GetAttribute( "MvpPitchOffset" )
Number2 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue2:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue1.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number, Number2, Text )
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2

if Upvalue2 then
    local Entry = Upvalue3[ Upvalue4 or "5v5" ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = 9.4
    end
else
    Entry2 = nil
end

Upvalue1:SetAttribute( "DebugVictoryAt", Entry2 )
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Character = Upvalue1.Character

if Upvalue2 or not Character or not Upvalue3 or not Upvalue4._mvp then
    return
end

Upvalue2 = true
Character:SetAttribute( "RankedAimPitch", Upvalue4.AimPitch( Upvalue3 ) )
Character:SetAttribute( "RankedPose", "Aim" )
task.wait( 0.45 )
local Success, Result = pcall( Upvalue4.Capture, Character )
Character:SetAttribute( "RankedPose", nil )
Character:SetAttribute( "RankedAimPitch", nil )

if Success and Result then
    Upvalue4.DebugSwapAim( Result )
end

Upvalue2 = false
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Text
Upvalue1 = not Upvalue1
Text = not Upvalue1 and "NON" or "OUI"
local Entry2
Argument1.Text = "FIGÉ SUR LE MVP : " .. Text

if Upvalue1 then
    local Entry = Upvalue3[ Upvalue4 or "5v5" ]

    if Entry then
        Entry2 = Entry
    else
        Entry2 = 9.4
    end
else
    Entry2 = nil
end

Upvalue2:SetAttribute( "DebugVictoryAt", Entry2 )
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
Upvalue1:SetAttribute( "MvpYawOffset", Number - 5 )
Upvalue2.DebugApplyYaw( )
local MvpYawOffset2 = Upvalue1:GetAttribute( "MvpYawOffset" )
Number2 = if MvpYawOffset2 == nil then 0 else MvpYawOffset2
local Number3
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number3 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue3.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number2, Number3, Text )
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
Upvalue1:SetAttribute( "MvpYawOffset", Number + 5 )
Upvalue2.DebugApplyYaw( )
local MvpYawOffset2 = Upvalue1:GetAttribute( "MvpYawOffset" )
Number2 = if MvpYawOffset2 == nil then 0 else MvpYawOffset2
local Number3
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number3 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue3.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number2, Number3, Text )
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Number2
Upvalue1:SetAttribute( "MvpPitchOffset", Number + 2 )
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number2 = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number3
local MvpPitchOffset2 = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number3 = if MvpPitchOffset2 == nil then 0 else MvpPitchOffset2
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue2.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number2, Number3, Text )
task.spawn( Upvalue3 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Number2
Upvalue1:SetAttribute( "MvpPitchOffset", Number - 2 )
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number2 = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number3
local MvpPitchOffset2 = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number3 = if MvpPitchOffset2 == nil then 0 else MvpPitchOffset2
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue2.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number2, Number3, Text )
task.spawn( Upvalue3 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Flag2 = Flag == false and true or false
local Number
Upvalue1:SetAttribute( "MvpAutoAim", Flag2 )
Upvalue2.DebugApplyYaw( )
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number2 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag3
local MvpAutoAim2 = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag3 = if MvpAutoAim2 == nil then true else MvpAutoAim2
local Text = Flag3 == false and "NON" or "OUI"
Upvalue3.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number, Number2, Text )
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
Upvalue1:SetAttribute( "MvpYawOffset", nil )
Upvalue1:SetAttribute( "MvpPitchOffset", nil )
Upvalue1:SetAttribute( "MvpAutoAim", nil )
Upvalue2.DebugApplyYaw( )
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number2 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue3.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number, Number2, Text )
task.spawn( Upvalue4 )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Number
local MvpYawOffset = Upvalue1:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
local MvpPitchOffset = Upvalue1:GetAttribute( "MvpPitchOffset" )
Number2 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue1:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Flag2 = Flag ~= false and true or false
print( ( "[Réglage MVP] à mettre en attributs de ReplicatedStorage.RankedShared.VictoryScene : MvpYawOffset = %d, MvpPitchOffset = %d, MvpAutoAim = %s" ):format( Number, Number2, ( tostring( Flag2 ) ) ) )
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Parent then
    Upvalue2.Enabled = false
    Upvalue3:SetAttribute( "DebugVictoryAt", nil )
end
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.Name ~= "RankedVictoryScene" then
    return
end
if not Upvalue1.MvpRaise or not Upvalue1.MvpRaise( ) then
    return
end
if Upvalue2 then
    local Entry2

    if Upvalue4 then
        local Entry = Upvalue5[ Upvalue6 or "5v5" ]

        if Entry then
            Entry2 = Entry
        else
            Entry2 = 9.4
        end
    else
        Entry2 = nil
    end

    Upvalue3:SetAttribute( "DebugVictoryAt", Entry2 )
end

local Number
task.wait( 0.2 )
local MvpYawOffset = Upvalue8:GetAttribute( "MvpYawOffset" )
Number = if MvpYawOffset == nil then 0 else MvpYawOffset
local Number2
local MvpPitchOffset = Upvalue8:GetAttribute( "MvpPitchOffset" )
Number2 = if MvpPitchOffset == nil then 0 else MvpPitchOffset
local Flag
local MvpAutoAim = Upvalue8:GetAttribute( "MvpAutoAim" )
Flag = if MvpAutoAim == nil then true else MvpAutoAim
local Text = Flag == false and "NON" or "OUI"
Upvalue7.Text = ( "rotation %+d° | hauteur %+d° | auto %s" ):format( Number, Number2, Text )
Upvalue9.Enabled = true
Argument1.AncestryChanged:Connect( function()
    if not Argument1.Parent then
        Upvalue9.Enabled = false
        Upvalue3:SetAttribute( "DebugVictoryAt", nil )
    end
end )
]]
