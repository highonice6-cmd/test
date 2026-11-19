-- Players.perkbrokeyou.PlayerScripts.SymbioteArmsClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local RunService = game:GetService( "RunService" )
local Class = setmetatable( { }, { __mode = "k" } )
local Class2 = setmetatable( { }, { __mode = "k" } )

local function SetArms( Character, Clamp )
    local UpperTorso = Character:FindFirstChild( "UpperTorso" )

    if not UpperTorso then
        return
    end

    local Value1
    local Table = { "Right", "Left" }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        local FoundChild = UpperTorso:FindFirstChild( Value .. "ShoulderRigAttachment" )

        if FoundChild and FoundChild:IsA( "Attachment" ) then
            if not Class2[ FoundChild ] then
                Class2[ FoundChild ] = FoundChild.CFrame
            end

            local Number
            local Entry = Class2[ FoundChild ]
            local Result = 0.10471975511965978 * Clamp
            Number = Value ~= "Right" and 1 or -1
            FoundChild.CFrame = Entry * CFrame.Angles( 0, 0, Result * Number )
        end
    end
end

RunService.Heartbeat:Connect( function( Argument1 )
    for Key, Value in Players:GetPlayers( ) do
        local Character = Value.Character

        if Character then
            local Flag = Character:GetAttribute( "Costume" ) == 24062303475423 and true or false
            local Entry = Class[ Character ] or 0

            if Flag or Entry ~= 0 then
                local Flag3
                local Humanoid = Character:FindFirstChildOfClass( "Humanoid" )
                local HumanoidRootPart = Character:FindFirstChild( "HumanoidRootPart" )

                if not Flag or not Humanoid or not HumanoidRootPart then
                    Flag3 = false
                else
                    local Flag2
                    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity

                    if Humanoid.MoveDirection.Magnitude > 0.1 then
                        local X = AssemblyLinearVelocity.X

                        if Vector3.new( X, 0, AssemblyLinearVelocity.Z ).Magnitude > 2 then
                            if Humanoid:GetState( ) == Enum.HumanoidStateType.Running then
                                Flag2 = not Character:FindFirstChildOfClass( "Tool" )
                            else
                                Flag2 = false
                            end
                        else
                            Flag2 = false
                        end
                    else
                        Flag2 = false
                    end

                    Flag3 = Flag2
                end

                local Number = not Flag3 and -1 or 1
                local Clamp = math.clamp( Entry + Number * 8 * Argument1, 0, 1 )

                if Clamp ~= Entry then
                    Class[ Character ] = Clamp
                    SetArms( Character, Clamp )
                end
            end
        end
    end
end )
