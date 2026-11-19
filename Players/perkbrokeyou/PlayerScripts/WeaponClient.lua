-- Players.perkbrokeyou.PlayerScripts.WeaponClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #66

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

if not workspace:GetAttribute( "RankedMatch" ) then
    return false
end

local MatchState
local RankedShared = game:GetService( "ReplicatedStorage" ):FindFirstChild( "RankedShared" )

if RankedShared then
    MatchState = RankedShared:FindFirstChild( "MatchState" )
else
    MatchState = RankedShared
end

local Flag

if MatchState == nil then
    Flag = false
elseif MatchState:GetAttribute( "Phase" ) == "fight" then
    Flag = false
else
    Flag = true
end

return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue2.RecoilKey( )
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1.InfiniteAmmo == true then
    Flag = true
elseif Upvalue2 == nil then
    Flag = false
elseif Upvalue2:GetAttribute( "InFarmZone" ) == true then
    Flag = true
else
    Flag = false
end

return Flag
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = Argument1.Name < Argument2.Name and true or false
return Flag
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Spectating then
    return
end

local Text = PulseName or "health"
local Clock = os.clock( )

if Clock - Upvalue2[ Text ] < 0.05 then
    return
end

Upvalue2[ Text ] = Clock

if Text == "armor" then
    Upvalue3 = math.min( 0.42, math.max( Upvalue3, 0.15 ) + 0.3 )
    return
end
Upvalue4 = math.min( 0.42, math.max( Upvalue4, 0.15 ) + 0.3 )
return
]]

--[[
Function #5 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.DamageVignetteExternal then
    if Upvalue2 ~= 0 then
        local Value1
        Upvalue2 = 0
        Value1 = nil

        for Key, Value in Upvalue3, nil, nil do
            Value.BackgroundTransparency = 1
        end
    end

    return
end
if Upvalue1.Spectating then
    Upvalue4 = 0
    Upvalue5 = 0
end

local BackgroundTransparency
Upvalue4 = Upvalue4 * math.exp( -3.2 * Amount )
Upvalue5 = Upvalue5 * math.exp( -3.2 * Amount )
local Captured = Upvalue4 + Upvalue5
Upvalue2 = Upvalue2 + ( math.min( Captured, 0.42 ) - Upvalue2 ) * math.min( 1, Amount * 30 )
BackgroundTransparency = if Upvalue2 < 0.005 then 1 else 1 - Upvalue2
local BackgroundColor3

if Captured > 0.0001 then
    local Lerp = Upvalue6:Lerp( Upvalue7, Upvalue5 / Captured )

    if Lerp then
        BackgroundColor3 = Lerp
    else
        BackgroundColor3 = Upvalue6
    end
else
    BackgroundColor3 = Upvalue6
end

local Value2 = nil

for Key2, Value3 in Upvalue3, nil, nil do
    Value3.BackgroundTransparency = BackgroundTransparency
    Value3.BackgroundColor3 = BackgroundColor3
end

return
]]

--[[
Function #6 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.Visible = Visible
Upvalue2.Visible = Visible
Upvalue3.Visible = false
]]

--[[
Function #7 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

local Flag = Upvalue2 <= math.floor( Upvalue3 / 4 ) and true or false
local Text

if Flag then
    local LowColor2
    local LowColor = Upvalue4:GetAttribute( "LowColor" )
    LowColor2 = if LowColor then LowColor else Color3.fromRGB( 255, 90, 90 )
    local Format = string.format( "<font color=\"#%s\">%d</font>", LowColor2:ToHex( ), Upvalue2 )

    if Format then
        Text = Format
    else
        Text = tostring( Upvalue2 )
    end
else
    Text = tostring( Upvalue2 )
end

local ReserveColor2
local ReserveSize = Upvalue4:GetAttribute( "ReserveSize" ) or 24
local ReserveColor = Upvalue4:GetAttribute( "ReserveColor" )
ReserveColor2 = if ReserveColor then ReserveColor else Color3.fromRGB( 160, 160, 160 )
local Flag2
local ToHex = ReserveColor2:ToHex( )

if Upvalue5.InfiniteAmmo == true then
    Flag2 = true
elseif Upvalue6 == nil then
    Flag2 = false
elseif Upvalue6:GetAttribute( "InFarmZone" ) == true then
    Flag2 = true
else
    Flag2 = false
end

local Text2

if Flag2 then
    Text2 = "∞"
else
    Text2 = tostring( Upvalue7 )
end

Upvalue4.Text = string.format( "%s<font size=\"%d\" color=\"#%s\"> / %s</font>", Text, ReserveSize, ToHex, Text2 )
Upvalue8.Text = Upvalue1.Name
]]

--[[
Function #8 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    Upvalue3.Enabled = false
end
]]

--[[
Function #9 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 == Upvalue2 then
    local Create = Upvalue3:Create( Upvalue4, TweenInfo.new( Upvalue5.Out, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), {
        Brightness = 0,
        Contrast = 0,
        Saturation = 0,
        TintColor = Color3.new( 1, 1, 1 )
    } )
    Create.Completed:Connect( function()
        if Upvalue1 == Upvalue2 then
            Upvalue4.Enabled = false
        end
    end )
    Create:Play( )
    return
end
return
]]

--[[
Function #10 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1 = Upvalue1 + 1
local KillFlash = Upvalue2.KillFlash
Upvalue3.Enabled = true
local Create = Upvalue4:Create( Upvalue3, TweenInfo.new( KillFlash.In, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), {
    Brightness = KillFlash.Brightness,
    Contrast = KillFlash.Contrast,
    Saturation = KillFlash.Saturation,
    TintColor = KillFlash.Tint
} )
Create.Completed:Connect( function()
    if Upvalue1 == Upvalue1 then
        local Create = Upvalue4:Create( Upvalue3, TweenInfo.new( KillFlash.Out, Enum.EasingStyle.Quad, Enum.EasingDirection.Out ), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.new( 1, 1, 1 )
        } )
        Create.Completed:Connect( function()
            if Upvalue1 == Upvalue1 then
                Upvalue3.Enabled = false
            end
        end )
        Create:Play( )
        return
    end
    return
end )
Create:Play( )
]]

--[[
Function #11 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.HitmarkerOn ~= false then
    local BackgroundColor3

    if Hitmarker.Killed then
        local KillColor = Upvalue2:GetAttribute( "KillColor" )

        if KillColor then
            BackgroundColor3 = KillColor
        elseif Hitmarker.Headshot then
            local HeadshotColor = Upvalue2:GetAttribute( "HeadshotColor" )

            if HeadshotColor then
                BackgroundColor3 = HeadshotColor
            else
                local HitColor = Upvalue2:GetAttribute( "HitColor" )

                if HitColor then
                    BackgroundColor3 = HitColor
                else
                    BackgroundColor3 = Color3.new( 1, 1, 1 )
                end
            end
        else
            local HitColor = Upvalue2:GetAttribute( "HitColor" )

            if HitColor then
                BackgroundColor3 = HitColor
            else
                BackgroundColor3 = Color3.new( 1, 1, 1 )
            end
        end
    elseif Hitmarker.Headshot then
        local HeadshotColor = Upvalue2:GetAttribute( "HeadshotColor" )

        if HeadshotColor then
            BackgroundColor3 = HeadshotColor
        else
            local HitColor = Upvalue2:GetAttribute( "HitColor" )

            if HitColor then
                BackgroundColor3 = HitColor
            else
                BackgroundColor3 = Color3.new( 1, 1, 1 )
            end
        end
    else
        local HitColor = Upvalue2:GetAttribute( "HitColor" )

        if HitColor then
            BackgroundColor3 = HitColor
        else
            BackgroundColor3 = Color3.new( 1, 1, 1 )
        end
    end

    local Value1 = nil

    for Key, Value in Upvalue3, nil, nil do
        Value.BackgroundColor3 = BackgroundColor3
        Value.BackgroundTransparency = 0
        Upvalue4:Create( Value, Upvalue5, { BackgroundTransparency = 1 } ):Play( )

        if Upvalue6[ Key ] then
            Upvalue6[ Key ].Transparency = Upvalue7
            Upvalue4:Create( Upvalue6[ Key ], Upvalue5, { Transparency = 1 } ):Play( )
        end
    end

    local Number
    local HitmarkerScale = Upvalue1.HitmarkerScale or 1
    Number = not Hitmarker.Killed and 1.3 or 1.6
    local Number2
    Upvalue8.Scale = Number * HitmarkerScale
    local Table = { }
    Number2 = not Hitmarker.Killed and 1 or 1.2
    Table.Scale = Number2 * HitmarkerScale
    Upvalue4:Create( Upvalue8, Upvalue9, Table ):Play( )
end
if Hitmarker.Downed then
    Upvalue10( )
elseif Hitmarker.Killed and Hitmarker.Downable == false then
    Upvalue10( )
end
]]

--[[
Function #12 has no emitted closure site
It is reproduced here so that nothing is lost

if workspace:GetAttribute( "DebugHits" ) then
    print( ( "[SERVEUR] tête=%s tue=%s dégâts=%s" ):format( tostring( Argument1.Headshot ), tostring( Argument1.Killed ), ( tostring( Argument1.Damage ) ) ) )
end
if Argument1.Friendly then
    Upvalue1.Play( "Flesh" )

    if typeof( Argument1.Target ) == "Instance" and typeof( Argument1.HitPos ) == "Vector3" then
        Upvalue2.Blood( Argument1.Target, Argument1.HitPos, Argument1.HitPos - Upvalue3.CFrame.Position )
    end

    return
end
Upvalue1.OnConfirm( Argument1 )

if typeof( Argument1.Target ) == "Instance" and typeof( Argument1.HitPos ) == "Vector3" then
    Upvalue2.Blood( Argument1.Target, Argument1.HitPos, Argument1.HitPos - Upvalue3.CFrame.Position )
end

local Clock = os.clock( )

if Clock - -1 > 0.35 then
    Upvalue4( Argument1 )
    return
end
if Argument1.Killed and Clock - -1 > 0.5 and Argument1.Downable == false then
    Upvalue5( )
end
if Argument1.Downed and Clock - -1 > 0.5 then
    Upvalue5( )
end

return
]]

--[[
Function #13 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.LaserFire and Upvalue2 then
    return Upvalue3.Bloom.Aim + ( Upvalue3.Bloom.Hip - Upvalue3.Bloom.Aim ) * math.clamp( tonumber( Upvalue2.Bloom ) or 0, 0, 1 )
end

local Aim2

if Upvalue1.Aiming then
    local Aim = Upvalue3.Bloom.Aim

    if Aim then
        Aim2 = Aim
    else
        Aim2 = Upvalue3.Bloom.Hip
    end
else
    Aim2 = Upvalue3.Bloom.Hip
end

return Aim2
]]

--[[
Function #14 has no emitted closure site
It is reproduced here so that nothing is lost

local Aim

if not Upvalue1.LaserFire or not Upvalue2 then
    if Upvalue1.Aiming then
        local Aim2 = Upvalue3.Bloom.Aim

        if Aim2 then
            Aim = Aim2
        else
            Aim = Upvalue3.Bloom.Hip
        end
    else
        Aim = Upvalue3.Bloom.Hip
    end
else
    Aim = Upvalue3.Bloom.Aim + ( Upvalue3.Bloom.Hip - Upvalue3.Bloom.Aim ) * math.clamp( tonumber( Upvalue2.Bloom ) or 0, 0, 1 )
end

local Aim4
local Aim3 = Aim + Upvalue4
local AssemblyLinearVelocity = Upvalue5.AssemblyLinearVelocity
local X = AssemblyLinearVelocity.X

if Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude > 2 then
    local Number
    local Move = Upvalue3.Bloom.Move

    if Upvalue1.LaserFire then
        Number = 0.7
    elseif Upvalue1.Aiming then
        Number = 0.4
    else
        Number = 1
    end

    Aim4 = Aim3 + Move * Number
else
    Aim4 = Aim3
end
if Upvalue6.FloorMaterial == Enum.Material.Air and not Upvalue6.SeatPart then
    Aim4 = Aim4 + Upvalue3.Bloom.Air
end

return math.min( Aim4, Upvalue3.Bloom.Max ) * ( Upvalue1.SpreadMultiplier or 1 ) * ( Upvalue7.BloomScale or 1 )
]]

