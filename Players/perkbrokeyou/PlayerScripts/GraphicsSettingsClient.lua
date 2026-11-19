-- Players.perkbrokeyou.PlayerScripts.GraphicsSettingsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #52

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.TouchEnabled or Upvalue2.TouchMode( ) then
    return true
end

local MobileGui
local PlayerGui = game:GetService( "Players" ).LocalPlayer:FindFirstChild( "PlayerGui" )

if PlayerGui then
    MobileGui = PlayerGui:FindFirstChild( "MobileGui" )
else
    MobileGui = PlayerGui
end

local Captured

if Upvalue3 then
    if MobileGui == nil then
        Captured = false
    elseif MobileGui:GetAttribute( "ShowOnPC" ) == true then
        Captured = true
    else
        Captured = false
    end
else
    Captured = Upvalue3
end

return Captured
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue2.Potato == true and true or false
local LightPlayers
Upvalue1 = Flag
Upvalue3.PotatoGraphics = Upvalue1

if Upvalue1 then
    LightPlayers = Upvalue1
elseif Upvalue2.LightPlayers == true then
    LightPlayers = true
else
    LightPlayers = false
end

Upvalue3.LightPlayers = LightPlayers
return Upvalue1
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "NoSky" and Upvalue1 then
    return false
end
if not Upvalue2 or not Upvalue3[ Name ] then
    return Upvalue4[ Name ]
end
return true
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Upper = Self.Name:upper( )

if Upper:find( "BARK" ) or Upper:find( "TRUNK" ) or Upper:find( "_BASE" ) then
    return false
end

local Flag

if Upper:find( "NEEDLES" ) == nil then
    if Upper:find( "LEAVES" ) == nil then
        if Upper:find( "FOLIAGE" ) == nil then
            if Upper:find( "CANOPY" ) == nil then
                if Upper:find( "CYPRESS" ) == nil then
                    if Upper:find( "DISTANT_TREES" ) == nil then
                        Flag = false
                    else
                        Flag = true
                    end
                else
                    Flag = true
                end
            else
                Flag = true
            end
        else
            Flag = true
        end
    else
        Flag = true
    end
else
    Flag = true
end

return Flag
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Argument1.Name:sub( 1, 14 ) == "ground_details" then
    local Parent = Argument1.Parent

    if Parent then
        if Argument1.Parent.Name == "Decals" then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = Parent
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if not Self:IsA( "MeshPart" ) or not Self.Parent or not Self:FindFirstAncestor( "Roads" ) then
    return false
end

local Value1
local Upper = Self.Name:upper( )
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Upper:find( Value, 1, true ) then
        return true
    end
end

return false
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Argument1.Name:sub( 1, 13 ) == "Roads_Overlay" then
    local Parent = Argument1.Parent

    if Parent then
        if Argument1.Parent.Name == "Decals" then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = Parent
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = if not Upvalue1 or not Upvalue2.NoTrees then Upvalue3.NoTrees else true

if Part.CanCollide or Part.CanQuery then
    local LocalTransparencyModifier = not Flag and 0 or 1
    Part.LocalTransparencyModifier = LocalTransparencyModifier
    return
end
if Flag and Part.Parent and not Upvalue4[ Part ] then
    Upvalue4[ Part ] = Part.Parent
    Part.Parent = nil
end

return
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = if not Upvalue1 or not Upvalue2.NoTrees then Upvalue3.NoTrees else true

if Flag then
    local Value1 = nil

    for Value in Upvalue4, nil, nil do
        local Flag2 = if not Upvalue1 or not Upvalue2.NoTrees then Upvalue3.NoTrees else true

        if Value.CanCollide or Value.CanQuery then
            local LocalTransparencyModifier = not Flag2 and 0 or 1
            Value.LocalTransparencyModifier = LocalTransparencyModifier
        elseif Flag2 and Value.Parent and not Upvalue5[ Value ] then
            Upvalue5[ Value ] = Value.Parent
            Value.Parent = nil
        end
    end

    return
end
local Value2 = nil

for Key, Value3 in Upvalue5, nil, nil do
    Upvalue5[ Key ] = nil

    if Value3:IsDescendantOf( workspace ) then
        Key.Parent = Value3
    else
        Key:Destroy( )
    end
end

local Value4 = nil

for Value5 in Upvalue4, nil, nil do
    local Flag3 = if not Upvalue1 or not Upvalue2.NoTrees then Upvalue3.NoTrees else true

    if Value5.CanCollide or Value5.CanQuery then
        local LocalTransparencyModifier2 = not Flag3 and 0 or 1
        Value5.LocalTransparencyModifier = LocalTransparencyModifier2
    elseif Flag3 and Value5.Parent and not Upvalue5[ Value5 ] then
        Upvalue5[ Value5 ] = Value5.Parent
        Value5.Parent = nil
    end
