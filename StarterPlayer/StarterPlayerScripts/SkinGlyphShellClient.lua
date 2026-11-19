-- StarterPlayer.StarterPlayerScripts.SkinGlyphShellClient
-- Class: LocalScript

--[[
    Decompiled by Lucid
    The decompiler hasn't been fully polished, you may experience issues with output.
    Report any output issues to us via a ticket using the dashboard or our Discord server.
    Discord Server: https://getlucid.gg/discord
]]

local Players = game:GetService( "Players" )
local CollectionService = game:GetService( "CollectionService" )
local ClientState = require( game:GetService( "ReplicatedStorage" ):WaitForChild( "Weapons" ):WaitForChild( "ClientState" ) )
local LocalPlayer = Players.LocalPlayer
local Table = {
    Enum.NormalId.Front,
    Enum.NormalId.Back,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Top
}
local Occluded = Enum.HighlightDepthMode.Occluded
local Parent = workspace:WaitForChild( "FX" )
local Folder = Instance.new( "Folder" )
Folder.Name = "GlyphShells"
Folder.Parent = Parent
local Table2 = { }
local Table3 = { }
local ResyncTwins = nil
local WatchChar = nil

local function CharOf( Argument1 )
    return Argument1:FindFirstAncestorWhichIsA( "Model" )
end

local function Textures( Parent, Texture, StudsPerTileU )
    local Value1 = nil

    for Key, Value in Table, nil, nil do
        local Texture2 = Instance.new( "Texture" )
        Texture2.Name = "SkinGlyph"
        Texture2.Texture = Texture
        Texture2.Face = Value
        Texture2.StudsPerTileU = StudsPerTileU
        Texture2.StudsPerTileV = StudsPerTileU
        Texture2.Parent = Parent
    end
end

local function ModelFor( ForName )
    local Entry = Table3[ ForName ]

    if Entry then
        return Entry
    end

    local Model = Instance.new( "Model" )
    Model.Name = ForName.Name
    Model.Parent = Folder
    local Table = { model = Model, n = 0 }
    Table3[ ForName ] = Table

    if WatchChar then
        Table.conn = WatchChar( ForName )
    end

    return Table
end

local function Unbuild( Argument1, Argument2 )
    local Value1
    local Conns = Argument2.conns
    Value1 = nil

    for Key, Value in Conns, nil, nil do
        Value:Disconnect( )
    end

    table.clear( Argument2.conns )

    if Argument2.shell then
        Argument2.shell:Destroy( )
        Argument2.shell = nil
        local Entry = Table3[ Argument2.char ]

        if Entry then
            Entry.n = Entry.n - 1

            if Entry.n <= 0 then
                if Entry.conn then
                    Entry.conn:Disconnect( )
                end

                Entry.model:Destroy( )
                Table3[ Argument2.char ] = nil
                ResyncTwins( )
            end
        end
    end
end

local function Build( Part0, Argument2 )
    local SkinGlyph = Part0:GetAttribute( "SkinGlyph" )

    if type( SkinGlyph ) ~= "string" or SkinGlyph == "" or not Part0:IsDescendantOf( workspace ) then
        return
    end

    local Archivable = Part0.Archivable

    if not Archivable then
        Part0.Archivable = true
    end

    local Success, Part1 = pcall( Part0.Clone, Part0 )

    if not Archivable then
        Part0.Archivable = false
    end
    if not Success or not Part1 then
        return
    end

    Part1:ClearAllChildren( )

    for Key, Value in Part1:GetTags( ) do
        Part1:RemoveTag( Value )
    end
    for Value2 in Part1:GetAttributes( ) do
        if not Value2:match( "^RBX" ) then
            pcall( Part1.SetAttribute, Part1, Value2, nil )
        end
    end

    local Flag
    Part1.Anchored = false
    Part1.Massless = true
    Part1.CanCollide = false
    Part1.CanQuery = false
    Part1.CanTouch = false
    Part1.CastShadow = false
    Part1.Size = Part0.Size * 1.01
    Part1.Transparency = Part0.Transparency
    Part1.LocalTransparencyModifier = Part0.LocalTransparencyModifier
    Part1.CFrame = Part0.CFrame
    Textures( Part1, SkinGlyph, tonumber( Part0:GetAttribute( "SkinGlyphStuds" ) ) or 6 )
    local Weld = Instance.new( "Weld" )
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.Parent = Part1
    Flag = Table3[ Argument2.char ] == nil and true or false
    local ModelFor2 = ModelFor( Argument2.char )
    Part1.Parent = ModelFor2.model
    ModelFor2.n = ModelFor2.n + 1
    Argument2.shell = Part1

    local function Look()
        Part1.LocalTransparencyModifier = Part0.LocalTransparencyModifier
        Part1.Transparency = Part0.Transparency
    end

    local Conns = Argument2.conns
    table.insert( Conns, Part0:GetPropertyChangedSignal( "LocalTransparencyModifier" ):Connect( Look ) )
    local Conns2 = Argument2.conns
    table.insert( Conns2, Part0:GetPropertyChangedSignal( "Transparency" ):Connect( Look ) )
    local Conns3 = Argument2.conns
    table.insert( Conns3, Part0:GetPropertyChangedSignal( "Size" ):Connect( function()
        Part1.Size = Part0.Size * 1.01
    end ) )

    if Flag then
        ResyncTwins( )
    end