--[[
Function #15 has no emitted closure site
It is reproduced here so that nothing is lost

local Aim

if not Upvalue1.LaserFire or not Upvalue2 then
    if Upvalue1.Aiming then
        local Aim2 = Upvalue3.Bloom.Aim

        if Aim2 then
            Aim = Aim2
        else
            Aim = Upvalue3.Bloom.Hip
        end
    else
        Aim = Upvalue3.Bloom.Hip
    end
else
    Aim = Upvalue3.Bloom.Aim + ( Upvalue3.Bloom.Hip - Upvalue3.Bloom.Aim ) * math.clamp( tonumber( Upvalue2.Bloom ) or 0, 0, 1 )
end

return math.min( Aim, Upvalue3.Bloom.Max ) * ( Upvalue1.SpreadMultiplier or 1 ) * ( Upvalue4.BloomScale or 1 )
]]

--[[
Function #16 has no emitted closure site
It is reproduced here so that nothing is lost

if Amount <= 0 then
    return Argument1
end
local Rad = math.rad( Amount ) * Upvalue1:NextNumber( )
local NextNumber = Upvalue1:NextNumber( ) * 3.141592653589793 * 2
return ( CFrame.lookAt( Vector3.new( 0, 0, 0 ), Argument1 ) * CFrame.Angles( 0, 0, NextNumber ) * CFrame.Angles( Rad, 0, 0 ) ).LookVector
]]