end

return
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    local Value1
    task.wait( 10 )
    Value1 = nil

    for Key, Value in Upvalue1, nil, nil do
        if not Value:IsDescendantOf( workspace ) then
            Upvalue1[ Key ] = nil
            Key:Destroy( )
        end
    end
end
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = if not Upvalue1 or not Upvalue2.NoRoad then Upvalue3.NoRoad else true
local LocalTransparencyModifier = not Flag and 0 or 1
Argument1.LocalTransparencyModifier = LocalTransparencyModifier
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Entry = Upvalue1[ RoadName ]
Flag = if not Upvalue2 or not Upvalue3.NoRoad then Upvalue4.NoRoad else true

if Flag then
    if not Entry then
        Upvalue1[ RoadName ] = { RoadName.TextureID, RoadName.Color, RoadName.Material }
    end

    RoadName.TextureID = ""
    RoadName.Color = Upvalue5
    RoadName.Material = Enum.Material.Asphalt
    return
end
if Entry then
    local TextureID = Entry[ 1 ]
    local Color = Entry[ 2 ]
    local Material = Entry[ 3 ]
    RoadName.TextureID = TextureID
    RoadName.Color = Color
    RoadName.Material = Material
    Upvalue1[ RoadName ] = nil
end

return
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

local Value1
local Upper = Parent.Name:upper( )
Value1 = nil

for Key, Value in Upvalue1, nil, nil do
    if Upper:find( Value[ 1 ], 1, true ) then
        return Value[ 2 ]
    end
end

return nil
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

return Upvalue1.AlphaMode
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Parent = HeavyName.Parent

if HeavyName:IsA( "Texture" ) and Parent and Parent:IsA( "BasePart" ) and Parent.Transparency >= 0.99 then
    return
end
if Upvalue1 and Parent and not Upvalue2[ HeavyName ] and Parent:IsDescendantOf( workspace ) then
    Upvalue2[ HeavyName ] = Parent
    HeavyName.Parent = nil

    if HeavyName:IsA( "Texture" ) and Parent:IsA( "BasePart" ) and not Upvalue3[ Parent ] then
        local Color = Parent.Color
        Upvalue3[ Parent ] = Color
        Parent.Color = Color3.new( Color.R * 0.55, Color.G * 0.55, Color.B * 0.55 )
        return
    end
    if HeavyName:IsA( "SurfaceAppearance" ) and Parent:IsA( "BasePart" ) and not Upvalue4[ Parent ] then
        local LocalTransparencyModifier
        local Success, Result = pcall( function()
            return HeavyName.AlphaMode
        end )

        if Success then
            if Result == Enum.AlphaMode.Transparency then
                LocalTransparencyModifier = Upvalue5( Parent )
            else
                LocalTransparencyModifier = false
            end
        else
            LocalTransparencyModifier = Success
        end
        if LocalTransparencyModifier then
            Upvalue4[ Parent ] = true
            Parent.LocalTransparencyModifier = LocalTransparencyModifier
        end
    end
end
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Texture" ) or Self:IsA( "SurfaceAppearance" ) then
    Upvalue1[ Self ] = true

    if Upvalue2 then
        task.defer( Upvalue3, Self )
    end

    return
end
if not Self:IsA( "BasePart" ) then
    return
end
if Upvalue4( Self ) then
    local Flag6
    Upvalue5[ Self ] = true

    if not Upvalue2 or not Upvalue6.NoTrees then
        Flag6 = Upvalue7.NoTrees
    else
        Flag6 = true
    end
    if Flag6 then
        task.defer( Upvalue8, Self )
        return
    end
else
    local Flag

    if Self.Name:sub( 1, 14 ) == "ground_details" then
        local Parent = Self.Parent

        if Parent then
            if Self.Parent.Name == "Decals" then
                Flag = true
            else
                Flag = false
            end
        else
            Flag = Parent
        end
    else
        Flag = false
    end
    if Flag then
        Upvalue5[ Self ] = true

        if not Upvalue2 or not Upvalue6.NoTrees then
            Flag6 = Upvalue7.NoTrees
        else
            Flag6 = true
        end
        if Flag6 then
            task.defer( Upvalue8, Self )
            return
        end
    else
        local Flag2

        if Self.Name:sub( 1, 13 ) == "Roads_Overlay" then
            local Parent2 = Self.Parent

            if Parent2 then
                if Self.Parent.Name == "Decals" then
                    Flag2 = true
                else
                    Flag2 = false
                end
            else
                Flag2 = Parent2
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Flag3
            Upvalue9[ Self ] = true
            Flag3 = if not Upvalue2 or not Upvalue6.NoRoad then Upvalue7.NoRoad else true

            if Flag3 then
                local Flag4 = if not Upvalue2 or not Upvalue6.NoRoad then Upvalue7.NoRoad else true
                local LocalTransparencyModifier = not Flag4 and 0 or 1
                Self.LocalTransparencyModifier = LocalTransparencyModifier
                return
            end
        elseif Upvalue10( Self ) then
            local Flag5
            Upvalue11[ Self ] = true
            Flag5 = if not Upvalue2 or not Upvalue6.NoRoad then Upvalue7.NoRoad else true

            if Flag5 then
                Upvalue12( Self )
            end
        end
    end
