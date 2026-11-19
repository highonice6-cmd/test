-- StarterPlayer.PlayerModule.ServerAuthority
-- Class: ModuleScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

-- Could not structure function #4

--[[
Function #0 has no emitted closure site
It is reproduced here so that nothing is lost

Upvalue1:SetPredictionMode( Object:WaitForChild( "HumanoidRootPart" ), Enum.PredictionMode.On )
]]

--[[
Function #1 has no emitted closure site
It is reproduced here so that nothing is lost

local function Callback( Object )
    Upvalue1:SetPredictionMode( Object:WaitForChild( "HumanoidRootPart" ), Enum.PredictionMode.On )
end

if Upvalue2.LocalPlayer.Character then
    Upvalue1:SetPredictionMode( Upvalue2.LocalPlayer.Character:WaitForChild( "HumanoidRootPart" ), Enum.PredictionMode.On )
    return
end
Upvalue2.LocalPlayer.CharacterAdded:Connect( Callback )
return
]]

--[[
Function #2 has no emitted closure site
It is reproduced here so that nothing is lost

Argument1.isServerAuthority = Upvalue1
]]

--[[
Function #3 has no emitted closure site
It is reproduced here so that nothing is lost

if not Upvalue1 and Upvalue2:IsClient( ) then
    Upvalue3.PredictLocalHumanoid( )
end
if not Upvalue4.data.inputsSetupComplete and Upvalue2:IsServer( ) then
    Upvalue4:subscribe( "INPUTS_SETUP" ):Wait( )
end

Upvalue5:InitializeServerAuthority( )
Upvalue6 = true
]]