--[[
Function #17 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 <= List[ 1 ][ 1 ] then
    return List[ 1 ][ 2 ]
end

local Count = #List
local I = 2

for I = 2, Count do
    local Entry = List[ I - 1 ]
    local Entry2 = List[ I ]

    if Argument2 <= Entry2[ 1 ] then
        return Entry[ 2 ] + ( Entry2[ 2 ] - Entry[ 2 ] ) * ( Argument2 - Entry[ 1 ] ) / ( Entry2[ 1 ] - Entry[ 1 ] )
    end
end

return List[ #List ][ 2 ]
]]

--[[
Function #18 has no emitted closure site
It is reproduced here so that nothing is lost

local Humanoid
local Char = Argument1.char

if Char then
    Humanoid = Char:FindFirstChildOfClass( "Humanoid" )
else
    Humanoid = Char
end
if not Humanoid or Char == Upvalue1 or Humanoid.Health <= 0 then
    return
end

local Min
local Clock = os.clock( )
local Entry = Upvalue2[ Humanoid ]
local Health = Humanoid.Health

if not Entry or not ( Clock - Entry.t < 0.5 ) then
    Min = Health
else
    Min = math.min( Health, Entry.h )
end
if Min <= 0 then
    return
end

local Number

if Upvalue3.Damage.Curve then
    Number = Upvalue4( Upvalue3.Damage.Curve, Argument2 )
elseif Upvalue3.Damage.FalloffStart < Argument2 then
    Number = Upvalue5.FarDamageScale or 0.9
else
    Number = 1
end

local Flag = Upvalue6.HEAD[ Argument1.name ] == true and true or false
local Headshot2

if Flag then
    local Headshot = Upvalue3.Damage.Headshot

    if Headshot then
        Headshot2 = Headshot
    else
        Headshot2 = 1
    end
else
    Headshot2 = 1
end

local Min2
local Floor = math.floor( Upvalue3.Damage.Base * Number * Headshot2 + 0.5 )

if not Upvalue3.Damage.BodyNoKillChance or Flag then
    Min2 = Floor
else
    Min2 = math.min( Floor, Upvalue3.Damage.BodyNoKill )
end

local Flag4
local Health2 = Min - Min2

if Health2 <= 0 then
    Flag4 = true
else
    Flag4 = false
end

local Flag5
local PlayerFromCharacter = Upvalue7:GetPlayerFromCharacter( Char )

if PlayerFromCharacter == nil then
    if Char:GetAttribute( "Downable" ) == true then
        Flag5 = true
    else
        Flag5 = false
    end
else
    Flag5 = true
end

local Flag2

if Char:GetAttribute( "Downed" ) == true then
    Flag2 = true
elseif Entry == nil then
    Flag2 = false
elseif Clock - Entry.t < 0.5 then
    if Entry.downed == true then
        Flag2 = true
    else
        Flag2 = false
    end
else
    Flag2 = false
end

local Flag3
local DownedAt = Char:GetAttribute( "DownedAt" )
local DownedGrace = Char:GetAttribute( "DownedGrace" ) or 0.7

if not DownedAt or not ( workspace:GetServerTimeNow( ) - DownedAt < DownedGrace ) then
    if Entry == nil then
        Flag3 = false
    elseif Entry.downedT == nil then
        Flag3 = false
    elseif Clock - Entry.downedT < DownedGrace then
        Flag3 = true
    else
        Flag3 = false
    end
else
    Flag3 = true
end

local Entry2

if Entry then
    Entry2 = Entry.downedT
else
    Entry2 = Entry
end
if not Flag2 or not Flag3 then
    local Health3, Flag6

    if not Flag4 or not Flag5 or Flag2 then
        Health3 = Health2
        Flag6 = false
    else
        Health3 = 1
        Flag2 = true
        Entry2 = Clock
        Flag4 = false
        Flag6 = true
    end

    local Victim
    Upvalue2[ Humanoid ] = { h = Health3, t = Clock, downed = Flag2, downedT = Entry2 }
    local Table2 = { Headshot = Flag, Killed = Flag4, Downed = Flag6, Downable = Flag5 }
    Victim = PlayerFromCharacter and PlayerFromCharacter.DisplayName or Char.Name
    Table2.Victim = Victim

    if workspace:GetAttribute( "DebugHits" ) then
        local Name = Argument1.name
        local Text = tostring( Flag )
        print( ( "[PRÉDIT] %s tête=%s tue=%s vie prévue=%.0f" ):format( Name, Text, tostring( Flag4 ), Health3 ) )
    end

    return
end
local DownedT
local Table = { h = Health2 + Min2, t = Clock, downed = true }
DownedT = if Entry then Entry.downedT else Entry
Table.downedT = DownedT
Upvalue2[ Humanoid ] = Table
return
]]

--[[
Function #19 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Vehicle ~= nil then
    return true
end

local Flag

if ( Upvalue2 and Upvalue2.SeatPart ) == nil then
    Flag = false
elseif ( Upvalue2 and Upvalue2.SeatPart ):GetAttribute( "Role" ) == nil then
    Flag = false
else
    Flag = true
end

return Flag
]]

--[[
Function #20 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 or Upvalue3 ~= Upvalue4 then
    return
end

Upvalue2 = Upvalue2 + 1
Upvalue5 = nil
Upvalue6.Reloading = false
Upvalue7.Visible = false
local Out = Upvalue8.Out
local FireServer = Upvalue9.Reload.FireServer
Out( FireServer, Upvalue9.Reload, "done" )

if Upvalue10 and Upvalue11 > 0 then
    Upvalue12.Start( Upvalue4 )
    local Bolt = Upvalue13.Bolt
    local Of = Upvalue14.Of( Upvalue4 )
    Bolt( Upvalue4, Of, true, Upvalue15.IsSilenced( Upvalue4 ), true )
    Upvalue16 = os.clock( ) + Upvalue17.Fire.BoltTime
    Upvalue4:SetAttribute( "BoltReadyAt", Upvalue16 )
    return
end
if Argument1 then
    Upvalue16 = os.clock( ) + ( Upvalue18.Interrupt or 0.15 )
end
]]

--[[
Function #21 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( true )
]]

--[[
Function #22 has no emitted closure site
It is reproduced here so that nothing is lost

local Number = 0

while Upvalue1 < Upvalue2 do
    if not ( Upvalue3 > 0 ) then
        local Flag

        if Upvalue4.InfiniteAmmo == true then
            Flag = true
        elseif Upvalue5 == nil then
            Flag = false
        elseif Upvalue5:GetAttribute( "InFarmZone" ) == true then
            Flag = true
        else
            Flag = false
        end
        if not Flag then
            break
        end
    end

    task.wait( ( math.max( 0, Upvalue6 + ( Upvalue7.Start + ( Number + Upvalue7.InsertAt ) * Upvalue7.Each ) * Upvalue8 - os.clock( ) ) ) )

    if Upvalue9 ~= Upvalue10 or Upvalue11 ~= Upvalue12 then
        return
    end

    local Flag2
    Upvalue13.Shell( Upvalue12 )
    Upvalue1 = Upvalue1 + 1

    if Upvalue4.InfiniteAmmo == true then
        Flag2 = true
    elseif Upvalue5 == nil then
        Flag2 = false
    elseif Upvalue5:GetAttribute( "InFarmZone" ) == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if not Flag2 then
        Upvalue3 = Upvalue3 - 1
    end

    Upvalue14 = Upvalue14 + 1
    Number = Number + 1
    local Out = Upvalue15.Out
    local FireServer = Upvalue16.Reload.FireServer
    Out( FireServer, Upvalue16.Reload, "shell" )
    Upvalue17( )
end

task.wait( ( Upvalue7.End or 0.25 ) * Upvalue8 )
Upvalue18( false )
]]

--[[
Function #23 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag2
local Shell = Upvalue1.Ammo.Shell
Upvalue3.Reloading = true
Upvalue3.ReloadStart = os.clock( )
Upvalue4.Cancel( Upvalue2 )
Upvalue5.StopBolt( Upvalue2 )
Upvalue6 = 0
Upvalue7 = Upvalue7 + 1
Flag2 = Upvalue8 <= 0 and true or false
local Flag
local Number = 0
Upvalue9.Out( Upvalue10.Reload.FireServer, Upvalue10.Reload )

if Upvalue3.Vehicle == nil then
    if ( Upvalue11 and Upvalue11.SeatPart ) == nil then
        Flag = false
    elseif ( Upvalue11 and Upvalue11.SeatPart ):GetAttribute( "Role" ) == nil then
        Flag = false
    else
        Flag = true
    end
else
    Flag = true
end

local ReloadMul

if Flag then
    local VehicleReloadMul = Upvalue12.VehicleReloadMul

    if VehicleReloadMul then
        ReloadMul = VehicleReloadMul
    else
        ReloadMul = 1
    end
else
    ReloadMul = 1
end

Upvalue3.ReloadMul = ReloadMul
local Clock = os.clock( )

local function Finish( Argument1 )
    if Upvalue7 ~= Upvalue7 or Upvalue2 ~= Upvalue2 then
        return
    end

    Upvalue7 = Upvalue7 + 1
    Upvalue13 = nil
    Upvalue3.Reloading = false
    Upvalue14.Visible = false
    local Out = Upvalue9.Out
    local FireServer = Upvalue10.Reload.FireServer
    Out( FireServer, Upvalue10.Reload, "done" )

    if Flag2 and Number > 0 then
        Upvalue4.Start( Upvalue2 )
        local Bolt = Upvalue5.Bolt
        local Of = Upvalue15.Of( Upvalue2 )
        Bolt( Upvalue2, Of, true, Upvalue16.IsSilenced( Upvalue2 ), true )
        Upvalue6 = os.clock( ) + Upvalue1.Fire.BoltTime
        Upvalue2:SetAttribute( "BoltReadyAt", Upvalue6 )
        return
    end
    if Argument1 then
        Upvalue6 = os.clock( ) + ( Shell.Interrupt or 0.15 )
    end
end

Upvalue13 = function()
    Finish( true )
end
task.spawn( function()
    local NumberInner = 0

    while Upvalue8 < Upvalue17 do
        if not ( Upvalue18 > 0 ) then
            local Flag

            if Upvalue12.InfiniteAmmo == true then
                Flag = true
            elseif Upvalue19 == nil then
                Flag = false
            elseif Upvalue19:GetAttribute( "InFarmZone" ) == true then
                Flag = true
            else
                Flag = false
            end
            if not Flag then
                break
            end
        end

        task.wait( ( math.max( 0, Clock + ( Shell.Start + ( NumberInner + Shell.InsertAt ) * Shell.Each ) * ReloadMul - os.clock( ) ) ) )

        if Upvalue7 ~= Upvalue7 or Upvalue2 ~= Upvalue2 then
            return
        end

        local Flag2
        Upvalue5.Shell( Upvalue2 )
        Upvalue8 = Upvalue8 + 1

        if Upvalue12.InfiniteAmmo == true then
            Flag2 = true
        elseif Upvalue19 == nil then
            Flag2 = false
        elseif Upvalue19:GetAttribute( "InFarmZone" ) == true then
            Flag2 = true
        else
            Flag2 = false
        end
        if not Flag2 then
            Upvalue18 = Upvalue18 - 1
        end

        Number = Number + 1
        NumberInner = NumberInner + 1
        local Out = Upvalue9.Out
        local FireServer = Upvalue10.Reload.FireServer
        Out( FireServer, Upvalue10.Reload, "shell" )
        Upvalue20( )
    end

    task.wait( ( Shell.End or 0.25 ) * ReloadMul )
    Finish( false )
end )
]]

--[[
Function #24 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 ~= Upvalue2 or not Upvalue3 then
    return
end

local Flag

if Upvalue4.InfiniteAmmo == true then
    Flag = true
elseif Upvalue5 == nil then
    Flag = false
elseif Upvalue5:GetAttribute( "InFarmZone" ) == true then
    Flag = true
else
    Flag = false
end

local Min

if Flag then
    local Captured = Upvalue6 - Upvalue7

    if Captured then
        Min = Captured
    else
        Min = math.min( Upvalue6 - Upvalue7, Upvalue8 )
    end
else
    Min = math.min( Upvalue6 - Upvalue7, Upvalue8 )
end

local Flag2
local Max = math.max( 0, Min )
Upvalue7 = Upvalue7 + Max

if Upvalue4.InfiniteAmmo == true then
    Flag2 = true
elseif Upvalue5 == nil then
    Flag2 = false
elseif Upvalue5:GetAttribute( "InFarmZone" ) == true then
    Flag2 = true
else
    Flag2 = false
end
if not Flag2 then
    Upvalue8 = Upvalue8 - Max
end
if Upvalue9.Fire.Mode == "Rocket" then
    Upvalue3:SetAttribute( "Ammo", Upvalue7 )
end

Upvalue10.Reloading = false
Upvalue11.Visible = false
Upvalue12( )
]]

-- Could not structure function #25

--[[
Function #26 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag

if Upvalue1 == nil then
    Flag = false
else
    local NotReloading = not Upvalue2.Reloading

    if NotReloading then
        if type( Upvalue3 ) == "number" then
            if type( Upvalue4 ) == "number" then
                if Upvalue4 < Upvalue3 then
                    if Upvalue5.InfiniteAmmo == true then
                        Flag = true
                    elseif Upvalue6 == nil then
                        Flag = false
                    elseif Upvalue6:GetAttribute( "InFarmZone" ) == true then
                        Flag = true
                    else
                        Flag = false
                    end
                    if not Flag then
                        if type( Upvalue7 ) == "number" then
                            if Upvalue7 > 0 then
                                Flag = true
                            else
                                Flag = false
                            end
                        else
                            Flag = false
                        end
                    end
                else
                    Flag = false
                end
            else
                Flag = false
            end
        else
            Flag = false
        end
    else
        Flag = NotReloading
    end
end

return Flag
]]

--[[
Function #27 has no emitted closure site
It is reproduced here so that nothing is lost

if Amount <= 0 then
    return Argument1
end
local Rad = math.rad( Amount * Upvalue1:NextNumber( ) )
local NextNumber = Upvalue1:NextNumber( ) * 3.141592653589793 * 2
return ( CFrame.lookAt( Vector3.new( 0, 0, 0 ), Argument1 ) * CFrame.Angles( 0, 0, NextNumber ) * CFrame.Angles( Rad, 0, 0 ) ).LookVector
]]

--[[
Function #28 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry2
local Entry = Upvalue1.parts[ Key ]
Entry2 = if Entry then Entry.char else Entry
return Entry2
]]

--[[
Function #29 has no emitted closure site
It is reproduced here so that nothing is lost

local Model = Argument1:FindFirstAncestorWhichIsA( "Model" )

while Model do
    if Upvalue1:HasTag( Model, "Vehicle" ) then
        break
    end

    Model = Model:FindFirstAncestorWhichIsA( "Model" )
end

return Model
]]

--[[
Function #30 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument1 or typeof( Argument1.Instance ) ~= "Instance" then
    return nil
end

local Vehicle2
local Value1 = Upvalue1( Argument1.Instance )
local Vehicle = Upvalue2.Vehicle
Vehicle2 = if Vehicle then Upvalue2.Vehicle.Model else Vehicle

if not Value1 or Value1 == Vehicle2 then
    return nil
end

local Get = Upvalue3.Get( Value1:GetAttribute( "VehicleConfig" ) )

if Get and Get.BulletProof then
    return nil
end

local FilterDescendantsInstances = { }

for Key, Value in Value1:GetDescendants( ) do
    if Value:IsA( "Seat" ) or Value:IsA( "VehicleSeat" ) then
        if Value.Occupant and Value.Occupant.Parent then
            local Entry = Upvalue4.folders[ Value.Occupant.Parent ]

            if Entry then
                for Key2, Value2 in Entry:GetChildren( ) do
                    if Upvalue5[ Value2.Name ] then
                        table.insert( FilterDescendantsInstances, Value2 )
                    end
                end
            end
        end
    end
end
if #FilterDescendantsInstances == 0 then
    return nil
end

Upvalue6.FilterDescendantsInstances = FilterDescendantsInstances
local Unit = Argument3.Unit
local Position = Argument1.Position

if Argument1.Instance.Name:sub( 1, 6 ) == "Armor_" then
    local Find = Upvalue7.Find
    local Instance = Argument1.Instance
    local _, Find2 = Find( Instance, Argument1.Position, Unit )

    if Find2 then
        Position = Find2
    end
end

local Position2 = Position - Unit * 0.05
local Raycast = workspace:Raycast( Position2, Unit * 2.25, Upvalue6 )

if Raycast then
    return {
        Instance = Raycast.Instance,
        Position = Raycast.Position,
        Normal = Raycast.Normal,
        Material = Raycast.Material,
        Distance = ( Raycast.Position - Argument2 ).Magnitude
    }
end
return nil
]]

--[[
Function #31 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.FilterDescendantsInstances = Upvalue2
local Raycast = workspace:Raycast( Upvalue3, Upvalue4, Upvalue1 )
local I = 1

for I = 1, 12 do
    if not Raycast or Raycast.Instance.Name:sub( 1, 6 ) ~= "Glass_" then
        break
    end

    table.insert( Upvalue2, Raycast.Instance )
    Upvalue1.FilterDescendantsInstances = Upvalue2
    Raycast = workspace:Raycast( Upvalue3, Upvalue4, Upvalue1 )
end

return Raycast
]]

--[[
Function #32 has no emitted closure site
It is reproduced here so that nothing is lost

local FilterDescendantsInstances = Argument3.FilterDescendantsInstances
local Clone = table.clone( FilterDescendantsInstances )

local function Cast()
    Argument3.FilterDescendantsInstances = Clone
    local Raycast = workspace:Raycast( Argument1, Argument2, Argument3 )
    local I = 1

    for I = 1, 12 do
        if not Raycast or Raycast.Instance.Name:sub( 1, 6 ) ~= "Glass_" then
            break
        end

        table.insert( Clone, Raycast.Instance )
        Argument3.FilterDescendantsInstances = Clone
        Raycast = workspace:Raycast( Argument1, Argument2, Argument3 )
    end

    return Raycast
end

local Cast2 = Cast( )
local I = 1

for I = 1, 16 do
    if not Cast2 or Cast2.Instance.Name:sub( 1, 6 ) ~= "Armor_" then
        break
    end

    local Magnitude2
    table.insert( Clone, Cast2.Instance )
    local Cast3 = Cast( )

    if Cast3 then
        local Magnitude = ( Cast3.Position - Cast2.Position ).Magnitude

        if Magnitude then
            Magnitude2 = Magnitude
        else
            Magnitude2 = Argument2.Magnitude
        end
    else
        Magnitude2 = Argument2.Magnitude
    end

    local Covers = Upvalue1.Covers
    local Instance = Cast2.Instance

    if Covers( Instance, Cast2.Position, Argument2, Magnitude2 ) ~= false then
        break
    end

    Cast2 = Cast3
end

local Magnitude4
Argument3.FilterDescendantsInstances = FilterDescendantsInstances

if Cast2 then
    local Magnitude3 = ( Cast2.Position - Argument1 ).Magnitude

    if Magnitude3 then
        Magnitude4 = Magnitude3
    else
        Magnitude4 = Argument2.Magnitude
    end
else
    Magnitude4 = Argument2.Magnitude
end

local Vehicle2
local Vehicle = Upvalue2.Vehicle
Vehicle2 = if Vehicle then Upvalue2.Vehicle.Model else Vehicle
local Raycast, Raycast2, Raycast3, Raycast4 = Upvalue1.Raycast( Argument1, Argument2, Magnitude4, Vehicle2 )

if Raycast and Raycast3 < Magnitude4 - 0.05 then
    Cast2 = {
        Instance = Raycast2,
        Position = Raycast,
        Normal = Raycast4,
        Distance = Raycast3
    }
end

return Upvalue3( Cast2, Argument1, Argument2 ) or Cast2
]]

--[[
Function #33 has no emitted closure site
It is reproduced here so that nothing is lost

local Position
local Table = { }
local FilterDescendantsInstances = table.clone( Argument4 )
local I = 1
Position = nil

for I = 1, 16 do
    Upvalue1.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Argument1, Argument2 * Argument3, Upvalue1 )

    if not Raycast then
        break
    end
    if Raycast.Instance.Name:sub( 1, 6 ) == "Glass_" then
        local Position2
        table.insert( Table, Raycast.Instance )
        Position2 = if Position then Position else Raycast.Position
        Position = Position2
    end

    table.insert( FilterDescendantsInstances, Raycast.Instance )
end

return Table, Position
]]

--[[
Function #34 has no emitted closure site
It is reproduced here so that nothing is lost

local FilterDescendantsInstances = table.clone( Argument4 )
local I = 1

for I = 1, 16 do
    Upvalue1.FilterDescendantsInstances = FilterDescendantsInstances
    local Raycast = workspace:Raycast( Argument1, Argument2 * Argument3, Upvalue1 )

    if not Raycast then
        return nil
    end

    local Instance = Raycast.Instance

    if Instance.Name:sub( 1, 6 ) == "Glass_" and Instance.Transparency < 1 and Instance:IsDescendantOf( Argument5 ) then
        if not Upvalue2[ Instance ] or not ( os.clock( ) - Upvalue2[ Instance ] < 2 ) then
            local Value1 = Upvalue3( Instance )

            if Value1 and not Value1:GetAttribute( "Destroyed" ) and not Value1:GetAttribute( "Noyee" ) then
                return Raycast
            end
        end
    end

    table.insert( FilterDescendantsInstances, Instance )
end

return nil
]]