end

return
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1[ Key ] = nil
Upvalue2[ Key ] = nil
Upvalue3[ Key ] = nil
Upvalue4[ Key ] = nil
Upvalue5[ Key ] = nil
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Self:GetDescendants( ) do
    Upvalue1( Value )
end

Self.DescendantAdded:Connect( Upvalue1 )
Self.DescendantRemoving:Connect( function( Key )
    Upvalue2[ Key ] = nil
    Upvalue3[ Key ] = nil
    Upvalue4[ Key ] = nil
    Upvalue5[ Key ] = nil
    Upvalue6[ Key ] = nil
end )
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

if Self.Name == "RankedArena" then
    Upvalue1( Self )
end
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

local PlayerGui2
local PlayerGui = Upvalue1:FindFirstChildOfClass( "PlayerGui" )
PlayerGui2 = if PlayerGui then PlayerGui:FindFirstChild( "SkyData" ) else PlayerGui
return PlayerGui2
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 ~= Upvalue1[ Key ] then
    Upvalue2[ Key ] = Argument2
end

return Upvalue2[ Key ]
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

if List[ Key ] ~= Argument4 then
    List[ Key ] = Argument4
end

Upvalue1[ Key2 ] = List[ Key ]
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

local Attribute2 = Upvalue1:GetAttribute( Attribute )

if Attribute2 == nil then
    return Argument2
end
return Attribute2
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.CaseRolling then
    return
end

local ClockTime = Upvalue2.ClockTime

if ClockTime ~= Upvalue3.ClockTime then
    Upvalue4.ClockTime = ClockTime
end

local ClockTime2 = Upvalue4.ClockTime
local Ambient = Upvalue2.Ambient

if Ambient ~= Upvalue3.Ambient then
    Upvalue4.Ambient = Ambient
end

local Ambient2 = Upvalue4.Ambient
local OutdoorAmbient = Upvalue2.OutdoorAmbient

if OutdoorAmbient ~= Upvalue3.OutdoorAmbient then
    Upvalue4.OutdoorAmbient = OutdoorAmbient
end

local OutdoorAmbient2 = Upvalue4.OutdoorAmbient
local Exposure = Upvalue2.ExposureCompensation

if Exposure ~= Upvalue3.Exposure then
    Upvalue4.Exposure = Exposure
end

local ExposureCompensation = Upvalue4.Exposure

local function Day( Attribute, Argument2 )
    local Attribute2 = Upvalue2:GetAttribute( Attribute )

    if Attribute2 == nil then
        return Argument2
    end
    return Attribute2
end

local ClockTime3 = math.clamp( ClockTime2, 7, 17 )

if Upvalue2.ClockTime ~= ClockTime3 then
    Upvalue2.ClockTime = ClockTime3
end

Upvalue3.ClockTime = Upvalue2.ClockTime
local JourAmbient = Upvalue2:GetAttribute( "JourAmbient" )

if JourAmbient ~= nil then
    Ambient2 = JourAmbient
end

local Ambient3 = Ambient2:Lerp( Upvalue5, 0.35 )

if Upvalue2.Ambient ~= Ambient3 then
    Upvalue2.Ambient = Ambient3
end

Upvalue3.Ambient = Upvalue2.Ambient
local JourOutdoorAmbient = Upvalue2:GetAttribute( "JourOutdoorAmbient" )

if JourOutdoorAmbient ~= nil then
    OutdoorAmbient2 = JourOutdoorAmbient
end
if Upvalue2.OutdoorAmbient ~= OutdoorAmbient2 then
    Upvalue2.OutdoorAmbient = OutdoorAmbient2
end

Upvalue3.OutdoorAmbient = Upvalue2.OutdoorAmbient
local JourExposure = Upvalue2:GetAttribute( "JourExposure" )

if JourExposure ~= nil then
    ExposureCompensation = JourExposure
end
if Upvalue2.ExposureCompensation ~= ExposureCompensation then
    Upvalue2.ExposureCompensation = ExposureCompensation
end

Upvalue3.Exposure = Upvalue2.ExposureCompensation
local ColorCorrection = Upvalue2:FindFirstChild( "ColorCorrection" )

