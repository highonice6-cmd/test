-- Players.perkbrokeyou.PlayerScripts.AvatarLodClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local ClientState = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local Table = {
    [ Enum.AccessoryType.Hair ] = true,
    [ Enum.AccessoryType.Hat ] = true,
    [ Enum.AccessoryType.Eyebrow ] = true,
    [ Enum.AccessoryType.Eyelash ] = true
}
local IsStudio = RunService:IsStudio( )
local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )
local Class3 = setmetatable( { }, { __mode = "k" } )

local function PartsOf( Key )
    local Entry = Class3[ Key ]

    if Entry ~= nil then
        return Entry
    end
    if not Table[ Key.AccessoryType ] then
        Class3[ Key ] = false
        return false
    end

    local TableInner = { }

    for Key2, Value in Key:GetDescendants( ) do
        if Value:IsA( "BasePart" ) or Value:IsA( "Decal" ) then
            table.insert( TableInner, Value )
        end
    end
    if #TableInner > 0 then
        Class3[ Key ] = TableInner
    end

    return TableInner
end

local function SetFar( Model, Argument2 )
    for Key, Value in Model:GetChildren( ) do
        if Value:IsA( "Accessory" ) then
            local PartsOf2 = PartsOf( Value )

            if PartsOf2 then
                local Value2 = nil

                for Key2, Value3 in PartsOf2, nil, nil do
                    if Argument2 then
                        if Value3.LocalTransparencyModifier ~= 1 then
                            Value3.LocalTransparencyModifier = 1
                        end

                        Class[ Value3 ] = true
                    elseif Class[ Value3 ] then
                        Class[ Value3 ] = nil

                        if Value3.LocalTransparencyModifier == 1 then
                            Value3.LocalTransparencyModifier = 0
                        end
                    end
                end
            end
        end
    end
end

local Number = 2

local function Consider( Model, Position, Tan, Argument4 )
    local Head2
    local Head = Model:FindFirstChild( "Head" )
    Head2 = if Head then Head else Model.PrimaryPart

    if not Head2 or not Head2:IsA( "BasePart" ) then
        return
    end

    local Flag
    local Magnitude = ( Head2.Position - Position ).Magnitude * Tan
    Flag = Class2[ Model ] == true and true or false
    local IsMissing2
    local IsMissing = not Argument4

    if IsMissing then
        if Magnitude > 300 then
            IsMissing2 = true
        elseif Flag then
            if Magnitude > 270 then
                IsMissing2 = true
            else
                IsMissing2 = false
            end
        else
            IsMissing2 = Flag
        end
    else
        IsMissing2 = IsMissing
    end
    if IsMissing2 ~= Flag then
        if Number <= 0 then
            if Flag then
                SetFar( Model, true )
            end

            return
        end
        Number = Number - 1
    end
    if IsMissing2 then
        Class2[ Model ] = true
        SetFar( Model, true )
        return
    end
    if Flag then
        Class2[ Model ] = nil
        SetFar( Model, false )
    end
end

local Number2 = 0
RunService.Heartbeat:Connect( function( Argument1 )
    Number2 = Number2 + Argument1

    if Number2 < 0.25 then
        return
    end

    Number2 = 0
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Flag
    local Position = CurrentCamera.CFrame.Position
    local Tan = math.tan( ( math.rad( math.clamp( CurrentCamera.FieldOfView, 1, 120 ) / 2 ) ) ) / 0.7002075382097097
    Flag = ClientState.Scoped == true and true or false
    Number = 2
    local Table = { }

    for Key, Value in Players:GetPlayers( ) do
        if Value ~= LocalPlayer and Value.Character and Value.Character.Parent then
            table.insert( Table, Value.Character )
        end
    end
    if IsStudio and workspace:GetAttribute( "TestAvatarLod" ) == true then
        local Dummies = workspace:FindFirstChild( "Dummies" )

        if Dummies then
            for Key2, Value2 in Dummies:GetChildren( ) do
                if Value2:IsA( "Model" ) and Value2:FindFirstChildOfClass( "Humanoid" ) then
                    table.insert( Table, Value2 )
                end
            end
        end
    end
    if Flag and #Table > 1 then
        local Value1
        local LookVector = CurrentCamera.CFrame.LookVector
        local Table2 = { }
        Value1 = nil

        for Key3, Value3 in Table, nil, nil do
            local Head2
            local Head = Value3:FindFirstChild( "Head" )
            Head2 = if Head then Head else Value3.PrimaryPart
            local Position3

            if not Head2 or not Head2:IsA( "BasePart" ) then
                Position3 = nil
            else
                local Position2 = Head2.Position - Position

                if Position2 then
                    Position3 = Position2
                else
                    Position3 = nil
                end
            end

            local Dot2

            if not Position3 or not ( Position3.Magnitude > 0 ) then
                Dot2 = -2
            else
                local Dot = Position3.Unit:Dot( LookVector )

                if Dot then
                    Dot2 = Dot
                else
                    Dot2 = -2
                end
            end

            Table2[ Value3 ] = Dot2
        end

        table.sort( Table, function( Key, Key2 )
            local Flag
            local Entry = Table2[ Key ]
            Flag = Table2[ Key2 ] < Entry and true or false
            return Flag
        end )
    end

    local Value4 = nil

    for Key4, Value5 in Table, nil, nil do
        Consider( Value5, Position, Tan, Flag )
    end
end )