--[[
Function #35 has no emitted closure site
It is reproduced here so that nothing is lost

local Captured

if Upvalue1 then
    local Fire = Upvalue1.Fire

    if Fire then
        Captured = Upvalue1.Fire.Pellets
    else
        Captured = Fire
    end
else
    Captured = Upvalue1
end
if not Captured then
    return { Argument1 }
end

local Value1
local LookAt = CFrame.lookAt( Vector3.new( 0, 0, 0 ), Argument1 )
local Table = { }
local Pattern = Captured.Pattern
Value1 = nil

for Key, Value in Pattern, nil, nil do
    local Zero = Key == 1 and Argument2 and Vector2.zero or Vector2.new( Upvalue2:NextNumber( -1, 1 ), Upvalue2:NextNumber( -1, 1 ) ) * ( Captured.Jitter or 0 )
    local Zero2 = Value + Zero
    local Rad = math.rad( Zero2.Y )
    table.insert( Table, ( LookAt * CFrame.Angles( Rad, -math.rad( Zero2.X ), 0 ) ).LookVector )
end

return Table
]]

--[[
Function #36 has no emitted closure site
It is reproduced here so that nothing is lost

local X = Argument1.X
local Max = math.max( 0, Argument1.Y - 2.9 )
return Vector3.new( X, Max, Argument1.Z ).Magnitude
]]

--[[
Function #37 has no emitted closure site
It is reproduced here so that nothing is lost

local Origin = Upvalue1.Origin + Amount * math.max( 0, ( Upvalue2 - Upvalue1.Origin ):Dot( Amount ) )

if Upvalue3.Scoped then
    Upvalue2 = Origin
end

local Model2
local Entry = Upvalue4.folders[ Upvalue5 ]

if Upvalue3.Vehicle then
    local Model = Upvalue3.Vehicle.Model

    if Model then
        Model2 = Model
    else
        Model2 = nil
    end
else
    Model2 = nil
end

local Carrying2

if typeof( Upvalue3.Carrying ) == "Instance" then
    local Carrying = Upvalue3.Carrying

    if Carrying then
        Carrying2 = Carrying
    else
        Carrying2 = nil
    end
else
    Carrying2 = nil
end

local Entry3

if Carrying2 then
    local Entry2 = Upvalue4.folders[ Carrying2 ]

    if Entry2 then
        Entry3 = Entry2
    else
        Entry3 = nil
    end
else
    Entry3 = nil
end

local Value1
local Table = { }
local Table2 = {
    Upvalue5,
    Upvalue6,
    Entry or false,
    Model2 or false,
    Entry3 or false,
    Carrying2 or false
}
Value1 = nil

for Key, Value in Table2, nil, nil do
    if Value then
        table.insert( Table, Value )
    end
end
if Model2 then
    for Key2, Value2 in Model2:GetDescendants( ) do
        local IsA2
        local IsA = Value2:IsA( "Seat" )

        if IsA then
            IsA2 = IsA
        else
            IsA2 = Value2:IsA( "VehicleSeat" )
        end

        local IsA3

        if IsA2 then
            local Occupant = Value2.Occupant

            if Occupant then
                IsA3 = Value2.Occupant.Parent
            else
                IsA3 = Occupant
            end
        else
            IsA3 = IsA2
        end
        if IsA3 and IsA3 ~= Upvalue5 then
            table.insert( Table, IsA3 )

            if Upvalue4.folders[ IsA3 ] then
                table.insert( Table, Upvalue4.folders[ IsA3 ] )
            end
        end
    end
end

local Position
Upvalue7.FilterDescendantsInstances = table.clone( Table )
local Value3 = Upvalue8( Origin, Amount * Upvalue9.Damage.Range, Upvalue7 )

if not Value3 or not Value3.Position then
    Position = Origin + Amount * Upvalue9.Damage.Range
else
    Position = Value3.Position
end
if Upvalue10.Find( "Cars" ) then
    local _, Value4 = Upvalue11( Origin, Amount, ( Position - Origin ).Magnitude, table.clone( Table ) )

    if Value4 then
        Position = Value4
    end
end
if Upvalue9.Fire.Mode == "Rocket" then
    local Muzzle
    local Of = Upvalue12.Of( Upvalue13 )

    if Of then
        Muzzle = Of:FindFirstChild( "Muzzle" )
    else
        Muzzle = Of
    end

    local WorldPosition = Muzzle and Muzzle.WorldPosition or Upvalue2
    local Unit
    local Position2 = Position - WorldPosition
    Unit = Position2.Magnitude > 1 and Position2.Unit or Amount
    local AimScale2
    Upvalue14 = Upvalue14 + 1
    Upvalue15 = Upvalue15 + 1
    local Out = Upvalue16.Out
    local FireServer = Upvalue17.Fire.FireServer
    local Fire = Upvalue17.Fire
    local Text = tostring( Upvalue14 )
    local Origin2 = Upvalue18.Origin
    Out( FireServer, Fire, WorldPosition, Unit, Text, nil, nil, nil, nil, nil, nil, Upvalue15, Origin2, Upvalue18.Direction.Unit, Position )
    local Launch = Upvalue19.Launch
    local Text2 = Upvalue20.UserId .. ":" .. Upvalue14
    Launch( Text2, Upvalue5, WorldPosition, Unit, Upvalue9.Fire.Rocket, Upvalue9.RocketSounds )
    Upvalue13:SetAttribute( "Ammo", Upvalue21 )
    Upvalue13:SetAttribute( "ShotFX", os.clock( ) )

    if Upvalue3.Aiming then
        local AimScale = Upvalue9.Recoil.AimScale

        if AimScale then
            AimScale2 = AimScale
        else
            AimScale2 = 1
        end
    else
        AimScale2 = 1
    end

    Upvalue22 = Upvalue22 + Vector2.new( Upvalue9.Recoil.Up * AimScale2 * Upvalue23:NextNumber( 0.85, 1.15 ), Upvalue9.Recoil.Side * AimScale2 * Upvalue23:NextNumber( -1, 1 ) )
    Upvalue24( )

    if Upvalue21 <= 0 then
        task.delay( 0.35, Upvalue25 )
    end

    return "rocket"
end
local Flag

if not Upvalue26.SeatPart or Upvalue3.Scoped or not Upvalue27 then
    Flag = false
else
    local Number4
    local Position3 = Upvalue27.Position
    local Origin3 = Origin - Position3

    local function Over( Argument1 )
        local X = Argument1.X
        local Max = math.max( 0, Argument1.Y - 2.9 )
        return Vector3.new( X, Max, Argument1.Z ).Magnitude
    end

    local X = Origin3.X
    local Max = math.max( 0, Origin3.Y - 2.9 )

    if Vector3.new( X, Max, Origin3.Z ).Magnitude > 2.4 then
        local Number, Number2
        local I = 1
        Number = 0
        Number2 = 1

        for I = 1, 12 do
            local Number3 = ( Number + Number2 ) / 2
            local Origin4 = Origin3 * Number3
            local X2 = Origin4.X
            local Max2 = math.max( 0, Origin4.Y - 2.9 )

            if Vector3.new( X2, Max2, Origin4.Z ).Magnitude > 2.4 then
                Number2 = Number3
            else
                Number = Number3
            end
        end

        Number4 = Number
    else
        Number4 = 1
    end

    local Position4 = Position3 + Origin3 * Number4

    if not ( ( Position4 - Position3 ).Magnitude > 0.05 ) or workspace:Raycast( Position3, Position4 - Position3, Upvalue7 ) then
        Flag = false
    else
        Upvalue2 = Position4
        Flag = true
    end
end

local Unit2
local Position5 = Position - Upvalue2
Unit2 = Position5.Magnitude > 0.01 and Position5.Unit or Amount
local Entry7

if Value3 then
    local Instance = Value3.Instance
    local Entry4 = Upvalue4.parts[ Instance ]

    if Entry4 then
        Entry7 = Entry4.char
    else
        Entry7 = Entry4
    end
else
    Entry7 = Value3
end

local Magnitude
local FilterDescendantsInstances = table.clone( Table )
local Value5 = Upvalue8( Upvalue2, Unit2 * Upvalue9.Damage.Range, Upvalue7 )
local I2 = 1
Magnitude = nil

for I2 = 1, 4 do
    local Entry6

    if Value5 then
        local Instance2 = Value5.Instance
        local Entry5 = Upvalue4.parts[ Instance2 ]

        if Entry5 then
            Entry6 = Entry5.char
        else
            Entry6 = Entry5
        end
    else
        Entry6 = Value5
    end
    if not Entry6 or Entry6 == Entry7 then
        break
    end

    Magnitude = ( Value5.Position - Upvalue2 ).Magnitude
    table.insert( FilterDescendantsInstances, Upvalue4.folders[ Entry6 ] )
    Upvalue7.FilterDescendantsInstances = FilterDescendantsInstances
    Value5 = Upvalue8( Upvalue2, Unit2 * Upvalue9.Damage.Range, Upvalue7 )
end

local Of2

if Upvalue13 then
    Of2 = Upvalue12.Of( Upvalue13 )
else
    Of2 = Upvalue13
end

local Muzzle2

if Of2 then
    Muzzle2 = Of2:FindFirstChild( "Muzzle" )
else
    Muzzle2 = Of2
end
if Muzzle2 and not Flag then
    local Magnitude3
    local WorldPosition2 = Muzzle2.WorldPosition

    if Value5 then
        local Magnitude2 = ( Value5.Position - Upvalue2 ).Magnitude

        if Magnitude2 then
            Magnitude3 = Magnitude2
        else
            Magnitude3 = math.huge
        end
    else
        Magnitude3 = math.huge
    end

    local Value7
    Upvalue7.FilterDescendantsInstances = FilterDescendantsInstances
    local Value6 = Upvalue8( Upvalue2, WorldPosition2 - Upvalue2, Upvalue7 )

    if Value6 then
        Value7 = Value6
    else
        Value7 = Upvalue8( WorldPosition2, Unit2 * 6, Upvalue7 )
    end
    if Value7 then
        local Entry9
        local Instance3 = Value7.Instance
        local Entry8 = Upvalue4.parts[ Instance3 ]
        Entry9 = if Entry8 then Entry8.char else Entry8

        if not Entry9 and ( Value7.Position - Upvalue2 ).Magnitude < Magnitude3 - 0.05 then
            Value5 = Value7
        end
    end
end

local Position6

if not Value5 or not Value5.Position then
    Position6 = Upvalue2 + Unit2 * Upvalue9.Damage.Range
else
    Position6 = Value5.Position
end

local Magnitude5
local Find = Upvalue10.Find( "Cars" )

if Value5 then
    local Magnitude4 = ( Position6 - Upvalue2 ).Magnitude

    if Magnitude4 then
        Magnitude5 = Magnitude4
    else
        Magnitude5 = Upvalue9.Damage.Range
    end
else
    Magnitude5 = Upvalue9.Damage.Range
end
if Value5 and Value5.Instance.Name:sub( 1, 6 ) == "Armor_" then
    local Find2 = Upvalue28.Find
    local _, Find22 = Find2( Value5.Instance, Position6, Unit2 )

    if Find22 then
        Magnitude5 = ( Find22 - Upvalue2 ).Magnitude
    end
end

local Flag2 = Upvalue9.Damage.PierceGlass == true and true or false
local Value9
local Table3 = { }

if not Find or Flag2 then
    Value9 = nil
else
    local Value8 = Upvalue29( Upvalue2, Unit2, Magnitude5 + 0.05, Table, Find )

    if Value8 then
        Value9 = Value8
    else
        Value9 = nil
    end
end
if Value9 then
    Value5 = Value9
    Position6 = Value9.Position
    Table3 = { Value9.Instance }
end

local Entry10 = if Value5 then Upvalue4.parts[ Value5.Instance ] else Value5
local Instance6 = Value5 and not Entry10 and Find and Value5.Instance:IsDescendantOf( Find ) and Value5.Instance or nil
local Captured, Table8, Find6
local Table4 = { }

if not Entry10 or not Upvalue9.Damage.Collateral then
    Captured = Position6
    Table8 = nil
    Find6 = Value5
else
    local Entry12
    local FilterDescendantsInstances2 = table.clone( FilterDescendantsInstances )
    local Entry11 = Upvalue4.folders[ Entry10.char ]
    Entry12 = if Entry11 then Entry11 else Value5.Instance
    table.insert( FilterDescendantsInstances2, Entry12 )
    local Table5 = { [ Entry10.char ] = true }
    local Table6 = { }
    Captured = Upvalue2 + Unit2 * Upvalue9.Damage.Range
    local I3 = 1
    Find6 = nil

    for I3 = 1, 30 do
        local Entry13
        Upvalue7.FilterDescendantsInstances = FilterDescendantsInstances2
        local Value10 = Upvalue8( Upvalue2, Unit2 * Upvalue9.Damage.Range, Upvalue7 )
        Entry13 = if Value10 then Upvalue4.parts[ Value10.Instance ] else Value10

        if not Entry13 then
            if not Value10 then
                Find6 = nil
                break
            end

            Captured = Value10.Position
            Find6 = Value10
            break
        end
        if not Table5[ Entry13.char ] then
            Table5[ Entry13.char ] = true
            table.insert( Table6, { Entry13.char, Entry13.name, Value10.Position } )
            table.insert( Table4, { box = Entry13, pos = Value10.Position } )
        end

        local Entry15
        local Entry14 = Upvalue4.folders[ Entry13.char ]
        Entry15 = if Entry14 then Entry14 else Value10.Instance

        table.insert( FilterDescendantsInstances2, Entry15 )
        Find6 = nil
    end

    local Find3

    if Find then
        local NotFlag = not Flag2

        if NotFlag then
            Find3 = Upvalue29( Upvalue2, Unit2, ( Captured - Upvalue2 ).Magnitude + 0.05, Table, Find )
        else
            Find3 = NotFlag
        end
    else
        Find3 = Find
    end
    if Find3 then
        local Magnitude6 = ( Find3.Position - Upvalue2 ).Magnitude
        local Count = #Table6
        local I4 = Count

        for I4 = Count, 1, -1 do
            if Magnitude6 < ( Table6[ I4 ][ 3 ] - Upvalue2 ).Magnitude then
                table.remove( Table6, I4 )
                table.remove( Table4, I4 )
            end
        end

        Captured = Find3.Position
        Table3 = { Find3.Instance }
        Find6 = Find3
    end

    Upvalue7.FilterDescendantsInstances = FilterDescendantsInstances

    if #Table6 == 0 then
        Table8 = nil
    else
        Table8 = Table6
    end
end
if Flag2 and Find then
    local Value12
    local Table7 = { }
    local Value11 = Upvalue11( Upvalue2, Unit2, math.max( Magnitude5, ( Captured - Upvalue2 ).Magnitude ) + 0.05, table.clone( Table ) )
    Value12 = nil

    for Key3, Value13 in Value11, nil, nil do
        if Value13:IsDescendantOf( Find ) then
            table.insert( Table7, Value13 )
        end

        Table3 = Table7
    end

    Table3 = Table7
end
if Upvalue30.OnGlass then
    local Value14 = nil

    for Key4, Value15 in Table3, nil, nil do
        Upvalue30.OnGlass( Value15, Unit2 )
    end
end

local Value16 = nil

for Key5, Value17 in Table3, nil, nil do
    Upvalue31[ Value17 ] = os.clock( )
end

local Entry16
Upvalue3.ShotCount = ( Upvalue3.ShotCount or 0 ) + 1
Upvalue15 = Upvalue15 + 1
local Out2 = Upvalue16.Out
local FireServer2 = Upvalue17.Fire.FireServer
local Fire2 = Upvalue17.Fire
Entry16 = if Entry10 then Entry10.char else Entry10
local Entry17 = if Entry10 then Entry10.name else Entry10
local Position7 = Value5 and Position6
local Origin5 = Upvalue18.Origin
Out2( FireServer2, Fire2, Upvalue2, Unit2, Entry16, Entry17, Position7, Instance6, Table3, Table8, Amount2, Upvalue15, Origin5, Upvalue18.Direction.Unit, Position )

if not Entry10 and Upvalue3.HoodShot then
    local Instance4

    if Value3 then
        Instance4 = Value3.Instance
    else
        Instance4 = Value3
    end

    local Position8

    if Value3 then
        Position8 = Value3.Position
    else
        Position8 = Value3
    end

    local HoodCamHit3
    local HoodCamHit = Upvalue3.HoodCamHit

    if HoodCamHit then
        local HoodCamHit2 = Upvalue3.HoodCamHit
        local Origin6 = Upvalue1.Origin
        HoodCamHit3 = HoodCamHit2( Origin6, Amount, ( Origin - Upvalue1.Origin ).Magnitude + 1 )
    else
        HoodCamHit3 = HoodCamHit
    end
    if HoodCamHit3 then
        Instance4 = HoodCamHit3.Instance
        Position8 = HoodCamHit3.Position
    end

    local Instance5
    local HoodShot = Upvalue3.HoodShot
    Instance5 = if Value5 then Value5.Instance else Value5
    HoodShot( Instance5, Position6, Instance4, Position8, Upvalue2 )
end
if not Entry10 and Value5 and Upvalue3.RangeShot then
    local RangeShot = Upvalue3.RangeShot
    pcall( RangeShot, Value5.Instance, Position6, Upvalue2 )
end

local Captured3
local Magnitude7 = ( Captured - Upvalue2 ).Magnitude

if not Magnitude or not ( Magnitude + 2.5 < Magnitude7 - 1 ) then
    Captured3 = nil
else
    local Captured2 = Upvalue2 + Unit2 * ( Magnitude + 2.5 )

    if Captured2 then
        Captured3 = Captured2
    else
        Captured3 = nil
    end
end

local Find4
local Shot = Upvalue30.Shot
Find4 = if Find6 then Find6.Normal else Find6
local Find5 = if Find6 then Find6.Instance else Find6
local Flag3

if Amount2 == nil then
    Flag3 = false
elseif Amount2 > 1 then
    Flag3 = true
else
    Flag3 = false
end

Shot( Upvalue13, Upvalue2, Captured, Find4, nil, Captured3, Find5, Flag3 )

if Entry10 then
    Upvalue32( Entry10, ( Position6 - Upvalue2 ).Magnitude )
end

local Value18 = nil

for Key6, Value19 in Table4, nil, nil do
    Upvalue32( Value19.box, ( Value19.pos - Upvalue2 ).Magnitude )
end
if workspace:GetAttribute( "DebugHits" ) then
    local Model3

    if Value5 then
        Model3 = Value5.Instance:FindFirstAncestorOfClass( "Model" )
    else
        Model3 = Value5
    end

    local FullName2

    if Value5 then
        local FullName = Value5.Instance:GetFullName( )

        if FullName then
            FullName2 = FullName
        else
            FullName2 = "rien"
        end
    else
        FullName2 = "rien"
    end

    local Name = Model3 and Model3.Name or "-"
    print( ( "[TIR] touche : %s (modèle %s)" ):format( FullName2, Name ) )
end

return
]]