if ColorCorrection and ColorCorrection:IsA( "ColorCorrectionEffect" ) then
    local Contrast = ColorCorrection.Contrast

    if Contrast ~= Upvalue3.Contrast then
        Upvalue4.Contrast = Contrast
    end

    local Contrast2 = Upvalue4.Contrast
    local JourContrast = Upvalue2:GetAttribute( "JourContrast" )

    if JourContrast ~= nil then
        Contrast2 = JourContrast
    end
    if ColorCorrection.Contrast ~= Contrast2 then
        ColorCorrection.Contrast = Contrast2
    end

    Upvalue3.Contrast = ColorCorrection.Contrast
    local Tint = ColorCorrection.TintColor

    if Tint ~= Upvalue3.Tint then
        Upvalue4.Tint = Tint
    end

    local TintColor = Upvalue4.Tint
    local JourTint = Upvalue2:GetAttribute( "JourTint" )

    if JourTint ~= nil then
        TintColor = JourTint
    end
    if ColorCorrection.TintColor ~= TintColor then
        ColorCorrection.TintColor = TintColor
    end

    Upvalue3.Tint = ColorCorrection.TintColor
end

local Atmosphere = Upvalue2:FindFirstChildOfClass( "Atmosphere" )

if Atmosphere and not Upvalue1.Scoped then
    local Density = Atmosphere.Density

    if Density ~= Upvalue3.Density then
        Upvalue4.Density = Density
    end

    local Density2 = Upvalue4.Density

    if Atmosphere.Density ~= 0 then
        Atmosphere.Density = 0
    end

    Upvalue3.Density = Atmosphere.Density
end

local Enabled
local SunRaysEffect = Upvalue2:FindFirstChildOfClass( "SunRaysEffect" )
Enabled = if not Upvalue6 or not Upvalue7 or Upvalue7:GetAttribute( "NoSunRays" ) ~= true then Upvalue6 else false

if SunRaysEffect and Enabled ~= nil and SunRaysEffect.Enabled ~= Enabled then
    SunRaysEffect.Enabled = Enabled
end
if Upvalue7 and Upvalue7.CelestialBodiesShown ~= Upvalue8 then
    Upvalue7.CelestialBodiesShown = Upvalue8
end
if Upvalue2:GetAttribute( "HeureReelle" ) ~= nil then
    Upvalue2:SetAttribute( "HeureReelle", nil )
end
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1[ Key2 ] ~= nil and Upvalue2[ Key2 ] ~= nil and List[ Key ] == Upvalue2[ Key2 ] then
    List[ Key ] = Upvalue1[ Key2 ]
end
]]

