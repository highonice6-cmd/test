-- ReplicatedStorage.SecretFX
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    BLACK = Color3.fromRGB( 12, 12, 14 ),
    LIGHT = Color3.fromRGB( 225, 228, 240 ),
    IsRed = function( Argument1 )
        if typeof( Argument1 ) ~= "Color3" then
            return false
        end

        local Flag
        local ToHSV, ToHSV2, ToHSV3 = Argument1:ToHSV( )

        if ToHSV2 > 0.45 then
            if ToHSV3 > 0.25 then
                if ToHSV < 0.05 then
                    Flag = true
                elseif ToHSV > 0.93 then
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

        return Flag
    end
}

local function SeqRed( Argument1 )
    local Value1
    local Keypoints = Argument1.Keypoints
    Value1 = nil

    for Key, Value in Keypoints, nil, nil do
        if Table.IsRed( Value.Value ) then
            return true
        end
    end

    return false
end

local function BlackSeq( Argument1 )
    local Value1
    local TableInner = { }
    local Keypoints = Argument1.Keypoints
    Value1 = nil

    for Key, Value in Keypoints, nil, nil do
        table.insert( TableInner, ColorSequenceKeypoint.new( Value.Time, Table.BLACK ) )
    end

    return ColorSequence.new( TableInner )
end

function Table.One( p1, p2 )
    -- Could not structure function #4
end
function Table.Apply( Object, Argument2 )
    Table.One( Object, Argument2 )

    for Key, Value in Object:GetDescendants( ) do
        Table.One( Value, Argument2 )
    end
end
function Table.Watch( Argument1, Argument2 )
    return Argument1.DescendantAdded:Connect( function( Argument1 )
        task.defer( function()
            if Argument1.Parent then
                Table.One( Argument1, Argument2 )
            end
        end )
    end )
end
return Table

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1.LightInfluence = 0
]]