-- Could not structure function #38

--[[
Function #39 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end

Upvalue2.StopReload( Upvalue1 )

if Upvalue3 then
    Upvalue3:Disconnect( )
    Upvalue3 = nil
end

Upvalue1 = nil
Upvalue4 = nil
Upvalue5 = false
Upvalue6 = Upvalue6 + 1
Upvalue7.Equipped = false
Upvalue7.Aiming = false
Upvalue7.LaserFire = false
Upvalue7.Reloading = false
Upvalue7.Combat = false
Upvalue7.Scoped = false
Upvalue7.ScopeShake = nil
Upvalue8 = nil
Upvalue9 = 0
Upvalue10.Visible = false
Upvalue11.Visible = false
Upvalue12.Visible = false
]]

--[[
Function #40 has no emitted closure site
It is reproduced here so that nothing is lost

local MagSize2
local MagSize = Upvalue1:GetAttribute( "MagSize" )
MagSize2 = if MagSize then MagSize else Upvalue2.Ammo.Mag
local Flag = Upvalue1:GetAttribute( "AmmoFresh" ) == true and true or false
local FitAmmo = Upvalue3.FitAmmo( Upvalue4, Upvalue5, MagSize2, Flag )

if FitAmmo < Upvalue4 and not Flag and not Upvalue6.InfiniteAmmo then
    Upvalue7 = Upvalue7 + ( Upvalue4 - FitAmmo )
end

Upvalue4 = FitAmmo
Upvalue5 = MagSize2
Upvalue8( )
]]

--[[
Function #41 has no emitted closure site
It is reproduced here so that nothing is lost

local Entry = Upvalue1[ Object:GetAttribute( "Weapon" ) ]

if not Entry then
    return
end

Upvalue2 = Object
Upvalue3 = Entry
local Prepare = Upvalue4.Prepare
local Of = Upvalue5.Of( Object )
Prepare( Object, Of, true, Upvalue6.IsSilenced( Object ) )
Upvalue7.Cancel( Object )
Upvalue8 = 0
local BoltReadyAt = Object:GetAttribute( "BoltReadyAt" )

if Entry.Fire.SwapCooldown and Entry.Fire.BoltTime and BoltReadyAt then
    Upvalue8 = BoltReadyAt - Entry.Fire.BoltTime + Entry.Fire.SwapCooldown
end

local MagSize2
local MagSize = Object:GetAttribute( "MagSize" )
MagSize2 = if MagSize then MagSize else Entry.Ammo.Mag
local Ammo2
Upvalue9 = MagSize2
local Ammo = Object:GetAttribute( "Ammo" )
Ammo2 = if Ammo then Ammo else Upvalue9
local Reserve2
Upvalue10 = Ammo2
local Reserve = Object:GetAttribute( "Reserve" )
Reserve2 = if Reserve then Reserve else Entry.Ammo.Reserve
Upvalue11 = Reserve2

if Upvalue12 then
    Upvalue12:Disconnect( )
end

local Aiming
Upvalue12 = Object:GetAttributeChangedSignal( "MagSize" ):Connect( function()
    local MagSize2
    local MagSize = Object:GetAttribute( "MagSize" )
    MagSize2 = if MagSize then MagSize else Entry.Ammo.Mag
    local Flag = Object:GetAttribute( "AmmoFresh" ) == true and true or false
    local FitAmmo = Upvalue13.FitAmmo( Upvalue10, Upvalue9, MagSize2, Flag )

    if FitAmmo < Upvalue10 and not Flag and not Upvalue14.InfiniteAmmo then
        Upvalue11 = Upvalue11 + ( Upvalue10 - FitAmmo )
    end

    Upvalue10 = FitAmmo
    Upvalue9 = MagSize2
    Upvalue15( )
end )
Upvalue16 = 0
Upvalue17 = -math.huge
Upvalue18 = os.clock( ) + Entry.Handling.EquipTime
Upvalue19.Equipped = true
local NotCursorFree = not Upvalue19.CursorFree
Aiming = if NotCursorFree then Upvalue20.IsDown( "Aim" ) else NotCursorFree
Upvalue19.Aiming = Aiming
Upvalue19.AimWalkSpeed = Entry.Handling.AimWalkSpeed
Upvalue19.AimFOV = Entry.Handling.AimFOV
Upvalue21.Visible = true
Upvalue22.Visible = true
Upvalue23.Visible = false
Upvalue15( )
]]

--[[
Function #42 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) and Object:GetAttribute( "Weapon" ) then
    Upvalue1( Object )
end
]]

--[[
Function #43 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Upvalue1 then
    Upvalue2( )
end
]]

