-- ReplicatedStorage.Weapons.HitResolve
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    [ Enum.AccessoryType.Hat ] = true,
    [ Enum.AccessoryType.Hair ] = true,
    [ Enum.AccessoryType.Face ] = true,
    [ Enum.AccessoryType.Eyebrow ] = true,
    [ Enum.AccessoryType.Eyelash ] = true
}
return {
    BodyPart = function( Object )
        local Parent, Children, Children2, Children3, Handle2, Accessory2, Value1
        local Accessory = Object:FindFirstAncestorOfClass( "Accessory" )

        if not Accessory then
            return Object
        end

        Parent = Accessory.Parent
        local Handle = Accessory:FindFirstChild( "Handle" ) or Object

        local function OnBody( Object )
            local IsA2

            if Object then
                local IsA = Object:IsA( "BasePart" )

                if IsA then
                    if Object == Handle then
                        IsA2 = false
                    else
                        local NotIsDescendantOf = not Object:IsDescendantOf( Accessory )

                        if NotIsDescendantOf then
                            if Object:FindFirstAncestorOfClass( "Accessory" ) == nil then
                                IsA2 = true
                            else
                                IsA2 = false
                            end
                        else
                            IsA2 = NotIsDescendantOf
                        end
                    end
                else
                    IsA2 = IsA
                end
            else
                IsA2 = Object
            end

            return IsA2
        end

        Children, Children2, Children3 = Handle:GetChildren( )
        Handle2 = Handle
        Accessory2 = Accessory
        Value1 = Object

        for Key, Value in Children, Children2, Children3 do
            if Value:IsA( "JointInstance" ) or Value:IsA( "WeldConstraint" ) then
                local Part1 = Value.Part0 == Handle2 and Value.Part1 or Value.Part0
                local Part12

                if Part1 then
                    local IsA5 = Part1:IsA( "BasePart" )

                    if IsA5 then
                        if Part1 == Handle2 then
                            Part12 = false
                        else
                            local NotIsDescendantOf3 = not Part1:IsDescendantOf( Accessory2 )

                            if NotIsDescendantOf3 then
                                if Part1:FindFirstAncestorOfClass( "Accessory" ) == nil then
                                    Part12 = true
                                else
                                    Part12 = false
                                end
                            else
                                Part12 = NotIsDescendantOf3
                            end
                        end
                    else
                        Part12 = IsA5
                    end
                else
                    Part12 = Part1
                end
                if Part12 then
                    return Part1
                end
                Children3 = Key
            elseif Value:IsA( "RigidConstraint" ) then
                local Value4
                local TableInner = { Value.Attachment0, Value.Attachment1 }
                Value4 = nil

                for Key4, Value5 in TableInner, nil, nil do
                    if Value5 then
                        local Parent3
                        local Parent2 = Value5.Parent

                        if Parent2 then
                            local IsA4 = Parent2:IsA( "BasePart" )

                            if IsA4 then
                                if Parent2 == Handle2 then
                                    Parent3 = false
                                else
                                    local NotIsDescendantOf2 = not Parent2:IsDescendantOf( Accessory2 )

                                    if NotIsDescendantOf2 then
                                        if Parent2:FindFirstAncestorOfClass( "Accessory" ) == nil then
                                            Parent3 = true
                                        else
                                            Parent3 = false
                                        end
                                    else
                                        Parent3 = NotIsDescendantOf2
                                    end
                                end
                            else
                                Parent3 = IsA4
                            end
                        else
                            Parent3 = Parent2
                        end
                        if Parent3 then
                            return Value5.Parent
                        end
                    end

                    Children3 = Key
                end

                Children3 = Key
            else
                Children3 = Key
            end
        end
        if Parent then
            for Key2, Value2 in Handle2:GetChildren( ) do
                if Value2:IsA( "Attachment" ) then
                    for Key3, Value3 in Parent:GetChildren( ) do
                        local FoundChild
                        local IsA = Value3:IsA( "BasePart" )

                        if IsA then
                            FoundChild = Value3:FindFirstChild( Value2.Name )
                        else
                            FoundChild = IsA
                        end
                        if FoundChild and FoundChild:IsA( "Attachment" ) then
                            local IsA3

                            if Value3 then
                                local IsA2 = Value3:IsA( "BasePart" )

                                if IsA2 then
                                    if Value3 == Handle2 then
                                        IsA3 = false
                                    else
                                        local NotIsDescendantOf = not Value3:IsDescendantOf( Accessory2 )

                                        if NotIsDescendantOf then
                                            if Value3:FindFirstAncestorOfClass( "Accessory" ) == nil then
                                                IsA3 = true
                                            else
                                                IsA3 = false
                                            end
                                        else
                                            IsA3 = NotIsDescendantOf
                                        end
                                    end
                                else
                                    IsA3 = IsA2
                                end
                            else
                                IsA3 = Value3
                            end
                            if IsA3 then
                                return Value3
                            end
                        end
                    end
                end
            end
        end
        if not Table[ Accessory2.AccessoryType ] or not Parent or not Parent:FindFirstChild( "Head" ) then
            return Value1
        end
        return Parent.Head
    end
}
