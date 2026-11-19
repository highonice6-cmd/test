-- ReplicatedStorage.CashPacks
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    List = {
        { id = "Cash1M", Amount = 1000000, ProductId = 3720338572 },
        { id = "Cash10M", Amount = 10000000, ProductId = 3720338695 },
        { id = "Cash100M", Amount = 100000000, ProductId = 3720338896 }
    }
}
function Table.Find( Argument1 )
    local Value1
    local List = Table.List
    Value1 = nil

    for Key, Value in List, nil, nil do
        if Value.id == Argument1 then
            return Value
        end
    end

    return nil
end
return Table