--[[
Function #44 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 < Upvalue1 then
    if not Upvalue2.Spectating then
        local Health = os.clock( )

        if not ( Health - Upvalue3.health < 0.05 ) then
            Upvalue3.health = Health

            if true then
                Upvalue5 = math.min( 0.42, math.max( Upvalue5, 0.15 ) + 0.3 )
            else
                Upvalue4 = math.min( 0.42, math.max( Upvalue4, 0.15 ) + 0.3 )
            end
        end
    end
end

Upvalue1 = Argument1
]]

--[[
Function #45 has no emitted closure site
It is reproduced here so that nothing is lost

local Armor = Upvalue1:GetAttribute( "Armor" ) or 0

if Armor < Upvalue2 and not Upvalue1:GetAttribute( "ArmorSilent" ) then
    if not Upvalue3.Spectating then
        local Armor2 = os.clock( )

        if not ( Armor2 - Upvalue4.armor < 0.05 ) then
            Upvalue4.armor = Armor2

            if false then
                Upvalue6 = math.min( 0.42, math.max( Upvalue6, 0.15 ) + 0.3 )
            else
                Upvalue5 = math.min( 0.42, math.max( Upvalue5, 0.15 ) + 0.3 )
            end
        end
    end
end

Upvalue2 = Armor
]]

--[[
Function #46 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1( )
Upvalue2 = Object
Upvalue3 = Object:WaitForChild( "Humanoid" )
Upvalue4 = Object:WaitForChild( "HumanoidRootPart" )
Object.ChildAdded:Connect( function( Object )
    if Object:IsA( "Tool" ) and Object:GetAttribute( "Weapon" ) then
        Upvalue5( Object )
    end
end )
Object.ChildRemoved:Connect( function( Argument1 )
    if Argument1 == Upvalue6 then
        Upvalue1( )
    end
end )
local Health = Upvalue3.Health
Upvalue3.HealthChanged:Connect( function( Argument1 )
    if Argument1 < Health then
        if not Upvalue7.Spectating then
            local HealthInner = os.clock( )

            if not ( HealthInner - Upvalue8.health < 0.05 ) then
                Upvalue8.health = HealthInner

                if true then
                    Upvalue10 = math.min( 0.42, math.max( Upvalue10, 0.15 ) + 0.3 )
                else
                    Upvalue9 = math.min( 0.42, math.max( Upvalue9, 0.15 ) + 0.3 )
                end
            end
        end
    end

    Health = Argument1
end )
local Armor = Object:GetAttribute( "Armor" ) or 0
Object:GetAttributeChangedSignal( "Armor" ):Connect( function()
    local ArmorInner = Object:GetAttribute( "Armor" ) or 0

    if ArmorInner < Armor and not Object:GetAttribute( "ArmorSilent" ) then
        if not Upvalue7.Spectating then
            local Armor2 = os.clock( )

            if not ( Armor2 - Upvalue8.armor < 0.05 ) then
                Upvalue8.armor = Armor2

                if false then
                    Upvalue10 = math.min( 0.42, math.max( Upvalue10, 0.15 ) + 0.3 )
                else
                    Upvalue9 = math.min( 0.42, math.max( Upvalue9, 0.15 ) + 0.3 )
                end
            end
        end
    end

    Armor = ArmorInner
end )
Upvalue3.Died:Connect( Upvalue1 )
]]

--[[
Function #47 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Vehicle = Upvalue1.Vehicle

if Vehicle == nil then
    Flag = false
elseif Vehicle.Driver == true then
    if Argument1.KeyCode == Enum.KeyCode.ButtonR2 then
        Flag = true
    elseif Argument1.KeyCode == Enum.KeyCode.ButtonL2 then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #48 has no emitted closure site
It is reproduced here so that nothing is lost

if not Argument2 and not Upvalue1.CursorFree and Upvalue2.Is( "Shoulder", Argument1 ) then
    Upvalue1.Shoulder = -Upvalue1.Shoulder
    return
end
if not Argument2 and Upvalue3 and not Upvalue1.CursorFree then
    local Flag
    local Vehicle = Upvalue1.Vehicle

    if Vehicle == nil then
        Flag = false
    elseif Vehicle.Driver == true then
        if Argument1.KeyCode == Enum.KeyCode.ButtonR2 then
            Flag = true
        elseif Argument1.KeyCode == Enum.KeyCode.ButtonL2 then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end
    if not Flag then
        if Upvalue1.CaseRolling then
            return
        end

        local Vehicle2 = Upvalue1.Vehicle

        if Vehicle2 and Vehicle2.Driver and Upvalue2.Is( "DriveAim", Argument1 ) then
            Upvalue1.Aiming = true
            return
        end
        if Vehicle2 and Vehicle2.Driver and Upvalue1.Aiming and Upvalue2.Is( "DriveFire", Argument1 ) then
            Upvalue4 = true
            Upvalue5 = os.clock( )
            Upvalue6 = true
            return
        end
        if Upvalue2.Is( "Fire", Argument1 ) then
            Upvalue4 = true
            Upvalue5 = os.clock( )
            Upvalue6 = true
            return
        end
        if Upvalue2.Is( "Aim", Argument1 ) then
            Upvalue1.Aiming = true
            return
        end
        if Upvalue2.Is( "Reload", Argument1 ) then
            if Vehicle2 and Vehicle2.Driver then
                Upvalue7 = os.clock( )
                return
            end

            Upvalue8( true )
        end

        return
    end
end
]]

--[[
Function #49 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1.Is( "Reload", Argument1 ) or not Upvalue2 then
    local Flag2
    local Vehicle2 = Upvalue3.Vehicle

    if Vehicle2 == nil then
        Flag2 = false
    elseif Vehicle2.Driver == true then
        Flag2 = true
    else
        Flag2 = false
    end
    if Flag2 then
        local Flag3
        local Vehicle3 = Upvalue3.Vehicle

        if Vehicle3 == nil then
            Flag3 = false
        elseif Vehicle3.Driver == true then
            if Argument1.KeyCode == Enum.KeyCode.ButtonR2 then
                Flag3 = true
            elseif Argument1.KeyCode == Enum.KeyCode.ButtonL2 then
                Flag3 = true
            else
                Flag3 = false
            end
        else
            Flag3 = false
        end
        if Flag3 then
            return
        end
    end
    if not Upvalue1.Is( "Fire", Argument1 ) then
        if not Upvalue1.Is( "DriveFire", Argument1 ) or not Upvalue6 then
            if Upvalue1.Is( "Aim", Argument1 ) then
                Upvalue3.Aiming = false
                Upvalue7.Release( Upvalue4 )
                Upvalue8 = 0
            elseif Upvalue1.Is( "DriveAim", Argument1 ) and Upvalue3.Aiming then
                if Flag2 or not Upvalue1.IsDown( "Aim" ) then
                    Upvalue3.Aiming = false
                    Upvalue7.Release( Upvalue4 )
                    Upvalue8 = 0
                end
            end

            return
        end
        if not Flag2 and Upvalue1.IsDown( "Fire" ) then
            if Upvalue1.Is( "Aim", Argument1 ) then
                Upvalue3.Aiming = false
                Upvalue7.Release( Upvalue4 )
                Upvalue8 = 0
            elseif Upvalue1.Is( "DriveAim", Argument1 ) and Upvalue3.Aiming then
                if Flag2 or not Upvalue1.IsDown( "Aim" ) then
                    Upvalue3.Aiming = false
                    Upvalue7.Release( Upvalue4 )
                    Upvalue8 = 0
                end
            end

            return
        end
    end

    Upvalue6 = false
    Upvalue7.Release( Upvalue4 )
    Upvalue8 = 0
    return
end
local Flag
local Clock = os.clock( ) - Upvalue2
Upvalue2 = nil
local Vehicle = Upvalue3.Vehicle

if Upvalue3.RepairPressAt == nil then
    Flag = false
elseif math.abs( Upvalue3.RepairPressAt - ( os.clock( ) - Clock ) ) < 0.25 then
    Flag = true
else
    Flag = false
end
if Clock < 0.3 and Upvalue4 and Vehicle and Vehicle.Driver and not Flag then
    Upvalue5( true )
end

return
]]

--[[
Function #50 has no emitted closure site
It is reproduced here so that nothing is lost

local HumanoidRootPart
local Entry = Upvalue1.StanceIds[ Upvalue2.Stance ] or 0
local Floor = math.floor( math.deg( Upvalue2.CamPitch ) + 0.5 )

if Upvalue3 then
    local SeatPart = Upvalue3.SeatPart

    if SeatPart then
        local Parent = Upvalue3.Parent

        if Parent then
            HumanoidRootPart = Upvalue3.Parent:FindFirstChild( "HumanoidRootPart" )
        else
            HumanoidRootPart = Parent
        end
    else
        HumanoidRootPart = SeatPart
    end
else
    HumanoidRootPart = Upvalue3
end

local Floor2

if HumanoidRootPart then
    local VectorToObjectSpace = HumanoidRootPart.CFrame:VectorToObjectSpace( Upvalue4.CFrame.LookVector )
    local Amount = -VectorToObjectSpace.X
    Floor2 = math.floor( math.deg( ( math.atan2( Amount, -VectorToObjectSpace.Z ) ) ) + 0.5 )
else
    Floor2 = nil
end

local Flag

if Floor2 == Upvalue5 then
    Flag = true
elseif Floor2 == nil then
    Flag = false
elseif Upvalue5 == nil then
    Flag = false
elseif math.abs( Floor2 - Upvalue5 ) < 3 then
    Flag = true
else
    Flag = false
end
if Entry == Upvalue6 and math.abs( Floor - Upvalue7 ) < 2 and Flag and Stance - Upvalue8 < 0.5 then
    return
end
if Stance - Upvalue8 < 0.06666666666666667 then
    return
end
Upvalue8 = Stance
Upvalue6 = Entry
Upvalue7 = Floor
Upvalue5 = Floor2
local Out = Upvalue9.Out
local FireServer = Upvalue10.AimState.FireServer
Out( FireServer, Upvalue10.AimState, Entry, Floor, Floor2 )
return
]]

--[[
Function #51 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 == Enum.UserInputState.Begin and Upvalue1 then
    Upvalue2[ Upvalue1 ] = not Upvalue2[ Upvalue1 ] or nil
    Upvalue3.Play( "SightZoom" )
end

return Enum.ContextActionResult.Sink
]]

--[[
Function #52 has no emitted closure site
It is reproduced here so that nothing is lost

if Zoom == Upvalue1 then
    return
end

Upvalue1 = Zoom

if Zoom then
    Upvalue2:BindActionAtPriority( "OpticAltZoom", Upvalue3, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.F, Enum.KeyCode.ButtonL3 )
    return
end
Upvalue2:UnbindAction( "OpticAltZoom" )
return
]]

--[[
Function #53 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 and Upvalue2 then
    Upvalue3.Release( Upvalue2 )
end

Upvalue1 = false
Upvalue4 = 0
]]

--[[
Function #54 has no emitted closure site
It is reproduced here so that nothing is lost

local CaseRolling2
local CaseRolling = Upvalue1.CaseRolling

if CaseRolling then
    CaseRolling2 = CaseRolling
else
    local BetaIntermission = Upvalue1.BetaIntermission

    if BetaIntermission then
        CaseRolling2 = BetaIntermission
    else
        local InCarGarage = Upvalue2:GetAttribute( "InCarGarage" )

        if InCarGarage then
            CaseRolling2 = InCarGarage
        else
            local Active = Upvalue3.Active( Upvalue2.Character )

            if Active then
                CaseRolling2 = Active
            else
                CaseRolling2 = Upvalue4( )
            end
        end
    end
end

return CaseRolling2
]]