--[[
Function #25 has no emitted closure site
It is reproduced here so that nothing is lost

if SkyNoNight == Upvalue1 then
    return
end

Upvalue1 = SkyNoNight
Upvalue2.SkyNoNight = SkyNoNight
local Atmosphere = Upvalue3:FindFirstChildOfClass( "Atmosphere" )
local SunRaysEffect = Upvalue3:FindFirstChildOfClass( "SunRaysEffect" )

if SkyNoNight then
    local SunRaysEffect2
    Upvalue4 = { Upvalue3.EnvironmentDiffuseScale, Upvalue3.EnvironmentSpecularScale }
    Upvalue3.EnvironmentDiffuseScale = 0
    Upvalue3.EnvironmentSpecularScale = 0
    SunRaysEffect2 = if SunRaysEffect then SunRaysEffect.Enabled else SunRaysEffect
    Upvalue5 = SunRaysEffect2
    Upvalue6( )
    return
end
if not Upvalue2.CaseRolling then
    local ClockTime = Upvalue3.ClockTime

    if ClockTime ~= Upvalue7.ClockTime then
        Upvalue8.ClockTime = ClockTime
    end

    local ClockTime2 = Upvalue8.ClockTime
    local Ambient = Upvalue3.Ambient

    if Ambient ~= Upvalue7.Ambient then
        Upvalue8.Ambient = Ambient
    end

    local Ambient2 = Upvalue8.Ambient
    local OutdoorAmbient = Upvalue3.OutdoorAmbient

    if OutdoorAmbient ~= Upvalue7.OutdoorAmbient then
        Upvalue8.OutdoorAmbient = OutdoorAmbient
    end

    local OutdoorAmbient2 = Upvalue8.OutdoorAmbient
    local Exposure = Upvalue3.ExposureCompensation

    if Exposure ~= Upvalue7.Exposure then
        Upvalue8.Exposure = Exposure
    end

    local Exposure2 = Upvalue8.Exposure

    if Atmosphere and not Upvalue2.Scoped then
        local Density = Atmosphere.Density

        if Density ~= Upvalue7.Density then
            Upvalue8.Density = Density
        end

        local Density2 = Upvalue8.Density
    end
end
if Upvalue8.ClockTime ~= nil and Upvalue7.ClockTime ~= nil and Upvalue3.ClockTime == Upvalue7.ClockTime then
    Upvalue3.ClockTime = Upvalue8.ClockTime
end
if Upvalue8.Ambient ~= nil and Upvalue7.Ambient ~= nil and Upvalue3.Ambient == Upvalue7.Ambient then
    Upvalue3.Ambient = Upvalue8.Ambient
end
if Upvalue8.OutdoorAmbient ~= nil and Upvalue7.OutdoorAmbient ~= nil and Upvalue3.OutdoorAmbient == Upvalue7.OutdoorAmbient then
    Upvalue3.OutdoorAmbient = Upvalue8.OutdoorAmbient
end
if Upvalue8.Exposure ~= nil and Upvalue7.Exposure ~= nil and Upvalue3.ExposureCompensation == Upvalue7.Exposure then
    Upvalue3.ExposureCompensation = Upvalue8.Exposure
end

local ColorCorrection = Upvalue3:FindFirstChild( "ColorCorrection" )

if ColorCorrection and ColorCorrection:IsA( "ColorCorrectionEffect" ) then
    if not Upvalue2.CaseRolling then
        local Contrast = ColorCorrection.Contrast

        if Contrast ~= Upvalue7.Contrast then
            Upvalue8.Contrast = Contrast
        end

        local Contrast2 = Upvalue8.Contrast
        local Tint = ColorCorrection.TintColor

        if Tint ~= Upvalue7.Tint then
            Upvalue8.Tint = Tint
        end

        local Tint2 = Upvalue8.Tint
    end
    if Upvalue8.Contrast ~= nil and Upvalue7.Contrast ~= nil and ColorCorrection.Contrast == Upvalue7.Contrast then
        ColorCorrection.Contrast = Upvalue8.Contrast
    end
    if Upvalue8.Tint ~= nil and Upvalue7.Tint ~= nil and ColorCorrection.TintColor == Upvalue7.Tint then
        ColorCorrection.TintColor = Upvalue8.Tint
    end
end
if Atmosphere and Upvalue8.Density ~= nil and Upvalue7.Density ~= nil and Atmosphere.Density == Upvalue7.Density then
    Atmosphere.Density = Upvalue8.Density
end
if Upvalue4 then
    local EnvironmentDiffuseScale = Upvalue4[ 1 ]
    local EnvironmentSpecularScale = Upvalue4[ 2 ]
    Upvalue3.EnvironmentDiffuseScale = EnvironmentDiffuseScale
    Upvalue3.EnvironmentSpecularScale = EnvironmentSpecularScale
end
if SunRaysEffect and Upvalue5 ~= nil then
    SunRaysEffect.Enabled = Upvalue5
end

Upvalue4 = nil
Upvalue5 = nil
Upvalue3:SetAttribute( "HeureReelle", nil )
return
]]

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 or Upvalue2 then
    return
end
Upvalue2 = true
Upvalue3( )
Upvalue2 = false
return
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Self:IsA( "Atmosphere" ) or Self:IsA( "ColorCorrectionEffect" ) or Self:IsA( "SunRaysEffect" ) then
    Self.Changed:Connect( Upvalue1 )
end
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in Upvalue1:GetChildren( ) do
    if Value:IsA( "Sky" ) and Value ~= Upvalue2 then
        if Value ~= Upvalue3 then
            return Value
        end
    end
end
]]

-- Could not structure function #29

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.ChildAdded:Connect( function()
    Upvalue1( )
end )
Upvalue1( )
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.Name == "SkyData" then
    Argument1.ChildAdded:Connect( function()
        Upvalue1( )
    end )
    Upvalue1( )
end
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local PlayerGui = Upvalue1:WaitForChild( "PlayerGui" )

local function Hook( Argument1 )
    Argument1.ChildAdded:Connect( function()
        Upvalue2( )
    end )
    Upvalue2( )
end

local SkyData = PlayerGui:FindFirstChild( "SkyData" )

if SkyData then
    SkyData.ChildAdded:Connect( function()
        Upvalue2( )
    end )
    Upvalue2( )
end

PlayerGui.ChildAdded:Connect( function( Argument1 )
    if Argument1.Name == "SkyData" then
        Argument1.ChildAdded:Connect( function()
            Upvalue2( )
        end )
        Upvalue2( )
    end
end )
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = if not Upvalue1 or not Upvalue2.Saturation then Upvalue3.Saturation else true
local Clamp2

if type( Flag ) == "number" then
    local Clamp = math.clamp( Flag, 0, 1 )

    if Clamp then
        Clamp2 = Clamp
    elseif Flag == true then
        Clamp2 = 1
    else
        Clamp2 = 0
    end
