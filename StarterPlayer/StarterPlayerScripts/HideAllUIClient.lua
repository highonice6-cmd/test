-- StarterPlayer.StarterPlayerScripts.HideAllUIClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #5

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

local Flag = math.abs( Amount - 0.0009765625 ) < 1e-06 and true or false
return Flag
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

if Upvalue1 then
    local Flag = math.abs( Upvalue2.MaxDistance - 0.0009765625 ) < 1e-06 and true or false

    if not Flag then
        Upvalue3[ Upvalue2 ] = Upvalue2.MaxDistance
        Upvalue2.MaxDistance = 0.0009765625
    end
end
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 then
    return
end
if not Parent:IsA( "ScreenGui" ) then
    if Parent:IsA( "BillboardGui" ) then
        if Upvalue4[ Parent ] ~= nil then
            return
        end

        local Flag
        local MaxDistance = Parent.MaxDistance
        Flag = math.abs( MaxDistance - 0.0009765625 ) < 1e-06 and true or false
        local Entry

        if Flag then
            Entry = Upvalue5[ Parent.Name ] or math.huge
        else
            Upvalue5[ Parent.Name ] = Upvalue5[ Parent.Name ] or MaxDistance
            Entry = MaxDistance
        end

        Upvalue4[ Parent ] = Entry
        Parent.MaxDistance = 0.0009765625
        table.insert( Upvalue6, Parent:GetPropertyChangedSignal( "MaxDistance" ):Connect( function()
            if Upvalue1 then
                local Flag = math.abs( Parent.MaxDistance - 0.0009765625 ) < 1e-06 and true or false

                if not Flag then
                    Upvalue4[ Parent ] = Parent.MaxDistance
                    Parent.MaxDistance = 0.0009765625
                end
            end
        end ) )
    end

    return
end
if Upvalue2[ Parent.Name ] then
    return
end

local HideAllUI = Parent:FindFirstChild( "HideAllUI" )

if not HideAllUI or not HideAllUI:IsA( "UIScale" ) then
    local UIScale = Instance.new( "UIScale" )
    UIScale.Name = "HideAllUI"
    UIScale.Scale = 0
    UIScale.Parent = Parent
    table.insert( Upvalue3, UIScale )
    return
end
return
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if Hidden == Upvalue1 then
    return
end

Upvalue1 = Hidden

if Hidden then
    local Value1
    local Table = { Upvalue2, workspace }
    Value1 = nil

    for Key, Value in Table, nil, nil do
        for Key3, Value3 in Value:GetDescendants( ) do
            Upvalue3( Value3 )
        end

        table.insert( Upvalue4, Value.DescendantAdded:Connect( Upvalue3 ) )
    end
    for Key2, Value2 in Enum.CoreGuiType:GetEnumItems( ) do
        if Value2 ~= Enum.CoreGuiType.All and Upvalue5:GetCoreGuiEnabled( Value2 ) then
            Upvalue6[ Value2 ] = true
            Upvalue5:SetCoreGuiEnabled( Value2, false )
        end
    end

    Upvalue7 = pcall( Upvalue5.SetCore, Upvalue5, "TopbarEnabled", false )
    return
end
local Value4 = nil

for Key4, Value5 in Upvalue4, nil, nil do
    Value5:Disconnect( )
end

local Value6
table.clear( Upvalue4 )
Value6 = nil

for Key5, Value7 in Upvalue8, nil, nil do
    Value7:Destroy( )
end

local Value8
table.clear( Upvalue8 )
Value8 = nil

for Key6, Value9 in Upvalue9, nil, nil do
    if Key6.Parent then
        local Flag = math.abs( Key6.MaxDistance - 0.0009765625 ) < 1e-06 and true or false

        if Flag then
            Key6.MaxDistance = Value9
        end
    end
end

local Value10
table.clear( Upvalue9 )
table.clear( Upvalue10 )
Value10 = nil

for Value11 in Upvalue6, nil, nil do
    Upvalue5:SetCoreGuiEnabled( Value11, true )
end

table.clear( Upvalue6 )

if Upvalue7 then
    pcall( Upvalue5.SetCore, Upvalue5, "TopbarEnabled", true )
    Upvalue7 = false
end

return
]]

--[[
Function #4 has no emitted closure site
It is reproduced here so that nothing is lost

if Argument2 then
    return
end
if Upvalue1.Is( "HideUI", Argument1 ) then
    Upvalue2( not Upvalue3 )
end
]]