--[[
Function #55 has no emitted closure site
It is reproduced here so that nothing is lost

local MaxFireAngle

if Upvalue1 and Upvalue1.SeatPart then
    MaxFireAngle = ( Upvalue1 and Upvalue1.SeatPart ):GetAttribute( "MaxFireAngle" )
else
    MaxFireAngle = Upvalue1 and Upvalue1.SeatPart
end
if type( MaxFireAngle ) ~= "number" then
    return false
end

local Flag
local VectorToObjectSpace = ( Upvalue1 and Upvalue1.SeatPart ).CFrame:VectorToObjectSpace( Upvalue2.CFrame.LookVector )
local X = VectorToObjectSpace.X
local Vector32 = Vector3.new( X, 0, VectorToObjectSpace.Z )

if Vector32.Magnitude > 0.05 then
    if MaxFireAngle < math.deg( ( math.acos( ( math.clamp( -Vector32.Unit.Z, -1, 1 ) ) ) ) ) then
        Flag = true
    else
        Flag = false
    end
else
    Flag = false
end

return Flag
]]

--[[
Function #56 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag
local Vehicle = Upvalue1.Vehicle

if Vehicle == nil then
    Flag = false
elseif Vehicle.Driver == true then
    Flag = true
else
    Flag = false
end
if Flag ~= Upvalue2 then
    Upvalue2 = Flag

    if Upvalue3 and Upvalue4 then
        Upvalue5.Release( Upvalue4 )
    end

    Upvalue3 = false
    Upvalue6 = 0

    if Upvalue1.Aiming then
        Upvalue1.Aiming = false
        Upvalue1.LaserFire = false

        if Upvalue4 then
            Upvalue5.Release( Upvalue4 )
        end

        Upvalue7 = 0
    end
end

local Flag2

if Upvalue8.InfiniteAmmo == true then
    Flag2 = true
elseif Upvalue9 == nil then
    Flag2 = false
elseif Upvalue9:GetAttribute( "InFarmZone" ) == true then
    Flag2 = true
else
    Flag2 = false
end
if Flag2 ~= Upvalue10 then
    Upvalue10 = Flag2

    if Upvalue4 then
        Upvalue11( )
    end
end
if not Upvalue4 or not Upvalue12 or Upvalue12.Health <= 0 then
    Upvalue1.Scoped = false
    Upvalue1.ScopeShake = nil
    Upvalue1.AimZoomK = nil
    Upvalue1.SpreadMultiplier = nil

    if Upvalue13 ~= false then
        Upvalue13 = false
        Upvalue14:UnbindAction( "OpticAltZoom" )
    end
    if Upvalue1.LaserFire then
        Upvalue1.LaserFire = false
        Upvalue1.Aiming = false
    end

    return
end
local Clock = os.clock( )
local Text = Upvalue4:GetAttribute( "Mods" )

if Text ~= Upvalue15.text then
    local Mods = Upvalue16.Decode( Text )
    Upvalue15.text = Text
    Upvalue15.mods = Mods
end

local Mods2 = Upvalue15.mods
local HipFire = Upvalue16.HipFire
Upvalue17 = HipFire( Mods2, Upvalue4:GetAttribute( "Weapon" ) )

if Upvalue1.LaserFire then
    local Flag3

    if Upvalue17 == nil then
        Flag3 = false
    elseif Upvalue1.Aiming == true then
        local NotCursorFree = not Upvalue1.CursorFree

        if NotCursorFree then
            local NotMenuIsOpen = not Upvalue18.MenuIsOpen

            if NotMenuIsOpen then
                Flag3 = not Upvalue1.Vehicle
            else
                Flag3 = NotMenuIsOpen
            end
        else
            Flag3 = NotCursorFree
        end
    else
        Flag3 = false
    end
    if not Flag3 or not Upvalue19.IsDown( "Aim" ) then
        if Flag3 then
            if not Upvalue3 and Clock - math.max( Upvalue20, Upvalue21 ) > 0.35 then
                Upvalue1.LaserFire = false

                if Upvalue1.Aiming and not Upvalue19.IsDown( "Aim" ) then
                    Upvalue1.Aiming = false
                end
            end
        else
            Upvalue1.LaserFire = false

            if Upvalue1.Aiming and not Upvalue19.IsDown( "Aim" ) then
                Upvalue1.Aiming = false
            end
        end
    else
        Upvalue1.LaserFire = false
    end
elseif Upvalue17 and not Upvalue1.Aiming then
    if Upvalue3 then
        if not Upvalue1.CursorFree and not Upvalue18.MenuIsOpen and not Upvalue1.Vehicle and not Upvalue1.Rolling and not Upvalue1.Reloading and Upvalue22 <= Clock then
            local CaseRolling2
            local CaseRolling = Upvalue1.CaseRolling

            if CaseRolling then
                CaseRolling2 = CaseRolling
            else
                local BetaIntermission = Upvalue1.BetaIntermission

                if BetaIntermission then
                    CaseRolling2 = BetaIntermission
                else
                    local InCarGarage = Upvalue23:GetAttribute( "InCarGarage" )

                    if InCarGarage then
                        CaseRolling2 = InCarGarage
                    else
                        local Active = Upvalue24.Active( Upvalue23.Character )

                        if Active then
                            CaseRolling2 = Active
                        else
                            CaseRolling2 = Upvalue25( )
                        end
                    end
                end
            end
            if not CaseRolling2 then
                Upvalue1.LaserFire = true
                Upvalue1.Aiming = true
                Upvalue21 = Clock
                Upvalue1.LaserZoom = Upvalue17.Zoom
            end
        end
    elseif Upvalue6 > 0 and Clock - Upvalue6 < 0.2 then
        if not Upvalue1.CursorFree and not Upvalue18.MenuIsOpen and not Upvalue1.Vehicle and not Upvalue1.Rolling and not Upvalue1.Reloading and Upvalue22 <= Clock then
            local CaseRolling = Upvalue1.CaseRolling

            if CaseRolling then
                CaseRolling2 = CaseRolling
            else
                local BetaIntermission = Upvalue1.BetaIntermission

                if BetaIntermission then
                    CaseRolling2 = BetaIntermission
                else
                    local InCarGarage = Upvalue23:GetAttribute( "InCarGarage" )

                    if InCarGarage then
                        CaseRolling2 = InCarGarage
                    else
                        local Active = Upvalue24.Active( Upvalue23.Character )

                        if Active then
                            CaseRolling2 = Active
                        else
                            CaseRolling2 = Upvalue25( )
                        end
                    end
                end
            end
            if not CaseRolling2 then
                Upvalue1.LaserFire = true
                Upvalue1.Aiming = true
                Upvalue21 = Clock
                Upvalue1.LaserZoom = Upvalue17.Zoom
            end
        end
    end
end

Upvalue1.Combat = Upvalue1.Aiming

if Upvalue1.Reloading then
    Upvalue1.Stance = "Reload"

    if Upvalue1.Combat then
        if Upvalue26.Handling.Pistol or Upvalue26.Ammo.Shell then
            Upvalue1.Stance = "ReloadAim"
        end
    end
elseif Upvalue1.Combat then
    Upvalue1.Stance = "Aim"
elseif Upvalue1.Sprinting then
    Upvalue1.Stance = "Sprint"
else
    Upvalue1.Stance = "Low"
end

local Stance = Upvalue23:GetAttribute( "DebugStance" )

if Stance then
    local Combat
    Upvalue1.Stance = Stance
    Combat = Stance == "Aim" and true or false
    Upvalue1.Combat = Combat
end

Upvalue27( Clock )
local Scope = Upvalue26.Handling.Scope
Upvalue1.SpreadMultiplier = Upvalue16.SpreadScale( Mods2 )

if Mods2.Optic ~= nil then
    Scope = nil
end

local Flag4
local Entry = Upvalue16.Items[ Mods2.Optic or "" ]

if Entry == nil then
    Flag4 = false
elseif Entry.AltZoom == nil then
    Flag4 = false
elseif Upvalue1.Aiming == true then
    local NotLaserFire = not Upvalue1.LaserFire

    if NotLaserFire then
        local NotVehicle = not Upvalue1.Vehicle

        if NotVehicle then
            Flag4 = not Upvalue1.CursorFree
        else
            Flag4 = NotVehicle
        end
    else
        Flag4 = NotLaserFire
    end
else
    Flag4 = false
end

local Flag5
Upvalue28( Flag4 )
local AimFOV = Upvalue26.Handling.AimFOV
local AimFOV2 = Upvalue16.AimFOV
Flag5 = Upvalue29[ Upvalue4 ] == true and true or false
local AimZoomK
Upvalue1.AimFOV = AimFOV2( Mods2, AimFOV, Flag5 )

if Upvalue1.AimFOV < AimFOV then
    local AimFOV3 = Upvalue1.AimFOV / AimFOV

    if AimFOV3 then
        AimZoomK = AimFOV3
    else
        AimZoomK = nil
    end
else
    AimZoomK = nil
end

Upvalue1.AimZoomK = AimZoomK

if not Upvalue1.Aiming or Upvalue1.LaserFire then
    Upvalue30 = nil
else
    Upvalue30 = Upvalue30 or Clock
end

local Scoped

if Scope == nil then
    Scoped = false
elseif Upvalue30 == nil then
    Scoped = false
else
    local Clock2 = Clock - Upvalue30

    if ( Scope.Delay or 0 ) <= Clock2 then
        if Upvalue22 <= Clock then
            local NotReloading = not Upvalue1.Reloading

            if NotReloading then
                local NotRolling = not Upvalue1.Rolling

                if NotRolling then
                    local NotWardrobeFocusX = not Upvalue1.WardrobeFocusX

                    if NotWardrobeFocusX then
                        Scoped = not Upvalue1.LaserFire
                    else
                        Scoped = NotWardrobeFocusX
                    end
                else
                    Scoped = NotRolling
                end
            else
                Scoped = NotReloading
            end
        else
            Scoped = false
        end
    else
        Scoped = false
    end
end

local ScopeFOV
Upvalue1.Scoped = Scoped
ScopeFOV = Scope and Scope.FOV or nil
local ScopeOverlay
Upvalue1.ScopeFOV = ScopeFOV
ScopeOverlay = Scope and Scope.Overlay or nil
local ScopeShake2
Upvalue1.ScopeOverlay = ScopeOverlay

if Scoped then
    local ScopeShake = Upvalue31.ScopeShake( Upvalue31.Progress( Upvalue4 ) )

    if ScopeShake then
        ScopeShake2 = ScopeShake
    else
        ScopeShake2 = nil
    end
else
    ScopeShake2 = nil
end

Upvalue1.ScopeShake = ScopeShake2

if Clock - Upvalue20 > 0.15 then
    Upvalue32 = math.max( 0, Upvalue32 - Upvalue26.Bloom.Recovery * Argument1 )
end

local Rawget
Upvalue33 = Upvalue33 * math.exp( -Upvalue26.Recoil.Return * Argument1 )
local Lerp = Upvalue34:Lerp( Upvalue33, 1 - math.exp( -Argument1 * 35 ) )
local Lerp2 = Lerp - Upvalue34
Upvalue34 = Lerp
Upvalue35 = Upvalue35 + math.rad( Lerp2.X )
Upvalue36 = Upvalue36 + math.rad( Lerp2.Y )

if Upvalue37 then
    Rawget = rawget( Upvalue1, Upvalue37 )
else
    Rawget = Upvalue37
end
if Rawget then
    Rawget( Upvalue35, Upvalue36 )
    Upvalue35 = 0
    Upvalue36 = 0
end
if Upvalue38 <= 0 and not Upvalue1.Reloading and Upvalue22 <= Clock and Clock - Upvalue20 >= 0.2 then
    Upvalue39( )
end

local Captured

if Upvalue26.Fire.Mode == "Auto" then
    Captured = Upvalue3
else
    local Flag6

    if Upvalue6 > 0 then
        if Clock - Upvalue6 < 0.2 then
            Flag6 = true
        else
            Flag6 = false
        end
    else
        Flag6 = false
    end

    Captured = Flag6
end
if Upvalue40 and Upvalue1.TestFire == true then
    Captured = true
end
if Upvalue1.CursorFree or Upvalue18.MenuIsOpen then
    if Upvalue3 or Upvalue6 > 0 then
        if Upvalue3 then
            Upvalue5.Release( Upvalue4 )
        end

        Upvalue3 = false
        Upvalue6 = 0
        Captured = false
    end
end
if Captured and Upvalue1.Aiming and Upvalue1.Reloading and Upvalue41 and Upvalue38 > 0 then
    Upvalue41( )
    Upvalue6 = Clock
end

local CaseRolling4
local CaseRolling3 = Upvalue1.CaseRolling

if CaseRolling3 then
    CaseRolling4 = CaseRolling3
else
    local BetaIntermission2 = Upvalue1.BetaIntermission

    if BetaIntermission2 then
        CaseRolling4 = BetaIntermission2
    else
        local InCarGarage2 = Upvalue23:GetAttribute( "InCarGarage" )

        if InCarGarage2 then
            CaseRolling4 = InCarGarage2
        else
            local Active2 = Upvalue24.Active( Upvalue23.Character )

            if Active2 then
                CaseRolling4 = Active2
            else
                CaseRolling4 = Upvalue25( )
            end
        end
    end
end
if CaseRolling4 then
    Upvalue3 = false
    Upvalue6 = 0
    Captured = false
end
if Captured and Upvalue1.Aiming and not Upvalue42( ) and not Upvalue1.Rolling and not Upvalue1.Reloading and Upvalue22 <= Clock and Upvalue43 <= Clock then
    local Clock3 = Clock - Upvalue20

    if 60 / Upvalue26.Fire.RPM <= Clock3 then
        Upvalue6 = 0

        if Upvalue38 > 0 then
            Upvalue44( Clock )
            Upvalue45 = false
        elseif Upvalue46 <= 0 then
            local Flag7

            if Upvalue8.InfiniteAmmo == true then
                Flag7 = true
            elseif Upvalue9 == nil then
                Flag7 = false
            elseif Upvalue9:GetAttribute( "InFarmZone" ) == true then
                Flag7 = true
            else
                Flag7 = false
            end
            if Flag7 then
                Upvalue39( true )
            elseif Upvalue45 then
                Upvalue45 = false
                Upvalue47.Play( "NoAmmo" )
            end
        else
            Upvalue39( true )
        end
    end
end

local Aim
Upvalue1.Spread = Upvalue48( )

if not Upvalue1.LaserFire or not Upvalue17 then
    if Upvalue1.Aiming then
        local Aim2 = Upvalue26.Bloom.Aim

        if Aim2 then
            Aim = Aim2
        else
            Aim = Upvalue26.Bloom.Hip
        end
    else
        Aim = Upvalue26.Bloom.Hip
    end
else
    Aim = Upvalue26.Bloom.Aim + ( Upvalue26.Bloom.Hip - Upvalue26.Bloom.Aim ) * math.clamp( tonumber( Upvalue17.Bloom ) or 0, 0, 1 )
end

Upvalue1.SpreadRest = math.min( Aim, Upvalue26.Bloom.Max ) * ( Upvalue1.SpreadMultiplier or 1 ) * ( Upvalue8.BloomScale or 1 )
return
]]

