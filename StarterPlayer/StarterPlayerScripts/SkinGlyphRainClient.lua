-- StarterPlayer.StarterPlayerScripts.SkinGlyphRainClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local CollectionService = game:GetService( "CollectionService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local RunService = game:GetService( "RunService" )
local ClientState = require( ReplicatedStorage:WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = game:GetService( "Players" ).LocalPlayer
local Table = { }
local Table2 = { }

local function CharOf( Key )
    local Model = Key:FindFirstAncestorWhichIsA( "Model" )

    while Model do
        if Model:FindFirstChildOfClass( "Humanoid" ) then
            break
        end

        Model = Model:FindFirstAncestorWhichIsA( "Model" )
    end

    return Model
end

local function Added( Value )
    if not Value:IsA( "Texture" ) then
        return
    end

    local GlyphRain = Value:GetAttribute( "GlyphRain" )
    local CharOf2 = CharOf( Value )

    if type( GlyphRain ) ~= "number" or GlyphRain <= 0 or not CharOf2 then
        return
    end

    local Entry2
    local Entry = Table[ CharOf2 ]

    if Entry then
        Entry2 = Entry
    else
        local TableInner = { }
        Table[ CharOf2 ] = TableInner
        Entry2 = TableInner
    end

    Entry2[ Value ] = GlyphRain
end

local function Removed( Key )
    local Value1 = nil

    for Key2, Value in Table, nil, nil do
        if Value[ Key ] then
            Value[ Key ] = nil

            if next( Value ) == nil then
                Table[ Key2 ] = nil
                Table2[ Key2 ] = nil
            end

            return
        end
    end
end

CollectionService:GetInstanceAddedSignal( "SkinGlyph" ):Connect( Added )
CollectionService:GetInstanceRemovedSignal( "SkinGlyph" ):Connect( Removed )

for Key, Value in CollectionService:GetTagged( "SkinGlyph" ) do
    Added( Value )
end

local function Pick( Self )
    local Value1
    local Position = Self.CFrame.Position
    local ViewportSize = Self.ViewportSize
    local TableInner = { }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        if Key.Parent then
            local HumanoidRootPart2
            local HumanoidRootPart = Key:FindFirstChild( "HumanoidRootPart" )
            HumanoidRootPart2 = if HumanoidRootPart then HumanoidRootPart else Key.PrimaryPart
            local _, Value2 = next( Value )

            if HumanoidRootPart2 and Value2 then
                local Magnitude = ( HumanoidRootPart2.Position - Position ).Magnitude

                if Magnitude <= 60 then
                    local Flag
                    local WorldToViewportPoint = Self:WorldToViewportPoint( HumanoidRootPart2.Position )

                    if WorldToViewportPoint.Z > 0 then
                        if WorldToViewportPoint.X > -300 then
                            if WorldToViewportPoint.X < ViewportSize.X + 300 then
                                if WorldToViewportPoint.Y > -300 then
                                    if WorldToViewportPoint.Y < ViewportSize.Y + 300 then
                                        Flag = true
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
                            Flag = false
                        end
                    else
                        Flag = false
                    end
                    if Flag or Magnitude < 8 then
                        local Own
                        local Table3 = {
                            ch = Key,
                            set = Value,
                            root = HumanoidRootPart2,
                            row = Value2,
                            d = Magnitude
                        }
                        Own = Key == LocalPlayer.Character and true or false
                        Table3.own = Own
                        table.insert( TableInner, Table3 )
                    end
                end
            end
        else
            Table[ Key ] = nil
            Table2[ Key ] = nil
        end
    end
    if #TableInner > 6 then
        table.sort( TableInner, function( Argument1, Argument2 )
            local Flag = Argument1.d < Argument2.d and true or false
            return Flag
        end )
    end

    local Table2Inner = { }
    local Min = math.min( #TableInner, 6 )
    local I = 1

    for I = 1, Min do
        Table2Inner[ I ] = TableInner[ I ]
    end

    return Table2Inner
end

local Table3 = { }
local Number = 0
local Number2 = 0
local Number3 = -1000
local Number4 = 2
local Clock = os.clock( )
RunService.RenderStepped:Connect( function()
    Number2 = Number2 + 1
    local ClockInner = os.clock( )
    Number4 = math.min( 2, Number4 + ( ClockInner - Clock ) * 8 )
    Clock = ClockInner

    if next( Table ) == nil then
        return
    end

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end
    if Number <= ClockInner then
        local TableInner
        Number = ClockInner + 0.25

        if ClientState.LightPlayers == true then
            TableInner = { }
        else
            TableInner = Pick( CurrentCamera )
        end

        Table3 = TableInner
    end
    if Number4 < 1 or Number2 - Number3 < 3 or #Table3 == 0 then
        return
    end

    local Value1, Value2, Number2Inner
    local Y = CurrentCamera.ViewportSize.Y / 2 / math.tan( math.rad( CurrentCamera.FieldOfView ) / 2 )
    local Position = CurrentCamera.CFrame.Position
    Value1 = nil
    Value2 = nil
    Number2Inner = 1

    for Key, Value in Table3, nil, nil do
        if Value.root.Parent then
            local NumberInner
            local Max = math.max( ( Value.root.Position - Position ).Magnitude, 2 )
            local Clock2 = ( ClockInner - ( Table2[ Value.ch ] or 0 ) ) * 0.4 * Value.row * Y / Max
            NumberInner = not Value.own and 1.5 or 1
            local Clock3 = Clock2 / NumberInner

            if Number2Inner <= Clock3 then
                Value2 = Value
                Number2Inner = Clock3
            end
        end
    end
    if not Value2 then
        return
    end

    local Value3
    local Set = Value2.set
    Value3 = nil

    for Key2, Value4 in Set, nil, nil do
        Key2.OffsetStudsV = -ClockInner * 0.4 * Value4 % Key2.StudsPerTileV
    end

    Table2[ Value2.ch ] = ClockInner
    Number3 = Number2
    Number4 = Number4 - 1
end )
