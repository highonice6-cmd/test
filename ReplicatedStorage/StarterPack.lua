-- ReplicatedStorage.StarterPack
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Table = {
    PassId = 2041604814,
    ProductId = 0,
    TEST_PRODUCT = 990099,
    Price = 99,
    Weapon = "M60",
    Car = "Cayen",
    CarName = "Cayen",
    CarVersion = 2,
    Cash = 50000,
    Name = "Starter Pack",
    BonusHours = 24,
    BonusCash = 25000
}
function Table.Product( Argument1 )
    if Table.ProductId > 0 then
        return Table.ProductId
    end

    local TEST_PRODUCT2

    if Argument1 then
        local TEST_PRODUCT = Table.TEST_PRODUCT

        if TEST_PRODUCT then
            TEST_PRODUCT2 = TEST_PRODUCT
        else
            TEST_PRODUCT2 = 0
        end
    else
        TEST_PRODUCT2 = 0
    end

    return TEST_PRODUCT2
end
return Table