elseif Flag == true then
    Clamp2 = 1
else
    Clamp2 = 0
end

local Enabled
local Saturation = 0.8 * Clamp2
local Contrast = 0.1 * Clamp2
local Brightness = 0.02 * Clamp2
Upvalue4.Saturation = Saturation
Upvalue4.Contrast = Contrast
Upvalue4.Brightness = Brightness
Enabled = Clamp2 > 0 and true or false
Upvalue4.Enabled = Enabled
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

if Key.Shadows then
    Upvalue1[ Key ] = true
    Key.Shadows = false
end
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

for Key, Value in workspace:GetDescendants( ) do
    if Upvalue1 ~= Upvalue2 then
        return
    end
    if Value:IsA( "Light" ) and Value.Shadows then
        Upvalue3[ Value ] = true
        Value.Shadows = false
    end
    if Key % 5000 == 0 then
        task.wait( )
    end
end
]]

--[[
Function #38 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
Upvalue1 = Upvalue1 + 1
Flag = if not Upvalue2 or not Upvalue3.NoShadows then Upvalue4.NoShadows else true
local Flag2 = if Flag then true else false
Upvalue5.GlobalShadows = Upvalue6 and not Flag2

if Flag2 then
    task.spawn( function()
        for Key, Value in workspace:GetDescendants( ) do
            if Upvalue1 ~= Upvalue1 then
                return
            end
            if Value:IsA( "Light" ) and Value.Shadows then
                Upvalue7[ Value ] = true
                Value.Shadows = false
            end
            if Key % 5000 == 0 then
                task.wait( )
            end
        end
    end )
    return
end

local Value1 = nil

for Value in Upvalue7, nil, nil do
    if Value.Parent then
        Value.Shadows = true
    end
end

table.clear( Upvalue7 )
]]

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Parent then
    local Flag = if not Upvalue2 or not Upvalue3.NoShadows then Upvalue4.NoShadows else true

    if Flag and Upvalue1.Shadows then
        Upvalue5[ Upvalue1 ] = true
        Upvalue1.Shadows = false
    end
end
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Light" ) then
    local Flag = if not Upvalue1 or not Upvalue2.NoShadows then Upvalue3.NoShadows else true

    if Flag then
        task.defer( function()
            if Object.Parent then
                local Flag = if not Upvalue1 or not Upvalue2.NoShadows then Upvalue3.NoShadows else true

                if Flag and Object.Shadows then
                    Upvalue4[ Object ] = true
                    Object.Shadows = false
                end
            end
        end )
    end
end
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Value1
    local Table = { }
    Value1 = nil

    for Value in Upvalue2, nil, nil do
        table.insert( Table, Value )
    end

    local Value2, Number
    Value2 = nil
    Number = 0

    for Key, Value3 in Table, nil, nil do
        if Upvalue3 ~= Upvalue4 then
            return
        end

        Upvalue5( Value3 )
        local Number2 = Number + 1

        if Number2 % 1500 == 0 then
            task.wait( )
            Number = Number2
        else
            Number = Number2
        end
    end

    return
end
local Value4, Number3
Value4 = nil
Number3 = 0

for Key2, Value5 in Upvalue6, nil, nil do
    if Upvalue3 ~= Upvalue4 then
        return
    end

    Upvalue6[ Key2 ] = nil

    if Value5:IsDescendantOf( workspace ) then
        Key2.Parent = Value5
    else
        Key2:Destroy( )
    end

    local Number6 = Number3 + 1

    if Number6 % 1500 == 0 then
        task.wait( )
        Number3 = Number6
    else
        Number3 = Number6
    end
end

local Value6 = nil

for Key3, Value7 in Upvalue7, nil, nil do
    if Upvalue3 ~= Upvalue4 then
        return
    end

    Upvalue7[ Key3 ] = nil

    if Key3.Parent then
        Key3.Color = Value7
    end

    local Number5 = Number3 + 1

    if Number5 % 1500 == 0 then
        task.wait( )
        Number3 = Number5
    else
        Number3 = Number5
    end
end

local Value8 = nil

for Value9 in Upvalue8, nil, nil do
    if Upvalue3 ~= Upvalue4 then
        return
    end

    Upvalue8[ Value9 ] = nil

    if Value9.Parent then
        Value9.LocalTransparencyModifier = 0
    end

    local Number4 = Number3 + 1

    if Number4 % 1500 == 0 then
        task.wait( )
        Number3 = Number4
    else
        Number3 = Number4
    end
end

return
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1

if Upvalue2 then
    for Key, Value in Upvalue3:GetChildren( ) do
        if Value:IsA( "BloomEffect" ) or Value:IsA( "SunRaysEffect" ) then
            if Value.Enabled then
                Upvalue4[ Value ] = true
                Value.Enabled = false
            end
        end
    end