end

local function Drop( Key )
    local Entry = Table2[ Key ]

    if Entry then
        Table2[ Key ] = nil
        Unbuild( Key, Entry )
        return
    end
    return
end

local Class = setmetatable( { }, { __mode = "k" } )

local function Preview( Parent )
    if Class[ Parent ] then
        return
    end

    Class[ Parent ] = true
    local SkinGlyph = Parent:GetAttribute( "SkinGlyph" )

    if type( SkinGlyph ) == "string" and SkinGlyph ~= "" then
        Textures( Parent, SkinGlyph, tonumber( Parent:GetAttribute( "SkinGlyphStuds" ) ) or 6 )
    end
end

local function WantShell( Self, Argument2, Argument3, Argument4 )
    if Argument4 or not Self:IsDescendantOf( workspace ) then
        return false
    end
    if Argument2.char == LocalPlayer.Character then
        return true
    end
    if not Argument3 then
        return false
    end

    local Number
    local Magnitude = ( Self.Position - Argument3 ).Magnitude
    Number = not Argument2.shell and 160 or 190
    local Flag = Magnitude <= Number and true or false
    return Flag
end

local function OnHost( HostName )
    if not HostName:IsA( "BasePart" ) or Table2[ HostName ] then
        return
    end
    if HostName:IsDescendantOf( workspace ) then
        local Model = HostName:FindFirstAncestorWhichIsA( "Model" )

        if not Model then
            return
        end

        local CurrentCamera2
        local Table = { char = Model, shell = nil, conns = { } }
        Table2[ HostName ] = Table
        local CurrentCamera = workspace.CurrentCamera
        CurrentCamera2 = if CurrentCamera then CurrentCamera.CFrame.Position else CurrentCamera
        local Flag = ClientState.LightPlayers == true and true or false
        local Flag2

        if Flag or not HostName:IsDescendantOf( workspace ) then
            Flag2 = false
        elseif Table.char == LocalPlayer.Character then
            Flag2 = true
        elseif CurrentCamera2 then
            local Number
            local Magnitude = ( HostName.Position - CurrentCamera2 ).Magnitude
            Number = not Table.shell and 160 or 190

            if Magnitude <= Number then
                Flag2 = true
            else
                Flag2 = false
            end
        else
            Flag2 = false
        end
        if Flag2 then
            local Success, Result = pcall( Build, HostName, Table )

            if not Success then
                Table.failed = true
                warn( "[SkinGlyphShell] " .. tostring( Result ) )
            end
        end

        return
    end
    if HostName:FindFirstAncestorWhichIsA( "ViewportFrame" ) then
        if Class[ HostName ] then
            return
        end

        Class[ HostName ] = true
        local SkinGlyph = HostName:GetAttribute( "SkinGlyph" )

        if type( SkinGlyph ) == "string" and SkinGlyph ~= "" then
            Textures( HostName, SkinGlyph, tonumber( HostName:GetAttribute( "SkinGlyphStuds" ) ) or 6 )
        end
    end

    return
end

local Folder2 = Instance.new( "Folder" )
Folder2.Name = "GlyphTwins"
Folder2.Parent = Parent
local Table4 = { }

local function TargetOf( Argument1 )
    local Adornee = Argument1.Adornee

    if Adornee then
        return Adornee
    end

    local Parent2
    local Parent = Argument1.Parent
    Parent2 = Parent and Parent:IsA( "Model" ) and Parent or nil
    return Parent2
end

