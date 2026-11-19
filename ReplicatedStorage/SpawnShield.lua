-- ReplicatedStorage.SpawnShield
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Table = { ATTR = "SpawnShield", REMOTE = "SpawnShieldEnd", MOVE_LIMIT = 4 }
local IsServer = RunService:IsServer( )
function Table.Active( Object )
    local Attribute

    if Object then
        Attribute = Object:GetAttribute( Table.ATTR )
    else
        Attribute = Object
    end
    if Attribute == true then
        return true
    end

    local Flag

    if type( Attribute ) == "number" then
        if workspace:GetServerTimeNow( ) < Attribute then
            Flag = true
        else
            Flag = false
        end
    else
        Flag = false
    end

    return Flag
end
function Table.End( Object )
    if IsServer and Object and Object:GetAttribute( Table.ATTR ) ~= nil then
        Object:SetAttribute( Table.ATTR, nil )
    end
end

if IsServer then
    local FoundChild2
    local Parent = ReplicatedStorage:WaitForChild( "Remotes" )
    local FoundChild = Parent:FindFirstChild( Table.REMOTE )

    if FoundChild then
        FoundChild2 = FoundChild
    else
        local RemoteEvent = Instance.new( "RemoteEvent" )
        RemoteEvent.Name = Table.REMOTE
        RemoteEvent.Parent = Parent
        FoundChild2 = RemoteEvent
    end

    FoundChild2.OnServerEvent:Connect( function( Argument1 )
        local Character = Argument1.Character

        if Character and Character:GetAttribute( Table.ATTR ) == true then
            Character:SetAttribute( Table.ATTR, nil )
        end
    end )
end

function Table.Give( Object, Text )
    if typeof( Object ) ~= "Instance" or not IsServer then
        return
    end
    if tonumber( Text ) then
        local ServerTimeNow = workspace:GetServerTimeNow( ) + tonumber( Text )
        Object:SetAttribute( Table.ATTR, ServerTimeNow )
        task.delay( tonumber( Text ) + 0.05, function()
            if Object.Parent and Object:GetAttribute( Table.ATTR ) == ServerTimeNow then
                Object:SetAttribute( Table.ATTR, nil )
            end
        end )
        return
    end
    Object:SetAttribute( Table.ATTR, true )
    task.spawn( function()
        local HumanoidRootPart = Object:FindFirstChild( "HumanoidRootPart" )

        if not HumanoidRootPart then
            return
        end

        local Position = HumanoidRootPart.Position

        while Object.Parent do
            if Object:GetAttribute( Table.ATTR ) ~= true then
                break
            end

            task.wait( 0.25 )
            local Position2 = HumanoidRootPart.Position - Position
            local Magnitude = Vector2.new( Position2.X, Position2.Z ).Magnitude

            if not ( Table.MOVE_LIMIT < Magnitude ) then
                local Abs = math.abs( Position2.Y )

                if not ( Table.MOVE_LIMIT + 4 < Abs ) then
                    continue
                end
            end
            if Object:GetAttribute( Table.ATTR ) == true then
                Object:SetAttribute( Table.ATTR, nil )
                return
            end
            break
        end
    end )
    return
end
return Table
