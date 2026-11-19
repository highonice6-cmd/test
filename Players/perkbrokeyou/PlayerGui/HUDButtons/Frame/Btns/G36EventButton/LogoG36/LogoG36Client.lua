-- Players.perkbrokeyou.PlayerGui.HUDButtons.Frame.Btns.G36EventButton.LogoG36.LogoG36Client
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Parent = script.Parent

local function Setup( Parent )
    if not Parent:IsA( "ViewportFrame" ) then
        return
    end

    local CFrame = Parent:GetAttribute( "CamCF" )

    if typeof( CFrame ) ~= "CFrame" then
        return
    end
    if not Parent.CurrentCamera or Parent.CurrentCamera.Parent ~= Parent then
        local CurrentCamera = Instance.new( "Camera" )
        CurrentCamera.FieldOfView = tonumber( Parent:GetAttribute( "FOV" ) ) or 20
        CurrentCamera.CFrame = CFrame
        CurrentCamera.Parent = Parent
        Parent.CurrentCamera = CurrentCamera
        return
    end
    return
end

for Key, Value in Parent:GetChildren( ) do
    Setup( Value )
end

Parent.ChildAdded:Connect( Setup )