local function SyncTwin( TwinName )
    local Entry = Table4[ TwinName ]

    if Entry == nil then
        return
    end

    local Parent3
    local Parent = TwinName.Parent

    if Parent then
        local Adornee = TwinName.Adornee

        if Adornee then
            Parent3 = Adornee
        else
            local Parent2 = TwinName.Parent

            if not Parent2 or not Parent2:IsA( "Model" ) or not Parent2 then
                Parent3 = nil
            else
                Parent3 = Parent2
            end
        end
    else
        Parent3 = Parent
    end

    local Parent4 = if Parent3 then Table3[ Parent3 ] else Parent3

    if not Parent4 or not TwinName.Enabled or TwinName.DepthMode ~= Occluded or not TwinName:IsDescendantOf( workspace ) then
        if Entry then
            Entry:Destroy( )
            Table4[ TwinName ] = false
        end

        return
    end
    local Entry2

    if Entry then
        Entry2 = Entry
    else
        local Highlight = Instance.new( "Highlight" )
        Highlight.Name = "GlyphTwin"
        Highlight:AddTag( "OwnFX" )
        Table4[ TwinName ] = Highlight
        Entry2 = Highlight
    end

    local FillColor = TwinName.FillColor
    local FillTransparency = TwinName.FillTransparency
    Entry2.FillColor = FillColor
    Entry2.FillTransparency = FillTransparency
    local OutlineColor = TwinName.OutlineColor
    local OutlineTransparency = TwinName.OutlineTransparency
    Entry2.OutlineColor = OutlineColor
    Entry2.OutlineTransparency = OutlineTransparency
    Entry2.DepthMode = Occluded
    Entry2.Adornee = Parent4.model
    Entry2.Enabled = true
    Entry2.Parent = Folder2
    return
end

ResyncTwins = function()
    local Value1 = nil

    for Value in Table4, nil, nil do
        SyncTwin( Value )
    end
end

local Table5 = {
    "Adornee",
    "Enabled",
    "FillColor",
    "FillTransparency",
    "OutlineColor",
    "OutlineTransparency",
    "DepthMode",
    "Parent"
}

local function Watch( TwinName )
    if Table4[ TwinName ] ~= nil or TwinName:IsDescendantOf( Folder2 ) then
        return
    end

    local Value1
    Table4[ TwinName ] = false
    Value1 = nil

    for Key2, Value in Table5, nil, nil do
        TwinName:GetPropertyChangedSignal( Value ):Connect( function()
            SyncTwin( TwinName )
        end )
    end

    TwinName.Destroying:Connect( function()
        local Entry = Table4[ TwinName ]

        if Entry then
            Entry:Destroy( )
        end

        Table4[ TwinName ] = nil
    end )
    SyncTwin( TwinName )
end

local function OnMaybeHighlight( TwinName )
    if TwinName:IsA( "Highlight" ) then
        Watch( TwinName )
    end
end

local Value1 = nil

local function WatchCamera()
    if Value1 then
        Value1:Disconnect( )
        Value1 = nil
    end

    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    Value1 = CurrentCamera.DescendantAdded:Connect( OnMaybeHighlight )

    for Key, Value in CurrentCamera:GetDescendants( ) do
        if Value:IsA( "Highlight" ) then
            Watch( Value )
        end
    end
end

workspace:GetPropertyChangedSignal( "CurrentCamera" ):Connect( WatchCamera )
WatchCamera( )

WatchChar = function( Self )
    for Key, Value in Self:GetDescendants( ) do
        if Value:IsA( "Highlight" ) then
            Watch( Value )
        end
    end

    return Self.DescendantAdded:Connect( OnMaybeHighlight )
end

CollectionService:GetInstanceAddedSignal( "SkinGlyphHost" ):Connect( OnHost )
CollectionService:GetInstanceRemovedSignal( "SkinGlyphHost" ):Connect( Drop )

for Key, Value in CollectionService:GetTagged( "SkinGlyphHost" ) do
    task.spawn( OnHost, Value )
end
while true do
    local CurrentCamera2
    task.wait( 0.5 )
    local CurrentCamera = workspace.CurrentCamera
    CurrentCamera2 = if CurrentCamera then CurrentCamera.CFrame.Position else CurrentCamera
    local Flag2 = ClientState.LightPlayers == true and true or false
    local Value2 = nil

    for Key2, Value3 in Table2, nil, nil do
        if Key2.Parent then
            local Flag

            if Flag2 or not Key2:IsDescendantOf( workspace ) then
                Flag = false
            elseif Value3.char == LocalPlayer.Character then
                Flag = true
            elseif CurrentCamera2 then
                local Number
                local Magnitude = ( Key2.Position - CurrentCamera2 ).Magnitude
                Number = not Value3.shell and 160 or 190

                if Magnitude <= Number then
                    Flag = true
                else
                    Flag = false
                end
            else
                Flag = false
            end
            if not Flag or Value3.shell or Value3.failed then
                if not Flag and Value3.shell then
                    pcall( Unbuild, Key2, Value3 )
                end
            else
                local Success, Result = pcall( Build, Key2, Value3 )

                if not Success then
                    Value3.failed = true
                    warn( "[SkinGlyphShell] " .. tostring( Result ) )
                end
            end
        else
            local Entry = Table2[ Key2 ]

            if Entry then
                Table2[ Key2 ] = nil
                Unbuild( Key2, Entry )
            end
        end
    end
end
