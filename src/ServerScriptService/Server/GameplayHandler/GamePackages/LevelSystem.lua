local module = {}

module.Enabled = true

--/ Services /--
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

--/ Modules /--
local Modules = {}
for _, module in pairs(script:GetChildren()) do
    Modules[module.Name] = require(module)
end

for _, global in pairs(script.Parent.Parent.Parent:GetChildren()) do
    if global.Name == script.Parent.Name or global.Name == script.Parent.Parent.Name or global:IsA("PackageLink") then continue end
    Modules[global.Name] = require(global)
end

--/ Private Variables /--
local MinimumExperience = 100

--/ Private Functions /--
local function GetRequiredExperience(LEVEL)
    return ( LEVEL^2 ) * MinimumExperience * 0.5 + LEVEL * MinimumExperience + MinimumExperience
end

--/ Public Functions /--
function module:Start()
    Players.PlayerAdded:Connect(function(player)
        local PLAYER_LEVEL = Modules.DataHandler.GetDataOfSpecificType(player, "Level")
        local EXP = GetRequiredExperience(PLAYER_LEVEL)
    end)
end

return module