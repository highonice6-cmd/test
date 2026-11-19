-- Players.perkbrokeyou.PlayerScripts.StretchClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Value7
local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local SoundService = game:GetService( "SoundService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Controls = require( ReplicatedStorage:WaitForChild( "Controls" ) )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local Stretch = require( ReplicatedStorage:WaitForChild( "Stretch" ) )
local LocalPlayer = Players.LocalPlayer
local Value1 = nil
local Value2 = nil
local Value3 = nil
local Value4 = nil
local Value5 = nil
local Flag = false
local Table = { }
local Flag2 = false
local Value6 = nil

local function AnchorOf( Argument1 )
    local Adornee2
    local Adornee = Argument1.Adornee
    Adornee2 = if Adornee then Adornee else Argument1.Parent

    if not Adornee2 then
        return nil
    end
    if Adornee2:IsA( "BasePart" ) then
        return Adornee2.Position
    end
    if Adornee2:IsA( "Attachment" ) then
        return Adornee2.WorldPosition
    end
    return nil
end

local function Refresh( Argument1, Argument2 )
    if Argument2.setSo == nil or Argument1.StudsOffset ~= Argument2.setSo then
        Argument2.so = Argument1.StudsOffset
    end
    if Argument2.setWs == nil or Argument1.StudsOffsetWorldSpace ~= Argument2.setWs then
        Argument2.ws = Argument1.StudsOffsetWorldSpace
    end
end

local RestoreOne = nil

local function Compensate( Key, Argument2, Argument3 )
    if Argument2.setSo == nil or Key.StudsOffset ~= Argument2.setSo then
        Argument2.so = Key.StudsOffset
    end
    if Argument2.setWs == nil or Key.StudsOffsetWorldSpace ~= Argument2.setWs then
        Argument2.ws = Key.StudsOffsetWorldSpace
    end

    local Position
    local Enabled = Key.Enabled

    if Enabled then
        local Adornee2
        local Adornee = Key.Adornee
        Adornee2 = if Adornee then Adornee else Key.Parent

        if Adornee2 then
            if Adornee2:IsA( "BasePart" ) then
                Position = Adornee2.Position
            elseif Adornee2:IsA( "Attachment" ) then
                Position = Adornee2.WorldPosition
            else
                Position = nil
            end
        else
            Position = nil
        end
    else
        Position = Enabled
    end
    if not Position then
        RestoreOne( Key, Argument2 )
        return
    end

    local StudsOffsetWorldSpace
    local Ws = Argument2.ws + Argument3.cf:VectorToWorldSpace( Argument2.so )
    local PointToObjectSpace = Argument3.cf:PointToObjectSpace( Position + Ws )
    StudsOffsetWorldSpace = if PointToObjectSpace.Z < -0.05 then Ws + Argument3.up * ( PointToObjectSpace.Y * Argument3.push ) else Ws

    if Key.StudsOffset ~= Vector3.new( 0, 0, 0 ) then
        Key.StudsOffset = Vector3.new( 0, 0, 0 )
    end

    Key.StudsOffsetWorldSpace = StudsOffsetWorldSpace
    local SetSo = Key.StudsOffset
    local SetWs = Key.StudsOffsetWorldSpace
    Argument2.setSo = SetSo
    Argument2.setWs = SetWs
end

RestoreOne = function( Key, Argument2 )
    if Argument2.setSo ~= nil then
        if Key.StudsOffset == Argument2.setSo then
            Key.StudsOffset = Argument2.so
        end
        if Key.StudsOffsetWorldSpace == Argument2.setWs then
            Key.StudsOffsetWorldSpace = Argument2.ws
        end

        Argument2.setSo = nil
        Argument2.setWs = nil
    end
end

local function WatchAnchor( Key, TableInner )
    if TableInner.anchorConn then
        TableInner.anchorConn:Disconnect( )
        TableInner.anchorConn = nil
    end

    local Adornee2
    local Adornee = Key.Adornee
    Adornee2 = if Adornee then Adornee else Key.Parent

    if Adornee2 and Adornee2:IsA( "BasePart" ) then
        TableInner.anchorConn = Adornee2:GetPropertyChangedSignal( "CFrame" ):Connect( function()
            if Value6 and Table[ Key ] == TableInner then
                Compensate( Key, TableInner, Value6 )
            end
        end )
    end
end

local function Track( Key )
    if not Key:IsA( "BillboardGui" ) or Table[ Key ] or Key:FindFirstAncestorWhichIsA( "ViewportFrame" ) then
        return
    end

    local TableInner = { so = Key.StudsOffset, ws = Key.StudsOffsetWorldSpace }
    Table[ Key ] = TableInner
    pcall( function()
        local Adornee2
        local Adornee = Key.Adornee
        Adornee2 = if Adornee then Adornee else Key.Parent
        local Model

        if Adornee2 then
            if not Adornee2:IsA( "Model" ) or not Adornee2 then
                Model = Adornee2:FindFirstAncestorOfClass( "Model" )
            else
                Model = Adornee2
            end
        else
            Model = Adornee2
        end

        local PlayerFromCharacter

        if Model then
            PlayerFromCharacter = game:GetService( "Players" ):GetPlayerFromCharacter( Model )
        else
            PlayerFromCharacter = Model
        end

        local OnOther

        if PlayerFromCharacter == nil then
            OnOther = false
        elseif PlayerFromCharacter == LocalPlayer then
            OnOther = false
        else
            OnOther = true
        end

        TableInner.onOther = OnOther
    end )
    WatchAnchor( Key, TableInner )
    TableInner.adorneeConn = Key:GetPropertyChangedSignal( "Adornee" ):Connect( function()
        if Table[ Key ] == TableInner then
            WatchAnchor( Key, TableInner )
        end
    end )
    TableInner.enabledConn = Key:GetPropertyChangedSignal( "Enabled" ):Connect( function()
        if Value6 and Table[ Key ] == TableInner and Key.Enabled then
            Compensate( Key, TableInner, Value6 )
        end
    end )

    if Value6 then
        Compensate( Key, TableInner, Value6 )
    end
end

local function Untrack( Key )
    local Entry = Table[ Key ]

    if not Entry then
        return
    end

    Table[ Key ] = nil

    if Entry.anchorConn then
        Entry.anchorConn:Disconnect( )
    end
    if Entry.adorneeConn then
        Entry.adorneeConn:Disconnect( )
    end
    if Entry.enabledConn then
        Entry.enabledConn:Disconnect( )
    end

    RestoreOne( Key, Entry )
end

local Table2 = { workspace, LocalPlayer:WaitForChild( "PlayerGui" ) }
Value7 = nil

for Key, Value in Table2, nil, nil do
    for Key3, Value9 in Value:GetDescendants( ) do
        Track( Value9 )
    end

    Value.DescendantAdded:Connect( Track )
    Value.DescendantRemoving:Connect( Untrack )
end

local function Drop( Key, Argument2 )
    Table[ Key ] = nil
    LocalPlayer:SetAttribute( "BBLocked", ( LocalPlayer:GetAttribute( "BBLocked" ) or 0 ) + 1 )

    if Argument2.onOther then
        LocalPlayer:SetAttribute( "BBLockedOn", ( LocalPlayer:GetAttribute( "BBLockedOn" ) or 0 ) + 1 )
    end

    local Value1
    local TableInner = { Argument2.anchorConn, Argument2.adorneeConn, Argument2.enabledConn }
    Value1 = nil

    for Key2, Value in TableInner, nil, nil do
        if Value then
            Value:Disconnect( )
        end
    end
end

local function PlaceBillboards( CurrentCamera, Argument2 )
    local Value1
    Flag2 = true
    local CFrame = CurrentCamera.CFrame
    local Position = CFrame.Position
    Value6 = {
        cf = CFrame,
        up = CFrame.UpVector,
        push = 1 / ( Argument2 * Argument2 ) - 1
    }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local Success, Result = pcall( function()
            local Enabled2
            local Enabled = Key.Enabled

            if Enabled then
                local Adornee2
                local Adornee = Key.Adornee
                Adornee2 = if Adornee then Adornee else Key.Parent

                if not Adornee2 then
                    return nil
                end
                if Adornee2:IsA( "BasePart" ) then
                    return Adornee2.Position
                end
                if Adornee2:IsA( "Attachment" ) then
                    return Adornee2.WorldPosition
                end

                Enabled2 = nil
            else
                Enabled2 = Enabled
            end

            return Enabled2
        end )

        if Success then
            if not Result or not ( ( Result - Position ).Magnitude <= math.min( 400, Key.MaxDistance ) ) then
                if Value.setSo ~= nil then
                    RestoreOne( Key, Value )
                end
            else
                Compensate( Key, Value, Value6 )
            end
        else
            Drop( Key, Value )
        end
    end
end

local function ReleaseBillboards()
    Value6 = nil

    if not Flag2 then
        return
    end

    local Value1
    Flag2 = false
    Value1 = nil

    for Key, Value in Table, nil, nil do
        RestoreOne( Key, Value )
    end
end

local Table3 = { }
local Number = 1

local function RatioOf( Amount )
    local Total2

    if Amount >= 0 then
        local Total = ( 1 + Amount ) ^ 2

        if Total then
            Total2 = Total
        else
            Total2 = 1 / ( 1 - Amount ) ^ 2
        end
    else
        Total2 = 1 / ( 1 - Amount ) ^ 2
    end

    return Total2
end

local function SquashOf( Amount )
    local Sqrt2

    if Amount >= 1 then
        local Sqrt = math.sqrt( Amount ) - 1

        if Sqrt then
            Sqrt2 = Sqrt
        else
            Sqrt2 = 1 - 1 / math.sqrt( Amount )
        end
    else
        Sqrt2 = 1 - 1 / math.sqrt( Amount )
    end

    return ( math.clamp( Sqrt2, -3, 3 ) )
end

local function StretchedSize( StretchSize, Amount )
    local Value1
    local Sqrt = 1 / math.sqrt( Amount )
    local Table = { }
    local Keypoints = StretchSize.Keypoints
    Value1 = nil

    for Key, Value in Keypoints, nil, nil do
        Table[ Key ] = NumberSequenceKeypoint.new( Value.Time, Value.Value * Sqrt, Value.Envelope * Sqrt )
    end

    return NumberSequence.new( Table )
end

local function StretchedSquash( StretchSquash, Amount )
    local Value1
    local Table = { }
    local Keypoints = StretchSquash.Keypoints
    Value1 = nil

    for Key, Value in Keypoints, nil, nil do
        local Value4
        local Time = Value.Time
        local Value2 = Value.Value

        if Value2 >= 0 then
            local Value3 = ( 1 + Value2 ) ^ 2

            if Value3 then
                Value4 = Value3
            else
                Value4 = 1 / ( 1 - Value2 ) ^ 2
            end
        else
            Value4 = 1 / ( 1 - Value2 ) ^ 2
        end

        local Sqrt2
        local Value5 = Value4 / Amount

        if Value5 >= 1 then
            local Sqrt = math.sqrt( Value5 ) - 1

            if Sqrt then
                Sqrt2 = Sqrt
            else
                Sqrt2 = 1 - 1 / math.sqrt( Value5 )
            end
        else
            Sqrt2 = 1 - 1 / math.sqrt( Value5 )
        end

        Table[ Key ] = NumberSequenceKeypoint.new( Time, math.clamp( Sqrt2, -3, 3 ), Value.Envelope )
    end

    return NumberSequence.new( Table )
end

local function SetEmitter( EmitterName, Amount )
    local Size = EmitterName:GetAttribute( "StretchSize" )
    local Squash = EmitterName:GetAttribute( "StretchSquash" )

    if Amount >= 0.999 or EmitterName.Orientation ~= Enum.ParticleOrientation.FacingCamera then
        if Size then
            EmitterName.Size = Size
            EmitterName.Squash = Squash
            EmitterName:SetAttribute( "StretchSize", nil )
            EmitterName:SetAttribute( "StretchSquash", nil )
        end
    else
        local StretchSize, StretchSquash

        if Size then
            StretchSize = Size
            StretchSquash = Squash
        else
            local Size2 = EmitterName.Size
            local Squash2 = EmitterName.Squash
            EmitterName:SetAttribute( "StretchSize", Size2 )
            EmitterName:SetAttribute( "StretchSquash", Squash2 )
            StretchSize = Size2
            StretchSquash = Squash2
        end

        local Size3 = StretchedSize( StretchSize, Amount )
        local Squash3 = StretchedSquash( StretchSquash, Amount )
        EmitterName.Size = Size3
        EmitterName.Squash = Squash3
    end

    local Entry = Table3[ EmitterName ]

    if Entry then
        local Size4 = EmitterName.Size
        local Squash4 = EmitterName.Squash
        Entry.size = Size4
        Entry.squash = Squash4
    end
end

local function OnEmitterChanged( EmitterName, Attribute, EmitterName2, EmitterName3 )
    local Entry = Table3[ EmitterName ]

    if not Entry or not EmitterName:GetAttribute( Attribute ) or EmitterName[ EmitterName2 ] == Entry[ EmitterName3 ] then
        return
    end
    EmitterName:SetAttribute( Attribute, EmitterName[ EmitterName2 ] )
    SetEmitter( EmitterName, Number )
    return
end

local function TrackEmitter( EmitterName )
    if not EmitterName:IsA( "ParticleEmitter" ) or Table3[ EmitterName ] or EmitterName:FindFirstAncestorWhichIsA( "ViewportFrame" ) then
        return
    end

    Table3[ EmitterName ] = {
        conns = {
            EmitterName:GetPropertyChangedSignal( "Size" ):Connect( function()
                local Entry = Table3[ EmitterName ]

                if Entry and EmitterName:GetAttribute( "StretchSize" ) then
                    if EmitterName.Size == Entry.size then
                        return
                    end

                    EmitterName:SetAttribute( "StretchSize", EmitterName.Size )
                    SetEmitter( EmitterName, Number )
                end
            end ),
            EmitterName:GetPropertyChangedSignal( "Squash" ):Connect( function()
                local Entry = Table3[ EmitterName ]

                if Entry and EmitterName:GetAttribute( "StretchSquash" ) then
                    if EmitterName.Squash == Entry.squash then
                        return
                    end

                    EmitterName:SetAttribute( "StretchSquash", EmitterName.Squash )
                    SetEmitter( EmitterName, Number )
                end
            end ),
            EmitterName:GetPropertyChangedSignal( "Orientation" ):Connect( function()
                SetEmitter( EmitterName, Number )
            end )
        }
    }

    if Number < 0.999 or EmitterName:GetAttribute( "StretchSize" ) then
        SetEmitter( EmitterName, Number )
    end
end

local function UntrackEmitter( EmitterName )
    local Entry = Table3[ EmitterName ]

    if not Entry then
        return
    end

    local Value1
    Table3[ EmitterName ] = nil
    local Conns = Entry.conns
    Value1 = nil

    for Key, Value in Conns, nil, nil do
        Value:Disconnect( )
    end

    local Size = EmitterName:GetAttribute( "StretchSize" )
    local Squash = EmitterName:GetAttribute( "StretchSquash" )

    if Size then
        EmitterName.Size = Size
        EmitterName.Squash = Squash
        EmitterName:SetAttribute( "StretchSize", nil )
        EmitterName:SetAttribute( "StretchSquash", nil )
    end

    local Entry2 = Table3[ EmitterName ]

    if Entry2 then
        local Size2 = EmitterName.Size
        local Squash2 = EmitterName.Squash
        Entry2.size = Size2
        Entry2.squash = Squash2
    end
end

for Key2, Value8 in workspace:GetDescendants( ) do
    TrackEmitter( Value8 )
end

workspace.DescendantAdded:Connect( TrackEmitter )
workspace.DescendantRemoving:Connect( UntrackEmitter )

local function SetParticles( Particles )
    if math.abs( Particles - Number ) < 0.0001 then
        return
    end

    local Value1
    Number = Particles
    Value1 = nil

    for Value in Table3, nil, nil do
        SetEmitter( Value, Particles )
    end
end

local function Width()
    if ClientState.FixedCamera or ClientState.WardrobeFocusX or ClientState.WardrobeOpen then
        return 1
    end

    local TestStretch2
    local TestStretch = LocalPlayer:GetAttribute( "TestStretch" )
    TestStretch2 = if TestStretch then TestStretch else Controls.Settings.Stretch
    local Clamp2
    local Number = tonumber( TestStretch2 ) or 1

    if Number == Number then
        local Clamp = math.clamp( Number, 0.75, 1 )

        if Clamp then
            Clamp2 = Clamp
        else
            Clamp2 = 1
        end
    else
        Clamp2 = 1
    end

    return Clamp2
end

local function Restore()
    if not Value1 then
        return
    end

    Value1 = nil
    Value6 = nil

    if Value1.CFrame == Value4 then
        Value1.CFrame = Value2
    end
    if Value1.FieldOfView == Value5 then
        Value1.FieldOfView = Value3
    end
end

RunService:BindToRenderStep( "StretchedRes", Enum.RenderPriority.Last.Value + 1, function()
    if Value1 then
        Value1 = nil
        Value6 = nil

        if Value1.CFrame == Value4 then
            Value1.CFrame = Value2
        end
        if Value1.FieldOfView == Value5 then
            Value1.FieldOfView = Value3
        end
    end

    local Number2
    local CurrentCamera = workspace.CurrentCamera

    if ClientState.FixedCamera or ClientState.WardrobeFocusX or ClientState.WardrobeOpen then
        Number2 = 1
    else
        local TestStretch2
        local TestStretch = LocalPlayer:GetAttribute( "TestStretch" )
        TestStretch2 = if TestStretch then TestStretch else Controls.Settings.Stretch
        local NumberInner = tonumber( TestStretch2 ) or 1

        if NumberInner == NumberInner then
            local Clamp = math.clamp( NumberInner, 0.75, 1 )

            if Clamp then
                Number2 = Clamp
            else
                Number2 = 1
            end
        else
            Number2 = 1
        end
    end
    if Number2 >= 0.999 or not CurrentCamera then
        Stretch.Factor = 1
        Value6 = nil

        if Flag2 then
            local Value2Inner
            Flag2 = false
            Value2Inner = nil

            for Key, Value3Inner in Table, nil, nil do
                RestoreOne( Key, Value3Inner )
            end
        end
        if not ( math.abs( 1 - Number ) < 0.0001 ) then
            local Value4Inner
            Number = 1
            Value4Inner = nil

            for Value5Inner in Table3, nil, nil do
                local Size = Value5Inner:GetAttribute( "StretchSize" )
                local Squash = Value5Inner:GetAttribute( "StretchSquash" )

                if Size then
                    Value5Inner.Size = Size
                    Value5Inner.Squash = Squash
                    Value5Inner:SetAttribute( "StretchSize", nil )
                    Value5Inner:SetAttribute( "StretchSquash", nil )
                end

                local Entry = Table3[ Value5Inner ]

                if Entry then
                    local Size2 = Value5Inner.Size
                    local Squash2 = Value5Inner.Squash
                    Entry.size = Size2
                    Entry.squash = Squash2
                end
            end
        end
        if Flag then
            Flag = false
            SoundService:SetListener( Enum.ListenerType.Camera )
        end

        return
    end
    Stretch.Factor = 1 / Number2
    PlaceBillboards( CurrentCamera, Number2 )

    if not ( math.abs( Number2 - Number ) < 0.0001 ) then
        local Value1Inner
        Number = Number2
        Value1Inner = nil

        for Value in Table3, nil, nil do
            SetEmitter( Value, Number2 )
        end
    end

    local CFrame2 = CurrentCamera.CFrame
    local FieldOfView = CurrentCamera.FieldOfView
    CurrentCamera.CFrame = CFrame2 * CFrame.new( 0, 0, 0, 1, 0, 0, 0, Number2, 0, 0, 0, 1 )
    CurrentCamera.FieldOfView = math.deg( math.atan( Number2 * math.tan( ( math.rad( FieldOfView / 2 ) ) ) ) * 2 )
    Value1 = CurrentCamera
    Value2 = CFrame2
    Value3 = FieldOfView
    local CFrame3 = CurrentCamera.CFrame
    local FieldOfView2 = CurrentCamera.FieldOfView
    Value4 = CFrame3
    Value5 = FieldOfView2
    SoundService:SetListener( Enum.ListenerType.CFrame, CFrame2 )
    Flag = true
    return
end )
RunService.PreSimulation:Connect( Restore )