--[[
Function #57 has no emitted closure site
It is reproduced here so that nothing is lost

local Of

if Upvalue1.Parent == Upvalue2 then
    Of = Upvalue3.Of( Upvalue1 )
else
    Of = false
end
if Of and Upvalue1.Parent == Upvalue2 then
    local Prepare = Upvalue4.Prepare
    Prepare( Upvalue1, Of, false, Upvalue5.IsSilenced( Upvalue1 ) )
end
]]

--[[
Function #58 has no emitted closure site
It is reproduced here so that nothing is lost

if Object:IsA( "Tool" ) and Object:GetAttribute( "Weapon" ) then
    task.defer( function()
        local Of

        if Object.Parent == Upvalue1 then
            Of = Upvalue2.Of( Object )
        else
            Of = false
        end
        if Of and Object.Parent == Upvalue1 then
            local Prepare = Upvalue3.Prepare
            Prepare( Object, Of, false, Upvalue4.IsSilenced( Object ) )
        end
    end )
end
]]

--[[
Function #59 has no emitted closure site
It is reproduced here so that nothing is lost

local function OnTool( ObjectInner )
    if ObjectInner:IsA( "Tool" ) and ObjectInner:GetAttribute( "Weapon" ) then
        task.defer( function()
            local Of

            if ObjectInner.Parent == Object then
                Of = Upvalue1.Of( ObjectInner )
            else
                Of = false
            end
            if Of and ObjectInner.Parent == Object then
                local Prepare = Upvalue2.Prepare
                Prepare( ObjectInner, Of, false, Upvalue3.IsSilenced( ObjectInner ) )
            end
        end )
    end
end

Object.ChildAdded:Connect( OnTool )

for Key, Value in Object:GetChildren( ) do
    if Value:IsA( "Tool" ) and Value:GetAttribute( "Weapon" ) then
        task.defer( function()
            local Of

            if Value.Parent == Object then
                Of = Upvalue1.Of( Value )
            else
                Of = false
            end
            if Of and Value.Parent == Object then
                local Prepare = Upvalue2.Prepare
                Prepare( Value, Of, false, Upvalue3.IsSilenced( Value ) )
            end
        end )
    end
end
]]

--[[
Function #60 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument1 == Upvalue1 then
    return
end

local function OnChar( Object )
    local function OnTool( ObjectInner )
        if ObjectInner:IsA( "Tool" ) and ObjectInner:GetAttribute( "Weapon" ) then
            task.defer( function()
                local Of

                if ObjectInner.Parent == Object then
                    Of = Upvalue2.Of( ObjectInner )
                else
                    Of = false
                end
                if Of and ObjectInner.Parent == Object then
                    local Prepare = Upvalue3.Prepare
                    Prepare( ObjectInner, Of, false, Upvalue4.IsSilenced( ObjectInner ) )
                end
            end )
        end
    end

    Object.ChildAdded:Connect( OnTool )

    for Key, Value in Object:GetChildren( ) do
        if Value:IsA( "Tool" ) and Value:GetAttribute( "Weapon" ) then
            task.defer( function()
                local Of

                if Value.Parent == Object then
                    Of = Upvalue2.Of( Value )
                else
                    Of = false
                end
                if Of and Value.Parent == Object then
                    local Prepare = Upvalue3.Prepare
                    Prepare( Value, Of, false, Upvalue4.IsSilenced( Value ) )
                end
            end )
        end
    end
end

Argument1.CharacterAdded:Connect( OnChar )

if Argument1.Character then
    OnChar( Argument1.Character )
end
]]

--[[
Function #61 has no emitted closure site
It is reproduced here so that nothing is lost

if typeof( Argument1 ) == "Instance" and typeof( Argument2 ) == "Vector3" and typeof( Argument3 ) == "Vector3" then
    local Blood = Upvalue1.Blood
    Blood( Argument1, Argument3, Argument3 - Argument2 )
end
]]

--[[
Function #62 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument4 and typeof( Argument2 ) == "Vector3" and typeof( Argument3 ) == "Vector3" then
    local Blood = Upvalue1.Blood
    Blood( Argument4, Argument3, Argument3 - Argument2 )
end

local Character

if Object then
    if not Object:IsA( "Player" ) or not Object.Character then
        Character = Object
    else
        Character = Object.Character
    end
else
    Character = Object
end

local GunFX

if Character then
    local Tool = Character:FindFirstChildOfClass( "Tool" )

    if Tool then
        GunFX = Tool
    else
        GunFX = Character:FindFirstChild( "GunFX" )
    end
else
    GunFX = Character
end

local Table, Position

if typeof( Argument2 ) ~= "Vector3" or typeof( Argument3 ) ~= "Vector3" or not ( ( Argument3 - Argument2 ).Magnitude > 0.1 ) then
    Position = Argument3
    Table = nil
else
    local Total = Argument3 - Argument2
    local FilterDescendantsInstances = { Character, Upvalue2, workspace:FindFirstChild( "ClientHitboxes" ) }
    local I = 1
    Table = nil

    for I = 1, 16 do
        Upvalue3.FilterDescendantsInstances = FilterDescendantsInstances
        local Raycast = workspace:Raycast( Argument2, Total + Total.Unit * 0.5, Upvalue3 )

        if not Raycast then
            Table = nil
            break
        end

        local Name = Raycast.Instance.Name

        if Name:sub( 1, 6 ) == "Glass_" then
            table.insert( FilterDescendantsInstances, Raycast.Instance )
        elseif Name:sub( 1, 6 ) ~= "Armor_" then
            Table = Raycast
            break
        else
            local Find = Upvalue4.Find
            local Instance = Raycast.Instance
            local Find2, Find22, Find3 = Find( Instance, Raycast.Position, Total )

            if Find2 then
                Table = { Instance = Find2, Position = Find22, Normal = Find3 }
                break
            end
            table.insert( FilterDescendantsInstances, Raycast.Instance )
        end

        Table = nil
    end
    if not Table or not ( ( Table.Position - Argument2 ).Magnitude < Total.Magnitude - 0.3 ) then
        Position = Argument3
    else
        Position = Table.Position
    end
end

local Table2
local Shot = Upvalue1.Shot
Table2 = if Table then Table.Normal else Table
local Table3 = if Table then Table.Instance else Table
local Flag = Argument5 == true and true or false
Shot( GunFX, Argument2, Position, Table2, true, nil, Table3, Flag )
]]

--[[
Function #63 has no emitted closure site
It is reproduced here so that nothing is lost

local FXReady = Upvalue1:WaitForChild( "FXReady", 30 )

if FXReady then
    FXReady:FireServer( )
end
]]

--[[
Function #64 has no emitted closure site
It is reproduced here so that nothing is lost

local Clock = os.clock( )

if Clock - Upvalue1.health < 0.3 or Clock - Upvalue1.armor < 0.3 then
    return
end

local Armor2

if Upvalue2 then
    local Armor = Upvalue2:GetAttribute( "Armor" )

    if Armor then
        Armor2 = Armor
    else
        Armor2 = 0
    end
else
    Armor2 = 0
end

local Text = not ( Armor2 > 0 ) and "health" or "armor"

if Upvalue3.Spectating then
    return
end

local Text2 = Text or "health"
local Clock2 = os.clock( )

if Clock2 - Upvalue1[ Text2 ] < 0.05 then
    return
end

Upvalue1[ Text2 ] = Clock2

if Text2 == "armor" then
    Upvalue4 = math.min( 0.42, math.max( Upvalue4, 0.15 ) + 0.3 )
    return
end
Upvalue5 = math.min( 0.42, math.max( Upvalue5, 0.15 ) + 0.3 )
return
]]

--[[
Function #65 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1.Spectating then
    return
end
Upvalue2.OnHurt( )
task.delay( 0.12, function()
    local Clock = os.clock( )

    if Clock - Upvalue3.health < 0.3 or Clock - Upvalue3.armor < 0.3 then
        return
    end

    local Armor2

    if Upvalue4 then
        local Armor = Upvalue4:GetAttribute( "Armor" )

        if Armor then
            Armor2 = Armor
        else
            Armor2 = 0
        end
    else
        Armor2 = 0
    end

    local Text = not ( Armor2 > 0 ) and "health" or "armor"

    if Upvalue1.Spectating then
        return
    end

    local Text2 = Text or "health"
    local Clock2 = os.clock( )

    if Clock2 - Upvalue3[ Text2 ] < 0.05 then
        return
    end

    Upvalue3[ Text2 ] = Clock2

    if Text2 == "armor" then
        Upvalue5 = math.min( 0.42, math.max( Upvalue5, 0.15 ) + 0.3 )
        return
    end
    Upvalue6 = math.min( 0.42, math.max( Upvalue6, 0.15 ) + 0.3 )
    return
end )
return
]]