else
    local Value1 = nil

    for Value2 in Upvalue4, nil, nil do
        if Value2.Parent then
            Value2.Enabled = true
        end
    end

    table.clear( Upvalue4 )
end

local Terrain = workspace.Terrain

if not Upvalue2 or Upvalue5 then
    if not Upvalue2 and Upvalue5 then
        local WaterWaveSize = Upvalue5[ 1 ]
        local WaterWaveSpeed = Upvalue5[ 2 ]
        local WaterReflectance = Upvalue5[ 3 ]
        Terrain.WaterWaveSize = WaterWaveSize
        Terrain.WaterWaveSpeed = WaterWaveSpeed
        Terrain.WaterReflectance = WaterReflectance
        Upvalue5 = nil
    end
else
    Upvalue5 = {
        Terrain.WaterWaveSize,
        Terrain.WaterWaveSpeed,
        Terrain.WaterReflectance
    }
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
end

task.spawn( function()
    if Upvalue2 then
        local Value1
        local Table = { }
        Value1 = nil

        for Value in Upvalue6, nil, nil do
            table.insert( Table, Value )
        end

        local Value2, Number
        Value2 = nil
        Number = 0

        for Key, Value3 in Table, nil, nil do
            if Upvalue1 ~= Upvalue1 then
                return
            end

            Upvalue7( Value3 )
            local Number2 = Number + 1

            if Number2 % 1500 == 0 then
                task.wait( )
                Number = Number2
            else
                Number = Number2
            end
        end

        return
    end
    local Value4, Number3
    Value4 = nil
    Number3 = 0

    for Key2, Value5 in Upvalue8, nil, nil do
        if Upvalue1 ~= Upvalue1 then
            return
        end

        Upvalue8[ Key2 ] = nil

        if Value5:IsDescendantOf( workspace ) then
            Key2.Parent = Value5
        else
            Key2:Destroy( )
        end

        local Number6 = Number3 + 1

        if Number6 % 1500 == 0 then
            task.wait( )
            Number3 = Number6
        else
            Number3 = Number6
        end
    end

    local Value6 = nil

    for Key3, Value7 in Upvalue9, nil, nil do
        if Upvalue1 ~= Upvalue1 then
            return
        end

        Upvalue9[ Key3 ] = nil

        if Key3.Parent then
            Key3.Color = Value7
        end

        local Number5 = Number3 + 1

        if Number5 % 1500 == 0 then
            task.wait( )
            Number3 = Number5
        else
            Number3 = Number5
        end
    end

    local Value8 = nil

    for Value9 in Upvalue10, nil, nil do
        if Upvalue1 ~= Upvalue1 then
            return
        end

        Upvalue10[ Value9 ] = nil

        if Value9.Parent then
            Value9.LocalTransparencyModifier = 0
        end

        local Number4 = Number3 + 1

        if Number4 % 1500 == 0 then
            task.wait( )
            Number3 = Number4
        else
            Number3 = Number4
        end
    end

    return
end )
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    local Value1
    task.wait( 10 )
    Value1 = nil

    for Key, Value in Upvalue1, nil, nil do
        if not Value:IsDescendantOf( workspace ) then
            Upvalue1[ Key ] = nil
            Key:Destroy( )
        end
    end
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Name == "LightPlayers" then
    local Flag = Upvalue2.Potato == true and true or false
    local LightPlayers
    Upvalue1 = Flag
    Upvalue3.PotatoGraphics = Upvalue1

    if Upvalue1 then
        LightPlayers = Upvalue1
    elseif Upvalue2.LightPlayers == true then
        LightPlayers = true
    else
        LightPlayers = false
    end

    Upvalue3.LightPlayers = LightPlayers
    return
end
local Value1, Flag4

if not Name or Name == "Potato" then
    local Flag2 = Upvalue2.Potato == true and true or false
    local LightPlayers2
    Upvalue1 = Flag2
    Upvalue3.PotatoGraphics = Upvalue1

    if Upvalue1 then
        LightPlayers2 = Upvalue1
    elseif Upvalue2.LightPlayers == true then
        LightPlayers2 = true
    else
        LightPlayers2 = false
    end

    Upvalue3.LightPlayers = LightPlayers2
    Value1 = nil
    Flag4 = true
else
    Value1 = Name
    Flag4 = false
end
if not Value1 or Value1 == "NoShadows" then
    Upvalue4( )
