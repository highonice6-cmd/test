-- ReplicatedFirst.LoadingScreen.Fond.Saison.Animation
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Parent = script.Parent

if not Parent:FindFirstAncestorWhichIsA( "PlayerGui" ) then
    return
end

local Brillance2
local RunService = game:GetService( "RunService" )
local TweenService = game:GetService( "TweenService" )
local LayerCollector = Parent:FindFirstAncestorWhichIsA( "LayerCollector" )
local Table = { }

local function Ajoute( Object, Argument2 )
    local Balayage

    if Object then
        Balayage = Object:FindFirstChild( "Balayage" )
    else
        Balayage = Object
    end
    if Balayage and Balayage:IsA( "UIGradient" ) then
        table.insert( Table, { el = Object, g = Balayage, biais = Argument2 } )
    end
end

local Brillance = Parent:FindFirstChild( "Brillance" )
Brillance2 = if Brillance then Brillance:FindFirstChild( "Forme" ) else Brillance
local Titre
Ajoute( Brillance2, true )
Ajoute( Parent:FindFirstChild( "MotReflet" ), false )
Ajoute( Parent:FindFirstChild( "ChiffreReflet" ), false )
local Parent2 = Parent.Parent

if Parent2 then
    Titre = Parent.Parent:FindFirstChild( "Titre" )
else
    Titre = Parent2
end

local Parent3 = if Titre then Titre:FindFirstChild( "Reflet" ) else Titre
local Value1
Ajoute( Parent3, false )
local Table2 = { }
local Table3 = { "Chiffre", "ChiffreReflet" }
Value1 = nil

for Key, Value in Table3, nil, nil do
    local Echelle2
    local FoundChild = Parent:FindFirstChild( Value )

    if FoundChild then
        Echelle2 = FoundChild:FindFirstChild( "Echelle" )
    else
        Echelle2 = FoundChild
    end
    if Echelle2 and Echelle2:IsA( "UIScale" ) then
        table.insert( Table2, { e = Echelle2, haut = 1.14 } )
    end
end

local Echelle

if Titre then
    Echelle = Titre:FindFirstChild( "Echelle" )
else
    Echelle = Titre
end
if Echelle and Echelle:IsA( "UIScale" ) then
    table.insert( Table2, { e = Echelle, haut = 1.04 } )
end

local function Largeur( Argument1 )
    local X2
    local X = Argument1.el.AbsoluteSize.X
    X2 = if Argument1.biais then X / math.cos( ( math.rad( Argument1.el.Rotation ) ) ) else X
    return X2
end

local function Centre( Argument1 )
    return Argument1.el.AbsolutePosition.X + Argument1.el.AbsoluteSize.X / 2
end

local function Poser( Argument1 )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local X2
        local X = Value.el.AbsoluteSize.X
        X2 = if Value.biais then X / math.cos( ( math.rad( Value.el.Rotation ) ) ) else X

        if X2 > 0 then
            local G = Value.g
            G.Offset = Vector2.new( ( Argument1 - ( Value.el.AbsolutePosition.X + Value.el.AbsoluteSize.X / 2 ) ) / X2, 0 )
        end
    end
end

local function Bornes()
    local Value1, Number, Number2
    Value1 = nil
    Number = math.huge
    Number2 = -math.huge

    for Key, Value in Table, nil, nil do
        local X3
        local X = Value.el.AbsolutePosition.X + Value.el.AbsoluteSize.X / 2
        local X2 = Value.el.AbsoluteSize.X
        X3 = if Value.biais then X2 / math.cos( ( math.rad( Value.el.Rotation ) ) ) else X2
        Number = math.min( Number, X - X3 / 2 )
        Number2 = math.max( Number2, X + X3 / 2 )
    end

    return Number, Number2
end

local function Visible()
    if not LayerCollector or not LayerCollector.Parent or not LayerCollector.Enabled then
        return false
    end

    local Captured = Parent

    while Captured do
        if Captured == LayerCollector then
            break
        end
        if Captured:IsA( "GuiObject" ) and not Captured.Visible then
            return false
        end

        Captured = Captured.Parent
    end

    return true
end

local function Balayer()
    if #Table == 0 then
        return
    end

    local Value1, Value2 = Bornes( )

    if Value1 == math.huge then
        return
    end

    local Total = ( Value2 - Value1 ) * 0.12
    local Total2 = Value1 - Total
    local Total3 = Value2 + Total
    local Number = tonumber( Parent:GetAttribute( "DureeReflet" ) ) or 0.9
    local Clock = os.clock( )
    local Flag = false
    local Connect = nil
    Connect = RunService.RenderStepped:Connect( function()
        local Clamp = math.clamp( ( os.clock( ) - Clock ) / Number, 0, 1 )
        Poser( Total2 + ( Total3 - Total2 ) * TweenService:GetValue( Clamp, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut ) )

        if Clamp >= 1 then
            Flag = true
            Connect:Disconnect( )
        end
    end )

    while not Flag do
        if not Parent.Parent then
            break
        end

        task.wait( )
    end
    if Connect.Connected then
        Connect:Disconnect( )
    end
end

local function Pulser()
    local Value1 = nil

    for Key, Value in Table2, nil, nil do
        local E = Value.e
        E.Scale = 1
        local Create = TweenService:Create( E, TweenInfo.new( 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), { Scale = Value.haut } )
        Create.Completed:Once( function()
            TweenService:Create( E, TweenInfo.new( 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out ), { Scale = 1 } ):Play( )
        end )
        Create:Play( )
    end
end

Poser( -1000000 )
task.wait( 1 )

while Parent.Parent do
    if not LayerCollector or not LayerCollector.Parent then
        break
    end
    if Visible( ) then
        Balayer( )
        Pulser( )
        task.wait( tonumber( Parent:GetAttribute( "PauseReflet" ) ) or 3.5 )
    else
        task.wait( 0.5 )
    end
end