end
if not Value1 or Value1 == "Saturation" then
    local Flag3 = if not Upvalue1 or not Upvalue5.Saturation then Upvalue2.Saturation else true
    local Clamp2

    if type( Flag3 ) == "number" then
        local Clamp = math.clamp( Flag3, 0, 1 )

        if Clamp then
            Clamp2 = Clamp
        elseif Flag3 == true then
            Clamp2 = 1
        else
            Clamp2 = 0
        end
    elseif Flag3 == true then
        Clamp2 = 1
    else
        Clamp2 = 0
    end

    local Enabled
    local Saturation = 0.8 * Clamp2
    local Contrast = 0.1 * Clamp2
    local Brightness = 0.02 * Clamp2
    Upvalue6.Saturation = Saturation
    Upvalue6.Contrast = Contrast
    Upvalue6.Brightness = Brightness
    Enabled = Clamp2 > 0 and true or false
    Upvalue6.Enabled = Enabled
end
if not Value1 or Value1 == "NoSky" then
    Upvalue7( )
end
if not Value1 or Value1 == "NoTrees" then
    Upvalue8( )
end
if not Value1 or Value1 == "NoRoad" then
    local Value2 = nil

    for Value in Upvalue9, nil, nil do
        Upvalue10( Value )
    end

    local Value3 = nil

    for Value4 in Upvalue11, nil, nil do
        local Flag5 = if not Upvalue1 or not Upvalue5.NoRoad then Upvalue2.NoRoad else true
        local LocalTransparencyModifier = not Flag5 and 0 or 1
        Value4.LocalTransparencyModifier = LocalTransparencyModifier
    end
end
if Flag4 then
    Upvalue12( )
end

return
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

while true do
    local Flag
    task.wait( 5 )
    Flag = Upvalue2.Potato == true and true or false
    local LightPlayers
    Upvalue1 = Flag
    Upvalue3.PotatoGraphics = Upvalue1

    if Upvalue1 then
        LightPlayers = Upvalue1
    elseif Upvalue2.LightPlayers == true then
        LightPlayers = true
    else
        LightPlayers = false
    end

    Upvalue3.LightPlayers = LightPlayers

    if Upvalue1 ~= Upvalue1 then
        Upvalue4( )
    end
end
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = os.clock( )
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

if os.clock( ) - Upvalue1 < 15 then
    return false
end
if Upvalue2.WardrobeOpen or Upvalue2.CaseRolling or Upvalue3:GetAttribute( "InWardrobe" ) then
    return false
end

local PlayerGui = Upvalue3:FindFirstChild( "PlayerGui" )

if PlayerGui and PlayerGui:FindFirstChild( "EcranChargement" ) then
    return false
end

local Humanoid
local Character = Upvalue3.Character

if Character then
    Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Character
end

local Flag

if Humanoid == nil then
    Flag = false
elseif Humanoid.Health > 0 then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1.fired or Upvalue1[ Argument1.key ] == true or Upvalue1[ Argument1.done ] == true then
    return false
end
if Upvalue2 and workspace:GetAttribute( "TestAutoGraphics" ) ~= true then
    return false
end
if Argument1.key == "LightPlayers" and Upvalue1.Potato == true then
    return false
end
if not Argument1.touchOnly or Upvalue3( ) then
    return Argument2
end
return false
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

require( Upvalue1:WaitForChild( "Notify" ) ).Announce( Upvalue2, Upvalue3, 6 )
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local Value2
local Value1 = Upvalue1( )
Value2 = nil

for Key, Value in Upvalue2, nil, nil do
    local Acc = Value.acc

    if Upvalue3( Value, Value1 ) then
        Acc.t = Acc.t + Amount
        Acc.frames = Acc.frames + 1

        if Amount > 0.05 then
            Acc.hitches = Acc.hitches + 1
        end
        if not ( Acc.t < 20 ) then
            local Frames = Acc.frames / Acc.t
            local Hitches = Acc.hitches / Acc.frames
            Acc.t = 0
            Acc.frames = 0
            Acc.hitches = 0

            if Frames < Value.fps or Value.hitch < Hitches then
                Value.fired = true
                local Key2 = Value.key
                print( ( "[Graphismes] %s coché automatiquement (%.0f images / s, %.0f %% d'images > 50 ms sur %d s)" ):format( Key2, Frames, Hitches * 100, 20 ) )
                local Set = Upvalue4.Set
                Set( Value.done, true )
                local Set2 = Upvalue4.Set
                Set2( Value.key, true )
                local Title = Value.title
                local Text = Value.text
                pcall( function()
                    require( Upvalue5:WaitForChild( "Notify" ) ).Announce( Title, Text, 6 )
                end )
            end
        end
    else
        Acc.t = 0
        Acc.frames = 0
        Acc.hitches = 0
    end
end
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Upvalue1.WardrobeOpen == true and true or false

if Flag ~= Upvalue2 then
    Upvalue2 = Flag
    Upvalue3( "NoSky" )
end
]]
